import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_project/core/errors/error_view.dart';
import 'package:gemini_project/core/theme/theme.dart';
import 'package:gemini_project/features/profile/controller/profile_controller.dart';
import 'package:gemini_project/features/profile/model/channel_model.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ProfileView extends ConsumerWidget {
  final String channelId;
  const ProfileView({super.key, required this.channelId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final channelAsync = ref.watch(profileControllerProvider(channelId));

    return Scaffold(
      backgroundColor: const Color(
        0xFF1C1C1E,
      ), // Dark background color from the image
      body: channelAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error:
            (err, stack) => ErrorViewWidget(
              onRetry:
                  () => ref.invalidate(profileControllerProvider(channelId)),
            ),
        data: (channel) {
          return Stack(
            children: [
              // Background Image
              Positioned.fill(
                child: CachedNetworkImage(
                  imageUrl: channel.avatarUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(color: Colors.black),
                ),
              ),
              // Gradient Overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.8),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.4, 0.7],
                    ),
                  ),
                ),
              ),
              // Main Content Sheet
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                top: MediaQuery.of(context).size.height * 0.35,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF1C1C1E),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: ProfileContent(channel: channel),
                ),
              ),
              // Back Button
              Positioned(
                top: 50,
                left: 15,
                child: SafeArea(
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => context.pop(),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class ProfileContent extends StatelessWidget {
  final Channel channel;
  const ProfileContent({super.key, required this.channel});

  String _formatNumber(String numberString) {
    try {
      final number = int.parse(numberString);
      return NumberFormat.compact().format(number);
    } catch (e) {
      return '0';
    }
  }

  String _createHandle(String title) {
    return '@${title.toLowerCase().replaceAll(' ', '')}';
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
      child: DefaultTabController(
        length: 4,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Column(
                children: [
                  // Header: Name, Handle, Follow Button
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              channel.title,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _createHandle(channel.title),
                              style: const TextStyle(
                                fontSize: 16,
                                color: AppColors.secondaryText,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                        child: const Text(
                          'Follow',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Description
                  Text(
                    channel.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  const SizedBox(height: 20),
                  // Stats: Followers & Following
                  Row(
                    children: [
                      Expanded(
                        child: _FollowerCard(
                          label: 'followers',
                          count: _formatNumber(channel.subscriberCount),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: _FollowerCard(label: 'following', count: '156'),
                      ), // Placeholder
                    ],
                  ),
                ],
              ),
            ),
            // Content Tabs
            const TabBar(
              indicatorColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.label,
              labelColor: Colors.white,
              unselectedLabelColor: AppColors.secondaryText,
              tabs: [
                _TabIcon(
                  icon: Icons.grid_on_outlined,
                  count: '167',
                ), // Placeholder count
                _TabIcon(
                  icon: Icons.video_collection_outlined,
                  count: '79',
                ), // Placeholder count
                _TabIcon(
                  icon: Icons.bookmark_border,
                  count: '38',
                ), // Placeholder count
                _TabIcon(
                  icon: Icons.person_pin_outlined,
                  count: '44',
                ), // Placeholder count
              ],
            ),
            // Tab Content
            Expanded(
              child: TabBarView(
                children: [
                  // Grid of Videos
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 4,
                          ),
                      itemCount: channel.videos.length,
                      itemBuilder: (context, index) {
                        final video = channel.videos[index];
                        return GestureDetector(
                          onTap: () => context.push('/player/${video.videoId}'),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              imageUrl: video.thumbnailUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // Placeholder for other tabs
                  const Center(
                    child: Text(
                      'Coming Soon',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const Center(
                    child: Text(
                      'Coming Soon',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const Center(
                    child: Text(
                      'Coming Soon',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FollowerCard extends StatelessWidget {
  final String label;
  final String count;
  const _FollowerCard({required this.label, required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stacked profile pictures (placeholders)
          Row(
            children: [
              CircleAvatar(radius: 12, backgroundColor: Colors.red.shade300),
              Transform.translate(
                offset: const Offset(-8, 0),
                child: CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.blue.shade300,
                ),
              ),
              Transform.translate(
                offset: const Offset(-16, 0),
                child: CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.yellow.shade300,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            count,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(label, style: const TextStyle(color: AppColors.secondaryText)),
        ],
      ),
    );
  }
}

class _TabIcon extends StatelessWidget {
  final IconData icon;
  final String count;
  const _TabIcon({required this.icon, required this.count});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Icon(icon, size: 20), const SizedBox(width: 8), Text(count)],
      ),
    );
  }
}
