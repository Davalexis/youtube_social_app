import 'package:flutter/material.dart';
import 'package:gemini_project/core/theme/theme.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';


// 1.---------> NAVIGATION FEATURE(SHELLVIEW) <-----------
class ShellView extends StatelessWidget {
  final Widget child;
  const ShellView({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final currentIndex = _calculateSelectedIndex(context);

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomAppBar(
        color: AppColors.background,
        height: 100,

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _buildNavItem(
              context,
              icon: HugeIcons.strokeRoundedCarouselVertical,
              selectedIcon: HugeIcons.strokeRoundedCarouselVertical,
              index: 2,
              
              currentIndex: currentIndex, text: 'Feed',
            ),

            _buildNavItem(
              context,
              icon: HugeIcons.strokeRoundedSearch01,
              selectedIcon: HugeIcons.strokeRoundedSearch01,
              index: 1,
              currentIndex: currentIndex, text: 'Search',
            ),

            _buildNavItem(
              context,
              icon: HugeIcons.strokeRoundedUser,
              selectedIcon: HugeIcons.strokeRoundedUser,
              index: 3,
              currentIndex: currentIndex,
               text: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  // 2.-------> BUILD THE NAVIGATION ITEM WIDGET <-------

  Widget _buildNavItem(
    BuildContext context, {
    required IconData icon,
    required IconData selectedIcon,
    required int index,
    required String text,
    required int currentIndex,
    // bool isCentral = false,
  }) {
    final isSelected = currentIndex == index;

    return Column(
      children: [
        IconButton(
          
          icon: HugeIcon(
            size: 27,
            icon: isSelected ? selectedIcon : icon,
            color: isSelected ? AppColors.accent : AppColors.secondaryText,
          ),
          onPressed: () => _onItemTapped(index, context),
        ),

        Expanded(child: Text(text)),
      ],
    );
  }

 
  //3.------------> NAV ROUTE <-----------

  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/explore')) return 1;
    if (location.startsWith('/feed')) return 2; // Central button is the feed
    if (location.startsWith('/profile-tab')) return 3;
    // Default to a 'home' concept if you build it, otherwise it can be an unused index or point to feed.
    // Let's make index 0 a placeholder for now.
    return 2; // Default to showing the feed as selected
  }

  // -------> HANDLE ITEM TAPS <-------
  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        // This could be a different 'Home' screen, for now we go to feed
        context.go('/feed');
        break;
      case 1:
        context.go('/explore');
        break;
      case 2:
        context.go('/feed');
        break;
      case 3:
        context.go('/profile-tab');
        break;
    }
  }
}
