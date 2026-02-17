import 'dart:ui';

import 'package:flutter/material.dart';

import '../utils/app_constants.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F6FF),

      appBar: AppBar(
        centerTitle: true,

        elevation: 0,

        backgroundColor: const Color(0xFF1565C0),

        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),

        title: const Text(
          "Sujal Gaon",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),


      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: "History",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: "Reports",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),


        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*_buildCustomHeader(),*/
            // ================= WELCOME =================

            const SizedBox(height: 20),


            _buildWelcomeCard(),

            // ================= DASHBOARD =================
            _dashboardCard(context),

            const SizedBox(height: 16),
         /*   InkWell(onTap: () { Navigator.pushReplacementNamed(
                context,AppConstants.navigateToGpLogin);},child: _dashboard(context)),*/
            const SizedBox(height: 16),
            // ================= REGISTER =================
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _registerCard(context),
            ),

            const SizedBox(height: 16),

            // ================= LIST =================
            _listCard(context),
          ],
        ),
      ),
    );
  }
  Widget _buildCustomHeader() {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22), // ✅ All sides rounded

        gradient: const LinearGradient(
          colors: [
            Colors.blue, // soft red
            Color(0xFF1E5DB8), // deep blue
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: Column(
        mainAxisSize: MainAxisSize.min, // ✅ Prevent extra height
        children: [

          // ================= TOP BAR =================
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 1, 14, 6), // ✅ Reduced height

            child: SafeArea(
              bottom: false,

              child: Row(
                children: [

                  // Logo
                  Container(
                    padding: const EdgeInsets.all(6),

                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),

                    child: const Icon(
                      Icons.water_drop,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),

                  const SizedBox(width: 8),

                  // Title
                  const Text(
                    "Sujal Gaon App",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const Spacer(),

                  // Notification
                  Stack(
                    children: [

                      const Icon(
                        Icons.notifications,
                        color: Colors.white,
                        size: 22,
                      ),

                      Positioned(
                        right: 0,
                        top: 0,

                        child: Container(
                          padding: const EdgeInsets.all(3),

                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),

                          child: const Text(
                            "3",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(width: 12),

                  // ================= PROFILE IMAGE =================
                  CircleAvatar(
                    radius: 13,
                    backgroundColor: Colors.white,

                    backgroundImage:
                    const AssetImage('assets/icons/user_icon.png'),
                  ),
                ],
              ),
            ),
          ),

          // ================= WELCOME STRIP =================
          Container(
            width: double.infinity,

            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 10, // ✅ Reduced height
            ),

            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.96),

              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(22),
                bottomRight: Radius.circular(22),
              ),
            ),

            child: const Text(
              "Welcome Panchayat User",
              style: TextStyle(
                fontSize: 14.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );

  }

  // =======================================================
  // DASHBOARD CARD
  // =======================================================

  Widget _dashboardCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to dashboard screen
      },

      child: Container(
        padding: const EdgeInsets.all(8),


        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),

          // Outer shadow
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.18),
              blurRadius: 25,
              offset: const Offset(0, 10),
            ),
          ],
        ),

        child: ClipRRect(
          borderRadius: BorderRadius.circular(22),

          child: Stack(
            children: [

              // ================= BACKGROUND IMAGE =================
              Positioned.fill(
                child: Image.asset(
                  "assets/icons/dashboard.png",
                    fit: BoxFit.fill,

                ),
              ),

              // ================= GRADIENT OVERLAY =================
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF64B5F6),
                        Color(0xFF1E88E5),


                      ],
                    ),
                  ),
                ),
              ),
              // ================= CONTENT =================
              Padding(
                padding: const EdgeInsets.all(16),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // Header
                    Row(
                      children: [

                        const Icon(
                          Icons.dashboard_customize,
                          color: Colors.white,
                          size: 26,
                        ),

                        const SizedBox(width: 8),

                        const Text(
                          "Dashboard",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const Spacer(),

                        IconButton(
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 16,
                          ),
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context,
                              AppConstants.navigateToGpLogin,
                            );
                          },
                        )

                      ],
                    ),

                    const SizedBox(height: 6),

                    const Text(
                      "Overview Your Panchayat Area",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // ================= INNER WHITE CARD =================

                    _buildLocationCard(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSimpleAppBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),

      decoration: const BoxDecoration(
        color: Color(0xFF1976D2), // Clean official blue
      ),

      child: SafeArea(
        bottom: false,

        child: Row(
          children: [

            // Logo
            const Icon(
              Icons.water_drop,
              color: Colors.white,
              size: 22,
            ),

            const SizedBox(width: 8),

            // Title
            const Text(
              "Sujal Gaon App",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),

            const Spacer(),

            // Notification
            Stack(
              children: [

                const Icon(
                  Icons.notifications_outlined,
                  color: Colors.white,
                  size: 22,
                ),

                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: const Text(
                      "3",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(width: 14),

            // Profile Image
            const CircleAvatar(
              radius: 14,
              backgroundImage:
              AssetImage('assets/icons/user_icon.png'),
            ),
          ],
        ),
      ),
    );
  }



  // =======================================================
  // REGISTER CARD
  // =======================================================

  Widget _dashboard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(context,
        // MaterialPageRoute(builder: (_) => RegisterVWSC()));
      },

      child: Container(
        height: 90,
        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),

          gradient: const LinearGradient(
            colors: [
              Color(0xFF64B5F6),
              Color(0xFF1E88E5),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),


          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.25),
              blurRadius: 10,
            ),
          ],
        ),

        child: Row(
          children: [

            const Icon(
              Icons.app_registration,
              color: Colors.white,
              size: 28,
            ),

            const SizedBox(width: 12),

            const Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    "Dashboard",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  SizedBox(height: 4),

                  Text(
                    "",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            IconButton(
              icon:  const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 16,
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  AppConstants.navigateToGpLogin,
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _registerCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(context,
        // MaterialPageRoute(builder: (_) => RegisterVWSC()));
      },

      child: Container(
        height: 90,
        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),

          gradient: const LinearGradient(
            colors: [
              Color(0xFF64B5F6),
              Color(0xFF1E88E5),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),


          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.25),
              blurRadius: 10,
            ),
          ],
        ),

        child: Row(
          children: [

            const Icon(
              Icons.app_registration,
              color: Colors.white,
              size: 28,
            ),

            const SizedBox(width: 12),

            const Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    "Register VWSC",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  SizedBox(height: 4),

                  Text(
                    "Register Village Committee",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            IconButton(
              icon: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 16,
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  AppConstants.navigateToRegisterVwscScreen,
                );
              },
            )
          ],
        ),
      ),
    );
  }

  // =======================================================
  // LIST CARD
  // =======================================================

  Widget _listCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(context,
        // MaterialPageRoute(builder: (_) => VWSCListScreen()));
      },

      child: Container(
        height: 90,
        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),

          color: Colors.white,

          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
            ),
          ],
        ),

        child: Row(
          children: const [

            Icon(
              Icons.list_alt,
              color: Color(0xFF1976D2),
              size: 28,
            ),

            SizedBox(width: 12),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    "List VWSC",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  SizedBox(height: 4),

                  Text(
                    "View Registered Villages",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),

            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  // =======================================================
  // HELPERS
  // =======================================================

  Widget _infoRow(
      String t1,
      String v1,
      String t2,
      String v2,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),

      child: Row(
        children: [

          Expanded(child: _infoItem(t1, v1)),

          Container(
            width: 1,
            height: 28,
            color: Colors.grey.shade300,
          ),

          Expanded(child: _infoItem(t2, v2)),
        ],
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
            Color(0xFFF8FBFF),   // very light (left)
            Color(0xFFE3F2FD),   // soft blue (middle)
            Color(0xFFD0E8FF),   // faded blue glow (right)
          ],
          stops: [0.0, 0.6, 1.0],
        ),

        border: Border.all(
          color: Colors.blue.withOpacity(0.1),
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.05),
            blurRadius: 10,
          ),
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
                value: "Haryana",
              ),

              _verticalDivider(),

              _locationItemWithIcon(
                icon: Icons.place,
                color: Color(0xFFE53935),
                title: "District",
                value: "Sonipat",
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
                value: "Gohana",
              ),

              _verticalDivider(),

              _locationItemWithIcon(
                icon: Icons.home,
                color: Color(0xFF00796B),
                title: "GP",
                value: "Hooda",
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
              _statBox("VWSC", "4"),
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
  }) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Icon(
            icon,
            color: color,
            size: 22,
          ),

          const SizedBox(width: 8),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                "${title}: ${value}",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    );
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
              colors: [
                Color(0xFF2196F3),
                Color(0xFF0D47A1),
              ],
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
                    style: TextStyle(
                      color: Colors.white70,
                    ),
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


              Container( width: 100, height: 120, decoration:
              const BoxDecoration( shape: BoxShape.circle,
                image: DecorationImage( image: AssetImage('assets/icons/user_icon.png'), fit: BoxFit.cover, ),),),

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
  Widget _horizontalDivider() {
    return Container(
      width: 150,
      height: 1,
      color: Colors.grey.shade300,
      margin: const EdgeInsets.symmetric(horizontal: 0),
    );
  }


  Widget _infoItem(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),

        const SizedBox(height: 2),

        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

}

// =======================================================
// STAT ITEM
// =======================================================



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
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}
