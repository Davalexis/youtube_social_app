import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_project/core/errors/error_view.dart';
import 'package:gemini_project/features/feed/controller/feed_controller.dart';
import 'package:gemini_project/features/feed/widget/video_post_widget.dart.dart';

import 'package:go_router/go_router.dart';

class FeedView extends ConsumerWidget {
  const FeedView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedAsync = ref.watch(feedControllerProvider);

    return Scaffold(
      body: feedAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        // MODIFICATION: Use the new ErrorViewWidget
        error:
            (error, stack) => ErrorViewWidget(
              onRetry: () {
                // Invalidate the provider to trigger a full refresh
                ref.invalidate(feedControllerProvider);
              },
            ),
        data: (videos) {
          if (videos.isEmpty) {
            return const Center(child: Text('No videos found.'));
          }
          return RefreshIndicator(
            onRefresh:
                () => ref.read(feedControllerProvider.notifier).refresh(),
            child: PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: videos.length,
              itemBuilder: (context, index) {
                final video = videos[index];
                return GestureDetector(
                  onTap: () {
                    context.push('/player/${video.videoId}');
                  },
                  child: VideoPostWidget(video: video),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
