import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/master_provider.dart';
import '../../utils/app_constants.dart';

class GpLoginDashboardScreen extends StatelessWidget {
  const GpLoginDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final master = context.watch<MasterProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),

      // ================= Bottom Bar =================
      bottomNavigationBar: _buildBottomNav(),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              _buildHeader(context),

              const SizedBox(height: 20),

              _buildWelcomeCard(),

              const SizedBox(height: 20),

              _buildLocationCard(master),

              const SizedBox(height: 25),

              _buildVillageSection(
                "VWSC Formed Villages",
                const [
                  {"name": "Abhaudopura", "members": 2},
                ],
              ),

              const SizedBox(height: 20),

              _buildVillageSection(
                "Pani Samiti Formed Villages",
                const [
                  {"name": "Abhaudopura", "members": 2},
                ],
              ),

              const SizedBox(height: 30),

              _buildRegisterButton(context),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // =================================================
  // Header
  // =================================================
  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            // 🔙 Back Button
            InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(
                  context,
                  AppConstants.navigateToLandingScreen,
                );
              },

              borderRadius:  BorderRadius.circular(20),

              child: const Padding(
                padding: EdgeInsets.all(4),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ),
            SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Sujal Gaon",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 2),

                Text(
                  "Jal Jeevan Mission",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ],
        ),



        Row(
          children: [

            _iconBadge(Icons.notifications, "2"),

            const SizedBox(width: 12),

            const CircleAvatar(
              radius: 22,
              backgroundColor: Color(0xFF1E88E5),
              child: Icon(Icons.person, color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }

  Widget _iconBadge(IconData icon, String count) {
    return Stack(
      children: [
        Icon(icon, size: 28, color: Colors.blue),

        Positioned(
          right: 0,
          top: 0,
          child: CircleAvatar(
            radius: 8,
            backgroundColor: Colors.red,
            child: Text(
              count,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
              ),
            ),
          ),
        )
      ],
    );
  }

  // =================================================
  // Welcome Card (Glass Effect)
  // =================================================
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

  // =================================================
  // Location Card
  // =================================================
  Widget _buildLocationCard(MasterProvider masterProvider) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(16),

      decoration: _cardDecoration(),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          // Header
          Row(
            children: const [

              CircleAvatar(
                radius: 16,
                backgroundColor: Color(0xFFE3F2FD),

                child: Icon(
                  Icons.location_on,
                  color: Color(0xFF1976D2),
                  size: 20,
                ),
              ),

              SizedBox(width: 10),

              Text(
                "Your Location",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          const Divider(),

          const SizedBox(height: 10),

          // Row 1
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

          const SizedBox(height: 12),

          _horizontalLine(),

          const SizedBox(height: 12),

          // Row 2
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

          const SizedBox(height: 12),

          _horizontalLine(),

          const SizedBox(height: 12),

          // Row 3
          Row(
            children: [

              _locationItemWithIcon(
                icon: Icons.holiday_village,
                color: Colors.blue,
                title: "Village",
                value: "Gohana",
              ),

              _verticalDivider(),

              _locationItemWithIcon(
                icon: Icons.house_siding,
                color: Color(0xFF5D4037),
                title: "Habitation",
                value: "Hooda",
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
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: Colors.grey.shade200,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.04),
          blurRadius: 15,
          offset: const Offset(0, 8),
        ),
      ],
    );
  }

  Widget _horizontalLine() {
    return Container(
      height: 1,
      width: double.infinity,
      color: Colors.grey.shade300,
    );
  }

  Widget _verticalDivider() {
    return Container(
      width: 1,
      height: 45,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      color: Colors.grey.shade300,
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
                title,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 2),

              Text(
                value,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }  Widget _locationRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),

      child: Row(
        children: [

          SizedBox(
            width: 90,
            child: Text(
              title,
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),
          ),

          const Text(":  "),

          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =================================================
  // Village Section
  // =================================================
  Widget _buildVillageSection(String title, List data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        _sectionTitle(title),

        const SizedBox(height: 10),

        if (data.isEmpty)

          _card(
            child: const Text(
              "No Records Found",
              style: TextStyle(color: Colors.red),
            ),
          )

        else

          ...data.map((v) {

            return _card(
              margin: const EdgeInsets.only(bottom: 10),

              child: Row(
                children: [

                  const Icon(
                    Icons.location_city,
                    color: Colors.blue,
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Text(
                      v["name"],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  _chip("${v["members"]} Members"),
                ],
              ),
            );
          }).toList(),
      ],
    );
  }

  Widget _chip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),

      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(.1),
        borderRadius: BorderRadius.circular(20),
      ),

      child: Text(
        text,
        style: const TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // =================================================
  // Register Button
  // =================================================
  Widget _buildRegisterButton(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushReplacementNamed(
          context,
          AppConstants.navigateToLandingScreen,
        );
      },

      child: Container(
        width: double.infinity,
        height: 60,

        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF1E88E5),
              Color(0xFF0D47A1),
            ],
          ),

          borderRadius: BorderRadius.circular(30),

          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(.3),
              blurRadius: 15,
              offset: const Offset(0, 6),
            )
          ],
        ),

        child: const Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,

            children: [

              Icon(
                Icons.water_drop,
                color: Colors.white,
              ),

              SizedBox(width: 10),

              Text(
                "Register VWSC Member",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // =================================================
  // Bottom Navigation
  // =================================================
  Widget _buildBottomNav() {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
          )
        ],
      ),

      child: BottomNavigationBar(
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
            icon: Icon(Icons.bar_chart),
            label: "Reports",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }

  // =================================================
  // Common Widgets
  // =================================================
  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _card({
    required Widget child,
    EdgeInsets? margin,
  }) {
    return Container(
      margin: margin,

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: child,
    );
  }
}
