import 'package:flutter/material.dart';
import 'package:jal_sanchalan/providers/vwsc/vwsc_provider.dart';
import 'package:jal_sanchalan/utils/auth/user_session_manager.dart';
import 'package:provider/provider.dart';

import '../../../utils/enum/user_type.dart';
import 'ftk_sgh_page.dart';
import 'njm_wso_page.dart';

class MembersTabScreen extends StatefulWidget {
  const MembersTabScreen({super.key});

  @override
  State<MembersTabScreen> createState() => _MembersTabScreenState();
}

class _MembersTabScreenState extends State<MembersTabScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final session = UserSessionManager();
  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);

    // Initial Load → NJM
    WidgetsBinding.instance.addPostFrameCallback((_) {
      session.init();
      context.read<VwscProvider>().fetchNjmFtkUser(
        UserType.njmp.id,907392,
        21,
        0
      );
    });

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;

      final provider = context.read<VwscProvider>();

      if (_tabController.index == 0) {
        provider.fetchNjmFtkUser(
          UserType.njmp.id, 907392,
          21,
          0
        );
      } else {
        provider.fetchNjmFtkUser(
          UserType.ftk.id, 907392,
          31,
          0
        );
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF3FB),
      appBar: AppBar(
        title: const Text(
          "Members List",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: "NJM / WSO"),
            Tab(text: "FTK / SGH"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [NjmWsoPage(), FtkSghPage()],
      ),
    );
  }
}
