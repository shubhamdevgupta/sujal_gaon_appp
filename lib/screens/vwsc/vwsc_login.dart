import 'package:flutter/material.dart';

import '../../utils/app_constants.dart';

class VwscLogin extends StatefulWidget {
  const VwscLogin({super.key});

  @override
  State<VwscLogin> createState() => _VwscLogin();
}

class _VwscLogin extends State<VwscLogin> {
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF4FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1565C0),
        title: const Text("Login", style: TextStyle(color: Colors.white)),
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 30),

                /// Logo
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.2),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.water_drop,
                    size: 40,
                    color: Color(0xFF1565C0),
                  ),
                ),

                const SizedBox(height: 15),

                /// App Name
                const Text(
                  "Sujal Gaon App",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1565C0),
                  ),
                ),

                const SizedBox(height: 25),

                /// Main Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.42), // Transparency5
                    borderRadius: BorderRadius.circular(22),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.15),
                        blurRadius: 20,
                        spreadRadius: 2,
                        offset: const Offset(0, 8),
                      ),
                    ],

                    border: Border.all(
                      color: Colors.white.withOpacity(0.4), // Glass border
                      width: 1.2,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Gram Panchayat Login
                      Row(
                        children: const [
                          Icon(Icons.account_balance, color: Color(0xFF1565C0)),
                          SizedBox(width: 8),
                          Text(
                            "VWSC User Login",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      /// Mobile Number
                      const Text(
                        "Registered Mobile Number",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),

                      const SizedBox(height: 6),

                      TextField(
                        controller: mobileController,
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.phone),
                          hintText: "Enter Mobile Number",
                          counterText: "",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFF1565C0),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),

                      /// Password
                      const Text(
                        "Password",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),

                      const SizedBox(height: 6),

                      TextField(
                        controller: passwordController,
                        obscureText: !isPasswordVisible,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          hintText: "Enter Password",
                          suffixIcon: IconButton(
                            icon: Icon(
                              isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFF1565C0),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 25),

                      /// Login Button
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1565C0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              AppConstants.navigateToVWSCLandingScreen,
                            );

                            loginUser();
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Login Method
  void loginUser() {
    String mobile = mobileController.text.trim();
    String password = passwordController.text.trim();

    if (mobile.isEmpty || password.isEmpty) {
      showMessage("Please enter all fields");
      return;
    }

    // TODO: Call API here
    showMessage("Login Clicked");
  }

  /// Send OTP Method
  void sendOTP() {
    String mobile = mobileController.text.trim();

    if (mobile.isEmpty) {
      showMessage("Enter mobile number first");
      return;
    }

    // TODO: Send OTP API
    showMessage("OTP Sent");
  }

  void showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
