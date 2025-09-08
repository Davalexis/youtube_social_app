import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_project/core/errors/error_view.dart';
import 'package:gemini_project/features/profile/controller/profile_controller.dart';

class ProfileView extends ConsumerWidget {
  final String channelId;
  const ProfileView({super.key, required this.channelId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final channelAsync = ref.watch(profileControllerProvider(channelId));

    return Scaffold(
      body: channelAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        // MODIFICATION: Use the new ErrorViewWidget
        error:
            (err, stack) => ErrorViewWidget(
              onRetry: () {
                ref.invalidate(profileControllerProvider(channelId));
              },
            ),
        data: (channel) {
          // ... (rest of the data widget remains the same)
          return CustomScrollView(
            // ...
          );
        },
      ),
    );
  }
}
