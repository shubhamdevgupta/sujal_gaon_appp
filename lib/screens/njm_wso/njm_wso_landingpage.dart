import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jal_sanchalan/providers/njm_ftk_provider.dart';
import 'package:jal_sanchalan/providers/njm_wso/njm_wso_provider.dart';
import 'package:jal_sanchalan/utils/loader_utils.dart';
import 'package:jal_sanchalan/utils/toast_helper.dart';
import 'package:provider/provider.dart';

import '../../providers/authentication_provider.dart';
import '../../service/local_storage_service.dart';
import '../../utils/app_constants.dart';
import '../../utils/auth/user_session_manager.dart';
import '../../utils/custom_password_set.dart';
import '../../utils/enum/user_type.dart';
import '../widgets/app_dropdown.dart';

class NjmWsoLandingpage extends StatefulWidget {
  const NjmWsoLandingpage({super.key});

  @override
  State<NjmWsoLandingpage> createState() => _NjmWsoLandingpageState();
}

class _NjmWsoLandingpageState extends State<NjmWsoLandingpage> {
  final session = UserSessionManager();
  final LocalStorageService _localStorage = LocalStorageService();
  bool passwordMatch = true;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = context.read<NjmFtkProvider>();

      await provider.fetchDeviceId();
      await session.init();



      /// CASE 1: Password login already stored userId
      if (session.userId != 0) {
        await provider.fetchNjmFtkDashboard(session.userId, UserType.njmp.id);
        return;
      }

      if (_localStorage.getInt(AppConstants.prefIsPassUpdated) == 0) {
        _showPasswordDialog();
      } else {
        await provider.fetchNjmFtkDashboard(session.userId, UserType.njmp.id);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    final njmFtkProvider = context.watch<NjmFtkProvider>();

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
          title: const Text(
            "Sujal Gaon",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
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
        ),

        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [const Color(0xFF64B5F6), Colors.blue.shade50],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),

