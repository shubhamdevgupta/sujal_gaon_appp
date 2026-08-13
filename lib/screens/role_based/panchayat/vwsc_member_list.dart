import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/panchayat/panchayat_provider.dart';
import '../../../service/local_storage_service.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/auth/user_session_manager.dart';

class VwscMemberList extends StatefulWidget {
  const VwscMemberList({super.key});

  @override
  State<VwscMemberList> createState() => _VwscListScreenState();
}

class _VwscListScreenState extends State<VwscMemberList> {
  final session = UserSessionManager();
  final storageService = LocalStorageService();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await session.init();

      final provider = Provider.of<PanchayatProvider>(context, listen: false);

      await provider.fetchVwscMemberList(
        session.userId,
        int.parse(storageService.getString(AppConstants.prefStateId)!),
        int.parse(storageService.getString(AppConstants.prefPanchayatId)!),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PanchayatProvider>();
    final members = provider.vwscMember;

    return Scaffold(
      backgroundColor: const Color(0xFFEAF3FB),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xFF1565C0),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Vwsc Member ",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF64B5F6), Colors.blue.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: members.length,
          itemBuilder: (context, index) {
            final user = members[index];

            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient: const LinearGradient(
                  colors: [Colors.white, Color(0xFFE3F2FD)],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.15),
                    blurRadius: 10,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    height: 55,
                    width: 55,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Color(0xFF64B5F6), Color(0xFF1E88E5)],
                      ),
                    ),
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.name ?? "N/A",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          user.mobile ?? "No Mobile",
                          style: const TextStyle(fontSize: 13),
                        ),
                        Text(
                          user.functionalDesignation ?? "No Designation",
                          style: const TextStyle(fontSize: 13),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Village: ${user.villageName ?? 'N/A'}",
                          style: const TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
