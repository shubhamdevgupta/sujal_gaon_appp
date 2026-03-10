import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../utils/app_constants.dart';
import '../../../providers/njm_ftk_provider.dart';
import '../../../service/local_storage_service.dart';
import '../../../utils/auth/user_session_manager.dart';

class NjmCategory extends StatefulWidget {
  const NjmCategory({super.key});

  @override
  State<NjmCategory> createState() => _NjmCategory();
}

class _NjmCategory extends State<NjmCategory> {
  final session = UserSessionManager();
  final LocalStorageService _localStorage = LocalStorageService();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = context.read<NjmFtkProvider>();

      await provider.fetchHabitationAssetsID(31, 1213773, session.userId);
      // await provider.fetchHabitationAssetsID(_localStorage.getInt(AppConstants.prefStateId)!, provider.habitationId!, session.userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF4FF),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.blue.shade700.withOpacity(0.9),
        title: const Text("NJM", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/icons/SJL_bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            /// Main UI
            SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 15),

                  /// Category List
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      children: [
                        Consumer<NjmFtkProvider>(
                          builder: (context, provider, child) {
                            final flowPath = provider
                                .habitationAssetResponse!
                                .flowPathList!
                                .first
                                .flowPath;
                            final serviceArea = provider
                                .habitationAssetResponse!
                                .serviceArea!
                                .habitationServicearea;

                            if (flowPath == null || serviceArea == null) {
                              return const SizedBox();
                            }

                            final flowItems = flowPath.split("->");

                            return Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                color: Colors.white.withOpacity(0.85),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue.withOpacity(0.15),
                                    blurRadius: 10,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// Title
                                  const Text(
                                    "Habitation Service Area",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),

                                  const SizedBox(height: 12),

                                  /// Flow Items
                                  Text(
                                    serviceArea,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),

                                  const SizedBox(height: 12),

           /*                       const Text(
                                    "Flow Path",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),

                                  /// Flow Items
                                  Column(
                                    children: List.generate(flowItems.length, (
                                        index,
                                        ) {
                                      return Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          /// Circle
                                          Column(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                decoration: const BoxDecoration(
                                                  color: Colors.blue,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),

                                              if (index != flowItems.length - 1)
                                                Container(
                                                  width: 2,
                                                  height: 30,
                                                  color: Colors.blue.shade200,
                                                ),
                                            ],
                                          ),

                                          const SizedBox(width: 10),

                                          /// Text
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                bottom: 20,
                                              ),
                                              child: Text(
                                                flowItems[index].trim(),
                                                style: const TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                                  ),*/
                                  /// Title

                                  /// Assets Title
                                  const Text(
                                    "Assets Involved",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),

                                  const SizedBox(height: 12),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: provider.habitationAssetResponse!.assetList!.length,
                                    itemBuilder: (context, index) {
                                      final asset = provider.habitationAssetResponse!.assetList![index];

                                      return Padding(
                                        padding: const EdgeInsets.only(bottom: 10),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 14,
                                            vertical: 10,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(12),
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.blue.shade50,
                                                Colors.white,
                                              ],
                                            ),
                                            border: Border.all(
                                              color: Colors.blue.shade200,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.blue.withOpacity(0.08),
                                                blurRadius: 6,
                                                offset: const Offset(0, 3),
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            children: [
                                              /// Asset Icon
                                              Icon(
                                                _getAssetIcon(asset.assetTypeId),
                                                size: 18,
                                                color: Colors.blue.shade700,
                                              ),

                                              const SizedBox(width: 6),

                                              /// Asset Name
                                              Text(
                                                asset.assetType ?? "",
                                                style: const TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),


                                  const SizedBox(height: 12),


                                ],
                              ),
                            );
                          },
                        ),

                       /* CategoryCard(
                          icon: Icons.location_on_outlined,
                          title: "Basic Details",
                          subtitle: "Administrative & Location Information",
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppConstants.navigateToGroundWaterPumpForm,
                            );
                          },
                        ),*/

                        CategoryCard(
                          icon: Icons.science_outlined,
                          title: "Water Supply Components",
                          subtitle: "Source & Pump Operations Monitoring",
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppConstants.navigateToWscCategory,
                            );
                          },
                        ),

                        CategoryCard(
                          icon: Icons.verified_outlined,
                          title: "Distribution & Supply",
                          subtitle: "Reservoir Filling & Outlet Supply",
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppConstants.navigateToDistributionSupplyForm,
                            );
                          },
                        ),

                        CategoryCard(
                          icon: Icons.water_drop_outlined,
                          title: "Disinfection / Chlorination",
                          subtitle: "Treatment & Water Quality Control",
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppConstants.navigateToDisinfectionForm,
                            );
                          },
                        ),

                        CategoryCard(
                          icon: Icons.report_problem_outlined,
                          title: "Non-Supply & Disruptions",
                          subtitle: "Service Interruptions & Compliance Alerts",
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppConstants.navigateToNonSupplyForm,
                            );
                          },
                        ),

                        /*      CategoryCard(
                          icon: Icons.report_problem_outlined,
                          title: "Escalation & Alerts (System Generated)",
                          subtitle: "Service Interruptions & Compliance Alerts",
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppConstants.navigateToEscalationAlertsScreen,
                            );
                          },
                        ),*/
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ================= CARD WIDGET =================
IconData _getAssetIcon(String? type) {
  switch (type) {
    case "source":
      return Icons.water;
    case "pmp":
      return Icons.settings_input_component;
    case "ohsr":
      return Icons.storage;
    case "disinfection":
      return Icons.science;
    default:
      return Icons.device_unknown;
  }
}

class CategoryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: InkWell(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.all(16),

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),

                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.9),
                    Colors.blue.shade50.withOpacity(0.2),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),

                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.18),
                    blurRadius: 20,
                    spreadRadius: 1,
                    offset: const Offset(0, 8),
                  ),
                ],

                border: Border.all(
                  color: Colors.white.withOpacity(0.1),
                  width: 1,
                ),
              ),

              child: Row(
                children: [
                  /// Icon Box
                  Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(icon, color: Colors.blue.shade700, size: 26),
                  ),

                  const SizedBox(width: 14),

                  /// Text
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          subtitle,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Icon(Icons.chevron_right, color: Colors.grey),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
