import 'package:flutter/material.dart';

import '../../utils/app_constants.dart';

class PreLoginScreen extends StatefulWidget {
  const PreLoginScreen({super.key});

  @override
  State<PreLoginScreen> createState() => _PreLoginScreenState();
}

class _PreLoginScreenState extends State<PreLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/icons/SJL_bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Sujalam Bharat",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF345370),
                    letterSpacing: 1.2,
                  ),
                ),

                const Text(
                  "Utility App",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlue,
                  ),
                ),

                SizedBox(height: 18),
                Container(
                  width: 128,
                  height: 2,
                  decoration: BoxDecoration(color: Colors.grey),
                ),
                SizedBox(height: 18),

                const Text(
                  "Login As",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF345370),
                  ),
                ),
                const Text(
                  "Select Your Role to Continue",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 18),
                _buildLoginCard(
                  title: "District Water Sanitation",
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppConstants.navigateToDwsmLogin,
                    );
                  },
                ),
                const SizedBox(height: 20),

          /*      _buildLoginCard(
                  title: "Village Water Sanitation",
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppConstants.navigateToVwscLogin,
                    );
                  },
                ),
                const SizedBox(height: 20),*/

                // ================= PANCHAYAT LOGIN =================
                _buildLoginCard(
                  title: "Gram Panchayat",
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppConstants.navigateToGramPanchayatLogin,
                    );
                  },
                ),

                const SizedBox(height: 20),

                _buildLoginCard(
                  title: "Water Supply Operator",
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppConstants.navigateToWSOLogin,
                    );
                  },
                ),
                const SizedBox(height: 20),
                _buildLoginCard(
                  title: "Sujalam Shakti",
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppConstants.navigateToSSGLogin,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginCardNew({
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 90,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            colors: [Color(0xFF345370), Color(0xFFF39A0A)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withValues(alpha:0.4),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            // =========================
            // 70% LEFT SECTION
            // =========================
            Expanded(
              flex: 7,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    const Icon(
                      Icons.app_registration,
                      color: Colors.white,
                      size: 28,
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // =========================
            // VERTICAL DIVIDER
            // =========================
            Container(
              width: 2,
              height: 55,
              decoration: BoxDecoration(
                color: const Color(0xFFFFE8A3),
                borderRadius: BorderRadius.circular(2),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFFD54F).withValues(alpha:0.7),
                    blurRadius: 6,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),

            // =========================
            // 30% RIGHT SECTION
            // =========================
            Expanded(
              flex: 3,
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFC107).withValues(alpha:0.18),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginCard({required String title, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 90,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            colors: [Color(0xFF345370), Color(0xFF1E88E5)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withValues(alpha:0.4),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              flex: 7,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    const Icon(
                      Icons.app_registration,
                      color: Colors.white,
                      size: 28,
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // =========================
            // VERTICAL DIVIDER
            // =========================
            Container(
              width: 2,
              height: 55,
              decoration: BoxDecoration(
                color: const Color(0xFF075985),
                borderRadius: BorderRadius.circular(2),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF90ABC5).withValues(alpha:0.7),
                    blurRadius: 6,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),

            // =========================
            // 30% RIGHT SECTION
            // =========================
            Expanded(
              flex: 3,
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF1E88E5).withValues(alpha:0.18),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
