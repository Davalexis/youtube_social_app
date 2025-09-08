import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_project/features/profile/model/channel_model.dart';
import 'package:gemini_project/features/profile/service/profile_repository.dart';

// Use .family to pass the channelId to the provider
final profileControllerProvider =
    AsyncNotifierProvider.family<ProfileController, Channel, String>(() {
  return ProfileController();
});

class ProfileController extends FamilyAsyncNotifier<Channel, String> {
  @override
  Future<Channel> build(String channelId) async {
    // The build method automatically handles loading, data, and error states.
    final profileRepository = ref.watch(profileRepositoryProvider);
    return profileRepository.fetchChannelDetails(channelId: channelId);
  }
}