import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../providers/authentication_provider.dart';
import '../../../../providers/panchayat/panchayat_provider.dart';
import '../../../../service/local_storage_service.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/auth/user_session_manager.dart';


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
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;

        Future.microtask(() async {
          bool shouldExit = await _showExitDialog();

          if (shouldExit) {
            SystemNavigator.pop();
          }
        });
      },
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
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/icons/SJL_bg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(10),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*_buildCustomHeader(),*/
                // ================= WELCOME =================
                const SizedBox(height: 10),

                _buildWelcomeCard(),
                const SizedBox(height: 10),

                // ================= DASHBOARD =================
                _dashboardCard(context),
                const SizedBox(height: 16),

/*
                /// REGISTER NJM
                Text(
                  "Registration",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1565C0),
                  ),
                ),
                SizedBox(height: 8),

                _viewActionCard(
                  icon: Icons.water_drop,
                  title: "Register WSO",
                  subtitle: "Water Supply Operator",
                  iconColor: Colors.blue,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppConstants.navigateToWsoRegistrationForm,
                    );
                  },
                ),
                SizedBox(height: 10),


                _viewActionCard(
                  icon: Icons.groups,
                  title: "Register SSG Member",
                  subtitle: "Register Sujalam Shakti Group Member",
                  iconColor: Colors.blue,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppConstants.navigateToSSGRegistrationForm,
                    );
                  },
                ),

                SizedBox(height: 10),
*/

                /// VIEW DATA

              Text(
                "View Records",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1565C0),
                ),
              ),

                SizedBox(height: 8),

                _viewActionCard(
                  icon: Icons.assignment,
                  title: "View Registered Members",
                  subtitle: "WSO / SSG Members",
                  iconColor: Colors.teal,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppConstants.navigateToVWSCMemberScrenn,
                    );
                  },
                ),

                _viewActionCard(
                  icon: Icons.list_alt,
                  title: "View VWSC",
                  subtitle: "Registered VWSC",
                  iconColor: Colors.teal,
                  onTap: () {
                    Navigator.pushNamed(context, AppConstants.navigateToVWSCListScreen);
                  }
                ),
                const SizedBox(height: 16),


         /*       _listCardNJMFTK(context),
                const SizedBox(height: 16),
                _listCard(context, provider),*/
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _dashboardCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),

        /// Blue White Gradient
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFF5FAFF),
            Color(0xFFE3F2FD),
            Color(0xFFD6EBFF),
          ],
        ),

        border: Border.all(
          color: Colors.blue.withValues(alpha:.55),
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.blue.withValues(alpha:.10),
            blurRadius: 18,
            offset: const Offset(0, 8),
          )
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// HEADER
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF1565C0).withValues(alpha:.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.dashboard_customize_rounded,
                  color: Color(0xFF1565C0),
                  size: 22,
                ),
              ),

              const SizedBox(width: 10),

              const Text(
                "Dashboard",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          Text(
            "Overview your Panchayat Area",
            style: TextStyle(
              fontSize: 13,
              color: Colors.black.withValues(alpha:.65),
            ),
          ),

          const SizedBox(height: 12),

          /// LOCATION CARD
          _buildLocationCard(),

          const SizedBox(height: 14),

          /// STATS
          Row(
            children: [
              Expanded(
                child: _statCard(
                  icon: Icons.home_rounded,
                  title: "Villages",
                  value: "12",
                  subtitle: "Total Villages",
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _statCard(
                  icon: Icons.groups_rounded,
                  title: "VWSC / Pani Samiti",
                  value: "4",
                  subtitle: "Villages Covered",
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _statCard({
    required IconData icon,
    required String title,
    required String value,
    required String subtitle,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Container(
        height: 150, // ensures equal height
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),

          gradient: LinearGradient(
            colors: [
              Colors.white.withValues(alpha:.9),
              Colors.blue.shade50.withValues(alpha:.9),
            ],
          ),

          border: Border.all(
            color: Colors.blue.withValues(alpha:.55),
          ),

          boxShadow: [
            BoxShadow(
              color: Colors.blue.withValues(alpha:.12),
              blurRadius: 16,
              offset: const Offset(0, 6),
            )
          ],
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            /// ICON
            Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.shade100,
                    Colors.blue.shade400,
                  ],
                ),
              ),
              child: Icon(icon, color: Colors.white, size: 20),
            ),

            const SizedBox(height: 6),

            /// TITLE
            Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 2),

            /// VALUE
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1565C0),
              ),
            ),

            /// SUBTITLE
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                color: Colors.black.withValues(alpha:.6),
              ),
            ),
          ],
        ),
      ),
    );
  }


  /// GLASS CARD (TRANSPARENT EFFECT)
  Widget _glassCard({required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Colors.white.withValues(alpha:.65),
            border: Border.all(
              color: Colors.white.withValues(alpha:.4),
            ),
          ),
          child: child,
        ),
      ),
    );
  }



  Widget _viewActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required Color iconColor,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),

      child: Container(
        margin: const EdgeInsets.only(bottom: 12),

        child: _glassCard(
          child: Row(
            children: [

              /// ICON CONTAINER
              Container(
                height: 42,
                width: 42,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha:.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: iconColor),
              ),

              const SizedBox(width: 12),

              /// TEXT
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),

                    const SizedBox(height: 2),

                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),

              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: Colors.black,
              )
            ],
          ),
        ),
      ),
    );
  }




  Widget _buildLocationCard() {
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


        border: Border.all(
          color: Colors.blue.withValues(alpha:.55),
        ),

        boxShadow: [
          BoxShadow(color: Colors.blue.withValues(alpha:0.05), blurRadius: 10),
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
                value: "${storageService.getString(AppConstants.prefStateName)}",
              ),

              _verticalDivider(),

              _locationItemWithIcon(
                icon: Icons.place,
                color: Color(0xFFE53935),
                title: "District",
                value: "${storageService.getString(AppConstants.prefDistrictName)}",
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
                value: "${storageService.getString(AppConstants.prefBlockName)}",
              ),

              _verticalDivider(),

              _locationItemWithIcon(
                icon: Icons.home,
                color: Color(0xFF00796B),
                title: "GP",
                value:
                    "${storageService.getString(AppConstants.prefPanchayatName)}",
              ),
            ],
          ),

          const SizedBox(height: 5),

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
          builder: (context) => AlertDialog(
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
