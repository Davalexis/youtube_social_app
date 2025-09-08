import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_project/features/explore/controller/explore_controller.dart';
import 'package:gemini_project/features/explore/controller/explore_state.dart';
import 'package:gemini_project/features/explore/widget/search_result_tile.dart.dart';

class ExploreView extends ConsumerStatefulWidget {
  const ExploreView({super.key});

  @override
  ConsumerState<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends ConsumerState<ExploreView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearch() {
    ref.read(exploreControllerProvider.notifier).searchVideos(_searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(exploreControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search YouTube',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white54),
          ),
          onSubmitted: (_) => _onSearch(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _onSearch,
          ),
        ],
      ),
      body: Center(
        child: _buildBody(state),
      ),
    );
  }

  Widget _buildBody(ExploreState state) {
    switch (state.status) {
      case ExploreStatus.loading:
        return const CircularProgressIndicator();
      case ExploreStatus.failure:
        return Text(state.errorMessage ?? 'An unknown error occurred.');
      case ExploreStatus.success:
        if (state.videos.isEmpty) {
          return const Text('No results found.');
        }
        return ListView.builder(
          itemCount: state.videos.length,
          itemBuilder: (context, index) {
            final video = state.videos[index];
            return SearchResultTile(video: video);
          },
        );
      case ExploreStatus.initial:
      // ignore: unreachable_switch_default
      default:
        return const Text('Search for videos and creators.');
    }
  }
}