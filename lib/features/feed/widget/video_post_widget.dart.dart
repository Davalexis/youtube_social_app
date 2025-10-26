import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gemini_project/features/feed/model/video_post_model.dart';
import 'dart:math' as math;
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

class VideoPostWidget extends StatelessWidget {
  final VideoPost video;
  const VideoPostWidget({super.key, required this.video});

  // Helper to format large numbers (e.g., 546,000 -> 546K)
  String _formatNumber(String numberString) {
    try {
      final number = int.parse(numberString);
      return NumberFormat.compact().format(number);
    } catch (e) {
      return '0';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background Video Thumbnail
        GestureDetector(
          onTap: () => context.push('/player/${video.videoId}'),
          child: CachedNetworkImage(
            imageUrl: video.thumbnailUrl,

            placeholder: (context, url) => Container(color: Colors.black),
            errorWidget:
                (context, url, error) => const HugeIcon(
                  icon: HugeIcons.strokeRoundedEuro,
                  size: 50,
                  color: Colors.white,
                ),
          ),
        ),
        // UI Overlay
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _TopBar(),
              _BottomSection(video: video, formatNumber: _formatNumber),
            ],
          ),
        ),
      ],
    );
  }
}

class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // IconButton(
          //   onPressed: () {},
          //   icon: const HugeIcon(icon: HugeIcons.strokeRoundedNotification01, size: 28),
          // ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'For You',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                const Text('Followed'),
              ],
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const HugeIcon(
              icon: HugeIcons.strokeRoundedMoreHorizontal,
              size: 28,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomSection extends StatelessWidget {
  final VideoPost video;
  final String Function(String) formatNumber;

  const _BottomSection({required this.video, required this.formatNumber});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Left side: User Info, Description
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  // In a real app, you'd fetch the channel avatar.
                  // For now, we use a placeholder based on the channel name.
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.grey.shade800,
                    child: Text(
                      video.channelTitle.isNotEmpty
                          ? video.channelTitle[0]
                          : '',
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () => context.push('/profile/${video.channelId}'),
                    child: Text(
                      video.channelTitle,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  TextButton(onPressed: () {}, child: const Text('Follow')),
                ],
              ),
              const SizedBox(height: 10),
              Text(video.title, maxLines: 2, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 5),
              const Text(
                '#Lifestyle #Music',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        // Right side: Action Buttons
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _ActionButton(
              icon: const HugeIcon(
                color: Colors.white,
                icon: HugeIcons.strokeRoundedFavourite,
                size: 30,
              ),
              label: formatNumber(video.likeCount),
            ),
            _ActionButton(
              icon: const HugeIcon(
                icon: HugeIcons.strokeRoundedMessage01,
                size: 30,
                color: Colors.white,
              ),
              label: formatNumber(video.commentCount),
            ),
            _ActionButton(
              icon: Transform.rotate(
                angle: -math.pi / 4,
                child: const HugeIcon(
                  icon: HugeIcons.strokeRoundedSent,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              label: '1.2K', // Placeholder
            ),
            const SizedBox(height: 10),
          ],
        ),
      ],
    );
  }
}

//------>
class _ActionButton extends StatelessWidget {
  final Widget icon;
  final String label;

  const _ActionButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        children: [
          icon,
          const SizedBox(height: 5),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}