          child: Stack(
            children: [
              /// STEP 3: show dashboard only when dashboard data available
              njmFtkProvider.njmFtkDashboardResponse == null
                  ? const SizedBox()
                  : SingleChildScrollView(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),

                          _buildWelcomeCard(),

                          const SizedBox(height: 20),

                          _dashboardCard(context),

                          const SizedBox(height: 16),
                        ],
                      ),
                    ),

              /// Loader
              LoaderUtils.conditionalLoader(
                isLoading: njmFtkProvider.isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }



  void _showPasswordDialog() {
    final provider = context.read<NjmFtkProvider>();
    final res = provider.njmFtkLoginResponse!;

    CreatePasswordDialog.show(
      context,
      name: res.name ?? "",
      email: res.email ?? "",
      mobile: res.mobileNumber ?? "",
      onSubmit: (password) async {

        if (password.isEmpty) {
          ToastHelper.showErrorSnackBar(context, "Enter valid password");
          return;
        }

        await provider.updateNjmFtkPasswords(
          res.regId!,
          UserType.njmp.id,
          res.mobileNumber!,
          res.mobileNumber!,
          provider.generateSha512Pass(password),
          res.regId!,
          provider.deviceId!,
        );

        if (provider.updateNjmFtkPassword?.status == true) {

          /// ✅ Success Toast
          ToastHelper.showSuccessSnackBar(
            context,
            "Password created successfully",
          );

          /// Load dashboard
          await provider.fetchNjmFtkDashboard(
            provider.updateNjmFtkPassword!.userId ?? 0,
            UserType.njmp.id,
          );
        } else {
          /// ❌ Error Toast
          ToastHelper.showErrorSnackBar(
            context,
            "Failed to create password. Please try again.",
          );
        }
      },
    );
  }

  Widget _dashboardCard(BuildContext context) {
    final provider = context.read<NjmFtkProvider>();
    final njmWsoProvider = context.read<NjmWsoProvider>();

    return Container(
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
                    ],
                  ),

                  SizedBox(height: 8),

                  const Text(
                    "Overview Your Njm/Wso Area",
                    style: TextStyle(color: Colors.black87, fontSize: 13),
                  ),

                  const SizedBox(height: 8),

                  // ================= INNER WHITE CARD =================
                  _buildLocationCard(),

                  SizedBox(height: 20),
                  Text(
                    'Select Habitation',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  SizedBox(height: 2),

                  AppDropdown(
                    hint: "Select Habitation",
                    items: provider!.njmFtkDashboardResponse!.habitationList!
                        .map((e) => e.habitationName ?? "")
                        .toList(),
                    onChanged: (value) {
                      final selected = provider
                          .njmFtkDashboardResponse!
                          .habitationList!
                          .firstWhere((e) => e.habitationName == value);

                      njmWsoProvider.setSelectedHabitationId(selected.habitationId);

                      print("Habitation Name: ${selected.habitationName}");
                      print("Habitation Id: ${selected.habitationId}");
                    },
                  ),

                  SizedBox(height: 15),
                  _registerCard(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _registerCard(BuildContext context) {
    final njmWsoProvider = context.watch<NjmWsoProvider>();

    return GestureDetector(
      onTap: () {

        if (njmWsoProvider.selectedHabitationId != 0 &&
            njmWsoProvider.selectedHabitationId != null) {
          Navigator.pushNamed(context, AppConstants.navigateToNjmCategory);
        } else {
          ToastHelper.showErrorSnackBar(
            context,
            "please select Habitation First !!",
          );
        }
      },

      child: Column(
        children: [
          Container (
            height: 60,
            padding: const EdgeInsets.all(8),

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),

              gradient: const LinearGradient(
                colors: [Color(0xFF64B5F6), Color(0xFF1E88E5)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),

              boxShadow: [
                BoxShadow(color: Colors.blue.withOpacity(0.25), blurRadius: 10),
              ],
            ),

            child: Row(
              children: [

                const Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Proceed  ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 10,),

          Container (
            height: 60,
            padding: const EdgeInsets.all(8),

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),

              gradient: const LinearGradient(
                colors: [Color(0xFF64B5F6), Color(0xFF1E88E5)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),

              boxShadow: [
                BoxShadow(color: Colors.blue.withOpacity(0.25), blurRadius: 10),
              ],
            ),

            child: Row(
              children: [

                const Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Regular Entry",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationCard() {
    final provider = context.watch<NjmFtkProvider>();

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
                value: "${provider.njmFtkDashboardResponse!.stateName}",
              ),

              _verticalDivider(),

              _locationItemWithIcon(
                icon: Icons.place,
                color: Color(0xFFE53935),
                title: "District",
                value: "${provider.njmFtkDashboardResponse!.districtName}",
                subTitle: "LGD Code",
                subTitleValue:
                    "${provider.njmFtkDashboardResponse!.districtLgdcode}",
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
                value: "${provider.njmFtkDashboardResponse!.blockName}",
                subTitle: "LGD Code",
                subTitleValue:
                    "${provider.njmFtkDashboardResponse!.blockLgdcode}",
              ),

              _verticalDivider(),

              _locationItemWithIcon(
                icon: Icons.home,
                color: Color(0xFF00796B),
                title: "GP",
                value: "${provider.njmFtkDashboardResponse!.panchayatName}",
                subTitle: "LGD Code",
                subTitleValue:
                    "${provider.njmFtkDashboardResponse!.panchayatLgdcode}",
              ),
            ],
          ),

          const SizedBox(height: 5),

          const Divider(),

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

  Widget _buildWelcomeCard() {
    final provider = context.watch<NjmFtkProvider>();

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

                children: [
                  Text(
                    "Welcome Back 👋",
                    style: TextStyle(color: Colors.white70),
                  ),

                  SizedBox(height: 6),

                  Text(
                    "${provider.njmFtkDashboardResponse!.firstName ?? ""}${provider.njmFtkDashboardResponse!.lastName ?? ""}",
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
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _showExitDialog() async {
    final shouldExit = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Exit App"),
        content: const Text("Are you sure you want to exit the application?"),
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
    );

    if (shouldExit == true) {
      if (Platform.isAndroid) {
        SystemNavigator.pop(); // 🔥 closes app
      } else if (Platform.isIOS) {
        exit(0); // not recommended by Apple but works
      }
    }

    return false; // 🔥 prevent default pop
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
