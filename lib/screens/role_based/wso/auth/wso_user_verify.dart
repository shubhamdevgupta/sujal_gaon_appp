import 'package:flutter/material.dart';
import 'package:jal_sanchalan/screens/widgets/user_card.dart';

import '../../../../utils/app_constants.dart';

class WsoUserVerifyPage extends StatefulWidget {
  const WsoUserVerifyPage({super.key});

  @override
  State<WsoUserVerifyPage> createState() => _WsoUserVerifyState();
}

class _WsoUserVerifyState extends State<WsoUserVerifyPage> {
  // User details
  String name = "Shubham Gupta";
  String email = "hutesjk@gmail.com";
  String village = "My Village";
  String phone = "8650922082";
  String trainingLevel = "Intermediate";
  String address = "Rohini Delhi";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF4FF),

      // ----------------------------------------------------------
      // YOUR EXISTING APP BAR - UNCHANGED
      // ----------------------------------------------------------
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF1565C0),
        title: const Text(
          "User Verified",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),

      // ----------------------------------------------------------
      // YOUR EXISTING BACKGROUND - UNCHANGED
      // ----------------------------------------------------------
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/icons/SJL_bg.png"),
            fit: BoxFit.cover,
          ),
        ),

        // --------------------------------------------------------
        // CENTER USER CARD + BUTTONS
        // --------------------------------------------------------
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // =================================================
                // USER CARD
                // =================================================
                UserCard(
                  name: name,
                  email: email,
                  village: village,
                  phone: phone,
                  trainingLevel: trainingLevel,
                  address: address,
                ),

                const SizedBox(height: 25),

                // =================================================
                // EDIT + PROCEED BUTTONS
                // =================================================
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ------------------------------------------------
                    // EDIT BUTTON
                    // ------------------------------------------------
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: OutlinedButton.icon(
                          onPressed: _showEditDialog,
                          icon: const Icon(Icons.edit, size: 19),
                          label: const Text(
                            "Edit",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 15),

                    // ------------------------------------------------
                    // PROCEED BUTTON
                    // ------------------------------------------------
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              AppConstants.navigateToWSOLandingPage,
                              (route) => false,
                            );
                          },
                          icon: const Icon(
                            Icons.arrow_forward,
                            size: 19,
                            color: Colors.white,
                          ),
                          label: const Text(
                            "Proceed",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1565C0),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // =============================================================
  // EDIT DIALOG
  // =============================================================

  void _showEditDialog() {
    final nameController = TextEditingController(text: name);
    final emailController = TextEditingController(text: email);
    final villageController = TextEditingController(text: village);
    final phoneController = TextEditingController(text: phone);
    final trainingController = TextEditingController(text: trainingLevel);
    final addressController = TextEditingController(text: address);

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            "Edit User Details",
            style: TextStyle(
              color: Color(0xFF1565C0),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: "Name",
                    prefixIcon: Icon(Icons.person),
                  ),
                ),

                const SizedBox(height: 10),

                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    prefixIcon: Icon(Icons.email),
                  ),
                ),

                const SizedBox(height: 10),

                TextField(
                  controller: villageController,
                  decoration: const InputDecoration(
                    labelText: "Village",
                    prefixIcon: Icon(Icons.location_city),
                  ),
                ),

                const SizedBox(height: 10),

                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: "Phone",
                    prefixIcon: Icon(Icons.phone),
                  ),
                ),

                const SizedBox(height: 10),

                TextField(
                  controller: trainingController,
                  decoration: const InputDecoration(
                    labelText: "Training Level",
                    prefixIcon: Icon(Icons.school),
                  ),
                ),

                const SizedBox(height: 10),

                TextField(
                  controller: addressController,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    labelText: "Address",
                    prefixIcon: Icon(Icons.home),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            // CANCEL
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
            ),

            // SAVE
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1565C0),
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  name = nameController.text.trim();
                  email = emailController.text.trim();
                  village = villageController.text.trim();
                  phone = phoneController.text.trim();
                  trainingLevel = trainingController.text.trim();
                  address = addressController.text.trim();
                });

                Navigator.pop(dialogContext);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }
}
