import 'package:flutter/material.dart';

import 'ftk_sgh_page.dart';
import 'njm_wso_page.dart';

class MembersTabScreen extends StatelessWidget {
  const MembersTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFFEAF3FB),
        appBar: AppBar(
          title: const Text(
            "Members List",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1E88E5), Color(0xFF64B5F6)],
              ),
            ),
          ),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: "NJM / WSO"),
              Tab(text: "FTK / SGH"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            NjmWsoPage(),
            FtkSghPage(),
          ],
        ),
      ),
    );
  }
}