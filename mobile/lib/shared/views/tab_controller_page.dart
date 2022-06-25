import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:immich_mobile/modules/home/providers/home_page_state.provider.dart';
import 'package:immich_mobile/routing/router.dart';

class TabControllerPage extends ConsumerWidget {
  const TabControllerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var isMultiSelectEnable =
        ref.watch(homePageStateProvider).isMultiSelectEnable;

    return AutoTabsRouter(
      routes: [
        const HomeRoute(),
        SearchRoute(),
        const SharingRoute(),
      ],
      builder: (context, child, animation) {
        final tabsRouter = AutoTabsRouter.of(context);
        return WillPopScope(
          onWillPop: () async {
            tabsRouter.setActiveIndex(0);
            return false;
          },
          child: Scaffold(
            body: FadeTransition(
              opacity: animation,
              child: child,
            ),
            bottomNavigationBar: isMultiSelectEnable
                ? null
                : BottomNavigationBar(
                    selectedLabelStyle: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w600),
                    unselectedLabelStyle: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w600),
                    currentIndex: tabsRouter.activeIndex,
                    onTap: (index) {
                      tabsRouter.setActiveIndex(index);
                    },
                    items: const [
                      BottomNavigationBarItem(
                          label: 'Photos', icon: Icon(Icons.photo)),
                      BottomNavigationBarItem(
                          label: 'Search', icon: Icon(Icons.search)),
                      BottomNavigationBarItem(
                          label: 'Sharing', icon: Icon(Icons.group_outlined)),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
