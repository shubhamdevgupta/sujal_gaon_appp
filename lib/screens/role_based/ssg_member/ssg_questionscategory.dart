import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/wso_ssg_provider.dart';
import '../../../service/local_storage_service.dart';
import '../../../utils/auth/user_session_manager.dart';


class SSGQuestionscategory extends StatefulWidget {
  const SSGQuestionscategory({super.key});

  @override
  State<SSGQuestionscategory> createState() => _NjmQuestionscategory();
}

class _NjmQuestionscategory extends State<SSGQuestionscategory> {
  final session = UserSessionManager();
  final LocalStorageService _localStorage = LocalStorageService();
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = context.read<WsoSSGProvider>();

     // await provider.fetchHabitationAssetsID(31, 1213773, session.userId);
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
        backgroundColor:  Colors.blue.shade700.withValues(alpha:0.9),
        title: const Text("Activity Log",style: TextStyle(color: Colors.white),),
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

                  /// Header
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 6,
                          sigmaY: 6,
                        ),
                        child: Column(
                          children: const [

                            Icon(
                              Icons.water_drop,
                              size: 40,
                              color: Colors.blue,
                            ),

                            SizedBox(height: 10),

                            Text(
                              "Activity Log of SSG / FTK-trained Women",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            SizedBox(height: 5),

                            Text(
                              "(Water Quality Monitoring & User Charge Collection)",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// Category List
/*
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
                                color: Colors.white.withValues(alpha:0.85),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue.withValues(alpha:0.15),
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

                                  /// Title
                                  const SizedBox(height: 12),

                                  const Text(
                                    "Flow Path",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  const SizedBox(height: 12),

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
                                  ),
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

                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: provider.habitationAssetResponse!.assetList!
                                        .map((asset) {
                                      return Padding(
                                        padding: const EdgeInsets.only(bottom: 8),
                                        child: Row(
                                          children: [

                                            const Icon(
                                              Icons.circle,
                                              size: 8,
                                              color: Colors.blue,
                                            ),

                                            const SizedBox(width: 8),

                                            Text(
                                              "${asset.assetType} (AssetId: ${asset.assetId})",
                                              style: const TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  )

                                ],
                              ),
                            );
                          },
                        ),


                        CategoryCard(
                          icon: Icons.person_outline,
                          title: "Basic Details",
                          subtitle: "User Information",
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppConstants.navigateToBasicDetailsForm,
                            );
                          },
                        ),

                        CategoryCard(
                          icon: Icons.location_on_outlined,
                          title: "Location",
                          subtitle: "Up to Habitation",
                          onTap: () {

                            Navigator.pushNamed(
                              context,
                              AppConstants.navigateToLocationFormScreen,
                            );
                            // TODO
                          },
                        ),

                        CategoryCard(
                          icon: Icons.science_outlined,
                          title: "Water Sample Data",
                          subtitle: "Testing Information",
                          onTap: () {
                            Navigator.pushNamed(context, AppConstants.navigateToWaterSampleForm);
                          },
                        ),

                        CategoryCard(
                          icon: Icons.verified_outlined,
                          title: "Sanitary Inspection",
                          subtitle: "Risk Assessment",
                          onTap: () {
                          Navigator.pushNamed(context, AppConstants.navigateToSanitaryInspectionForm);
                          },
                        ),

                        CategoryCard(
                          icon: Icons.payments_outlined,
                          title: "Monthly Charge Collection",
                          subtitle: "Billing & Payment",
                          onTap: () {
                           Navigator.pushNamed(context, AppConstants.navigateToMonthlyChargeCollectionForm);
                          },
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
*/
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
                    Colors.white.withValues(alpha:0.9),
                    Colors.blue.shade50.withValues(alpha:0.2),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),

                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withValues(alpha:0.18),
                    blurRadius: 20,
                    spreadRadius: 1,
                    offset: const Offset(0, 8),
                  ),
                ],

                border: Border.all(
                  color: Colors.white.withValues(alpha:0.1),
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
                    child: Icon(
                      icon,
                      color: Colors.blue.shade700,
                      size: 26,
                    ),
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

                  const Icon(
                    Icons.chevron_right,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}