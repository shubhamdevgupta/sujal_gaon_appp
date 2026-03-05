import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:jal_sanchalan/providers/panchayat/panchayat_provider.dart';
import 'package:jal_sanchalan/service/local_storage_service.dart';
import 'package:provider/provider.dart';

import '../../providers/authentication_provider.dart';
import '../../utils/app_constants.dart';
import '../../utils/auth/user_session_manager.dart';

class PanchayatLandingScreen extends StatefulWidget {
  const PanchayatLandingScreen({super.key});

  @override
  State<PanchayatLandingScreen> createState() => _PanchayatLandingScreenState();
}

class _PanchayatLandingScreenState extends State<PanchayatLandingScreen> {
  final session = UserSessionManager();
  final LocalStorageService storageService = LocalStorageService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      session.init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PanchayatProvider>();
    return WillPopScope(
      onWillPop: _showExitDialog,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: const Color(0xFF1565C0),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout, color: Colors.white),
              onPressed: () async {
                await context.read<AuthenticationProvider>().logoutUser();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppConstants.navigateToPreLoginScreen,
                      (route) => false,
                );
              },
            ),
          ],
          title: const Text(
            "Sujal Gaon",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        body: Container(
          height: MediaQuery
              .of(context)
              .size
              .height,
          width: MediaQuery
              .of(context)
              .size
              .width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF64B5F6), Colors.blue.shade50],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(10),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*_buildCustomHeader(),*/
                // ================= WELCOME =================
                const SizedBox(height: 20),

                _buildWelcomeCard(),

                SizedBox(height: 20),
                // ================= DASHBOARD =================
                _dashboardCard(context),
                const SizedBox(height: 16),

                _registerOptions(context),
                const SizedBox(height: 16),

                _listCardNJMFTK(context),
                const SizedBox(height: 16),
                _listCard(context, provider),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _dashboardCard(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            gradient: LinearGradient(
              colors: [Colors.white, Colors.blue.shade200],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),

            // Outer shadow
            boxShadow: [BoxShadow(color: Colors.white)],
          ),

          child: ClipRRect(
            borderRadius: BorderRadius.circular(22),

            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Row(
                        children: [
                          const Icon(
                            Icons.dashboard_customize,
                            color: Colors.blue,
                            size: 26,
                          ),

                          const SizedBox(width: 8),

                          const Text(
                            "Dashboard",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const Spacer(),
                        ],
                      ),
                      SizedBox(height: 10),

                      const Text(
                        "Overview Your Panchayat Area",
                        style: TextStyle(color: Colors.black87, fontSize: 13),
                      ),

                      const SizedBox(height: 8),
                      _buildLocationCard(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _listCardNJMFTK(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppConstants.navigateToVWSCMemberScrenn);
      },
      child: Container(
        height: 130,
        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xFFF8FBFF), // very light (left)
              Color(0xFFE3F2FD), // soft blue (middle)
              Color(0xFFD0E8FF), // faded blue glow (right)
            ],
            stops: [0.0, 0.6, 1.0],
          ),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
        ),

        child: Row(
          children: const [
            Icon(Icons.list_alt, color: Color(0xFF1976D2), size: 28),

            SizedBox(width: 12),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "NJM / WSO & FTK/SGH Members",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  ),

                  SizedBox(height: 4),

                  Text(
                    "View Registered NJM/WSO & FTK/SGH Members",
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ],
              ),
            ),

            Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _listCard(BuildContext context, PanchayatProvider provider) {
    return GestureDetector(
      onTap: ()  {
        Navigator.pushNamed(context, AppConstants.navigateToVWSCListScreen);
      },
      child: Container(
        height: 90,
        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xFFF8FBFF),
              Color(0xFFE3F2FD),
              Color(0xFFD0E8FF),
            ],
            stops: [0.0, 0.6, 1.0],
          ),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
        ),

        child: Row(
          children: const [
            Icon(Icons.list_alt, color: Color(0xFF1976D2), size: 28),

            SizedBox(width: 12),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "List VWSC Members",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  ),

                  SizedBox(height: 4),

                  Text(
                    "View Registered Villages",
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ],
              ),
            ),

            Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _registerOptions(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),

        border: Border.all(color: Colors.blueGrey.shade200, width: 1.2),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          _registerRowProfessional(
            icon: Icons.water_drop,
            title: "Register NJM / WSO",
            subtitle: "Nal Jal Mitra Registration",
            onTap: () {
              Navigator.pushNamed(
                context,
                AppConstants.navigateToNJMPRegistrationForm,
              );
            },
          ),

          Divider(height: 1, thickness: 1, color: Colors.blueGrey.shade100),

          _registerRowProfessional(
            icon: Icons.groups_rounded,
            title: "SHGs / FTK Trained Women",
            subtitle: "Self Help Group Registration",
            onTap: () {
              Navigator.pushNamed(
                context,
                AppConstants.navigateToSHGFTKRegistrationForm,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _registerRowProfessional({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Row(
          children: [
            Container(
              height: 46,
              width: 46,
              decoration: BoxDecoration(
                color: const Color(0xFF1E88E5).withOpacity(0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: const Color(0xFF1565C0), size: 24),
            ),

            const SizedBox(width: 18),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.blueGrey.shade600,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Color(0xFF1565C0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationCard() {
    final provider = context.watch<AuthenticationProvider>();
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),

        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFFF8FBFF), // very light (left)
            Color(0xFFE3F2FD), // soft blue (middle)
            Color(0xFFD0E8FF), // faded blue glow (right)
          ],
          stops: [0.0, 0.6, 1.0],
        ),

        border: Border.all(color: Colors.blue.withOpacity(0.1)),

        boxShadow: [
          BoxShadow(color: Colors.blue.withOpacity(0.05), blurRadius: 10),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ================= ROW 1 =================
          Row(
            children: [
              _locationItemWithIcon(
                icon: Icons.account_balance,
                color: Color(0xFF1976D2),
                title: "State",
                value: "${provider.panchayatResult?.loginResult?.stateName}",
              ),

              _verticalDivider(),

              _locationItemWithIcon(
                icon: Icons.place,
                color: Color(0xFFE53935),
                title: "District",
                value: "${provider.panchayatResult?.loginResult?.districtName}",
              ),
            ],
          ),

          const SizedBox(height: 10),

          const Divider(),

          // ================= ROW 2 =================
          Row(
            children: [
              _locationItemWithIcon(
                icon: Icons.apartment,
                color: Color(0xFF8D6E63),
                title: "Block",
                value: "${provider.panchayatResult?.loginResult?.blockName}",
              ),

              _verticalDivider(),

              _locationItemWithIcon(
                icon: Icons.home,
                color: Color(0xFF00796B),
                title: "GP",
                value: "${provider.panchayatResult?.loginResult?.panchayatName}",
              ),
            ],
          ),

          const SizedBox(height: 5),

          const Divider(),

          const SizedBox(height: 5),

          // ================= STATS =================
          Row(
            children: const [
              _statBox("Villages", "12"),
              _statBox("Villages where VWSC/pani samiti formed", "4"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _locationItemWithIcon({
    required IconData icon,
    required Color color,
    required String title,
    required String value,
    String? subTitle,
    String? subTitleValue,
  }) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔹 Top Row → Icon + Title
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 6),
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 4),

          /// 🔹 Main Value (Below Row)
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),

          /// 🔹 Optional Subtitle Section
          if (subTitle != null &&
              subTitleValue != null &&
              subTitleValue.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              "$subTitle: $subTitleValue",
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
          ],
        ],
      ),
    );
  }


  Future<bool> _showExitDialog() async {
    return await showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: const Text("Exit App"),
            content: const Text(
              "Are you sure you want to exit the application?",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text("No"),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text("Yes"),
              ),
            ],
          ),
    ) ??
        false;
  }

  Widget _buildWelcomeCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),

      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),

        child: Container(
          height: 110,
          padding: const EdgeInsets.all(18),

          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF2196F3), Color(0xFF0D47A1)],
            ),
            borderRadius: BorderRadius.circular(22),
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,

                children: const [
                  Text(
                    "Welcome Back 👋",
                    style: TextStyle(color: Colors.white70),
                  ),

                  SizedBox(height: 6),

                  Text(
                    "Panchayat User",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              Container(
                width: 100,
                height: 120,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/icons/user_icon.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              /*   CircleAvatar(
                radius: 32,
                backgroundColor: Colors.white,
                child: Container(
                  decoration: BoxDecoration(shape: BoxShape.circle,image: DecorationImage(image: image)),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Image.asset(
                      "assets/icons/user_icon.png",
                    ),
                  ),
                ),
              )*/
            ],
          ),
        ),
      ),
    );
  }

  Widget _verticalDivider() {
    return Container(
      width: 1,
      height: 40,
      color: Colors.grey.shade300,
      margin: const EdgeInsets.symmetric(horizontal: 10),
    );
  }
}

class _statBox extends StatelessWidget {
  final String title;
  final String value;

  const _statBox(this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1976D2),
            ),
          ),

          const SizedBox(height: 2),

          Text(
            title,
            style: TextStyle(fontSize: 11, color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }
}
