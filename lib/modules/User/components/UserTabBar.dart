import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_flow_nft_catalog/Theme.dart';

class UserTabBar extends StatefulWidget {
  const UserTabBar({super.key});

  @override
  State<UserTabBar> createState() => _UserTabBarState();
}

class _UserTabBarState extends State<UserTabBar>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
            controller: _tabController,
            labelColor: MainColors.black,
            dividerColor: MainColors.secondaryGray,
            indicatorWeight: 3,
            indicatorColor: MainColors.gray.withOpacity(0.2),
            tabs: const [
              Tab(
                icon: Icon(
                  FeatherIcons.image,
                ),
                height: 36,
              ),
              Tab(
                icon: Icon(FeatherIcons.dollarSign),
                height: 36,
              )
            ]),
        Expanded(
            child: TabBarView(
          controller: _tabController,
          children: [
            Text("NFTS"),
            Center(
              child: Text("Coming Soon!"),
            )
          ],
        ))
      ],
    );
  }
}
