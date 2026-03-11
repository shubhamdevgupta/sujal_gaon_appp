import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:jal_sanchalan/models/njm_ftk_response/habitation_assest.dart';
import 'package:jal_sanchalan/providers/njm_wso/njm_wso_provider.dart';
import 'package:provider/provider.dart';

import '../../../../utils/app_constants.dart';
import '../../../providers/njm_ftk_provider.dart';
import '../../../service/local_storage_service.dart';
import '../../../utils/auth/user_session_manager.dart';

class NjmRegularEntry extends StatefulWidget {
  const NjmRegularEntry({super.key});

  @override
  State<NjmRegularEntry> createState() => _NjmRegularEntry();
}

class _NjmRegularEntry extends State<NjmRegularEntry> {
  final session = UserSessionManager();
  final LocalStorageService _localStorage = LocalStorageService();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = context.read<NjmWsoProvider>();

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
                        Consumer<NjmWsoProvider>(
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

                            return Column(
                              children: [
                                buildHabitationCard(serviceArea),
                                SizedBox(height: 5),

                                buildAssetsCard(provider),
                              ],
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

Widget buildServiceAreaCard(String serviceArea, NjmWsoProvider provider) {
  return Container(
    margin: const EdgeInsets.only(bottom: 20),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.white.withOpacity(.92),
      border: Border.all(color: Colors.blue.shade100),
      boxShadow: [
        BoxShadow(
          color: Colors.blue.withOpacity(.08),
          blurRadius: 12,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// HEADER
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.location_on_outlined,
                    color: Colors.blue,
                    size: 20,
                  ),
                ),

                const SizedBox(width: 10),

                const Text(
                  "Habitation Service Area",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            /// VALUE FIELD
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue.shade100),
              ),
              child: Row(
                children: [
                  Icon(Icons.tag, size: 16, color: Colors.grey.shade600),

                  const SizedBox(width: 8),

                  Expanded(
                    child: Text(
                      serviceArea,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        /// DIVIDER
        Divider(color: Colors.blue.shade100, thickness: 1),

        const SizedBox(height: 10),

        /// ASSET TITLE
        Row(
          children: const [
            Icon(Icons.account_tree_outlined, size: 18, color: Colors.blue),
            SizedBox(width: 6),
            Text(
              "Assets Involved",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Colors.blue,
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        buildAssetList(provider),
      ],
    ),
  );
}

Widget buildHabitationCard(String serviceArea) {
  return Container(
    margin: const EdgeInsets.only(bottom: 14),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(18),
      color: Colors.white.withOpacity(.95),
      border: Border.all(color: Colors.blue.shade100),
      boxShadow: [
        BoxShadow(
          color: Colors.blue.withOpacity(.08),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.location_on_outlined,
                color: Colors.blue,
                size: 20,
              ),
            ),

            const SizedBox(width: 10),

            const Text(
              "Habitation Service Area",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Colors.blue,
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            serviceArea,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    ),
  );
}

Widget buildAssetsCard(NjmWsoProvider provider) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(18),
      color: Colors.white.withOpacity(.95),
      border: Border.all(color: Colors.blue.shade100),
      boxShadow: [
        BoxShadow(
          color: Colors.blue.withOpacity(.08),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Icon(Icons.account_tree_outlined, size: 18, color: Colors.blue),
            SizedBox(width: 6),
            Text(
              "Assets Involved",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Colors.blue,
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        buildAssetList(provider),
      ],
    ),
  );
}

Widget buildAssetList(NjmWsoProvider provider) {
  return ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: provider.habitationAssetResponse!.assetList!.length,
    itemBuilder: (context, index) {
      Asset asset = provider.habitationAssetResponse!.assetList![index];

      if (asset.assetTypeId == "0") {
        return buildSourceAssetCard(context, asset);
      } else {
        return buildNormalAssetCard(context, asset);
      }
    },
  );
}

Widget buildSourceAssetCard(BuildContext context, Asset asset) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.blue.shade50.withOpacity(.4),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// TITLE
          Row(
            children: [
              Icon(
                _getAssetIcon(asset.assetTypeId),
                color: Colors.blue.shade700,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                asset.assetType ?? "",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          /// MAIN TESTING
          _sourceActionTile(
            title: "Pump entry",
            icon: Icons.science_outlined,
            color: Colors.blue.shade100,
            onTap: () {
              Navigator.pushNamed(
                  context,
                  AppConstants.navigateToGroundwatersourcetubeMain,
                  arguments: asset
              );
            },
          ),

          const SizedBox(height: 8),

          /// REGULAR TESTING
          _sourceActionTile(
            title: "Pump activity",
            icon: Icons.check_circle_outline,
            color: Colors.green.shade100,
            onTap: () {
              Navigator.pushNamed(
                context,
                AppConstants.navigateToGroundwatersourcetubeRegular,
              );
            },
          ),
        ],
      ),
    ),
  );
}

Widget _sourceActionTile({
  required String title,
  required IconData icon,
  required Color color,
  required VoidCallback onTap,
}) {
  return InkWell(
    borderRadius: BorderRadius.circular(10),
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.black87),

          const SizedBox(width: 10),

          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            ),
          ),

          /// RIGHT ARROW
          Icon(Icons.chevron_right, color: Colors.grey.shade600),
        ],
      ),
    ),
  );
}

Widget buildNormalAssetCard(BuildContext context, asset) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    child: InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () {
        _navigateToAssetForm(context, asset.assetTypeId);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.blue.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(.05),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            /// ICON
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                _getAssetIcon(asset.assetTypeId),
                size: 18,
                color: Colors.blue,
              ),
            ),

            const SizedBox(width: 10),

            /// TITLE
            Expanded(
              child: Text(
                asset.assetType ?? "",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            /// ARROW BUTTON
            Icon(Icons.chevron_right, color: Colors.grey.shade600),
          ],
        ),
      ),
    ),
  );
}

void _navigateToAssetForm(BuildContext context, String assetTypeId) {
  switch (assetTypeId) {
    case "2":
      Navigator.pushNamed(context, AppConstants.navigateToPumpsForm);
      break;
    case "8":
      Navigator.pushNamed(context, AppConstants.navigateToOHSRForm);
      break;
    case "11":
      Navigator.pushNamed(context, AppConstants.navigateToDisinfectionForm);
      break;
    default:
      break;
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
