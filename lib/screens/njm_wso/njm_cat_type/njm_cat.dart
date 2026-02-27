import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../utils/app_constants.dart';




class NjmCategory extends StatefulWidget {
  const NjmCategory({super.key});

  @override
  State<NjmCategory> createState() => _NjmCategory();
}

class _NjmCategory extends State<NjmCategory> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF4FF),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor:  Colors.blue.shade700.withOpacity(0.9),
        title: const Text("Water Supply Components",style: TextStyle(color: Colors.white),),
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

            /// Background Image
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/bg_water.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),

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
                              "Water Supply Components",
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
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      children: [

                  /*      CategoryCard(
                          icon: Icons.person_outline,
                          title: "1. Basic Details",
                          subtitle: "User Information",
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppConstants.navigateToBasicDetailsForm,
                            );


                          },
                        ),*/

                        CategoryCard(
                          icon: Icons.location_on_outlined,
                          title: "Ground water source Tube wells / Bore wells/ Dug wells",
                          subtitle: "Up to Habitation",
                          onTap: () {

                            Navigator.pushNamed(
                              context,
                              AppConstants.navigateToGroundWaterPumpForm,
                            );
                            // TODO
                          },
                        ),

                        CategoryCard(
                          icon: Icons.science_outlined,
                          title: "Pumps ",
                          subtitle: "Testing Information",
                          onTap: () {
                            Navigator.pushNamed(context, AppConstants.navigateToPumpsForm);
                          },
                        ),

                        CategoryCard(
                          icon: Icons.verified_outlined,
                          title: "Over Head Service Reservoir (OHSR) / Over Head Tank ",
                          subtitle: "Risk Assessment",
                          onTap: () {
                            Navigator.pushNamed(context, AppConstants.navigateToOHSRForm);
                          },
                        ),

                        CategoryCard(
                          icon: Icons.payments_outlined,
                          title: "Ground level Service Reservoir / Sump ",
                          subtitle: "Billing & Payment",
                          onTap: () {
                            Navigator.pushNamed(context, AppConstants.navigateToMonthlyChargeCollectionForm);
                          },
                        ),

                        CategoryCard(
                          icon: Icons.payments_outlined,
                          title: "Spring water",
                          subtitle: "Billing & Payment",
                          onTap: () {
                            Navigator.pushNamed(context, AppConstants.navigateToMonthlyChargeCollectionForm);
                          },
                        ),

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