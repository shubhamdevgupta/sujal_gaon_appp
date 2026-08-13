import 'package:flutter/material.dart';
import 'package:jal_sanchalan/utils/custom%20screen/app_text_field.dart';
import 'package:provider/provider.dart';

import '../../../providers/authentication_provider.dart';
import '../../../utils/app_constants.dart';

class DwsmLogin extends StatefulWidget {
  const DwsmLogin({super.key});

  @override
  State<DwsmLogin> createState() => _DwsmLoginState();
}

class _DwsmLoginState extends State<DwsmLogin> {
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AuthenticationProvider>();
    return Scaffold(
      backgroundColor: const Color(0xFFEAF4FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1565C0),
        title: const Text("Login", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        automaticallyImplyLeading: false,
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
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 30),

                /// App Name
                const Text(
                  "Sujalam Bharat",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0C4A6E),
                  ),
                ),
                Text(
                  "Utility App",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.8,
                    color: Color(0xFF0C4A6E),
                  ),
                ),

                const SizedBox(height: 40),

                const Text(
                  "DWSM Login",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0C4A6E),
                  ),
                ),

                const SizedBox(height: 2),

                const Text(
                  "Login using your registered DWSM credentials",
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF64748B),
                  ),
                ),

                const SizedBox(height: 12),
                /// Main Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha:0.42),
                    // Transparency5
                    borderRadius: BorderRadius.circular(22),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withValues(alpha:0.15),
                        blurRadius: 20,
                        spreadRadius: 2,
                        offset: const Offset(0, 8),
                      ),
                    ],

                    border: Border.all(
                      color: Colors.white.withValues(alpha:0.4),
                      // Glass border
                      width: 1.2,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Mobile Number
                      const Text(
                        "Registered Username",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),

                      const SizedBox(height: 6),

                      AppTextField(
                        controller: mobileController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.phone),
                          hintText: "Enter Username",
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

                      const SizedBox(height: 10),

                      /// Password
                      const Text(
                        "Password",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),

                      const SizedBox(height: 6),

                      TextField(
                        controller: passwordController,
                        obscureText: !provider.isShownPassword,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          hintText: "Enter Password",
                          suffixIcon: IconButton(
                            icon: Icon(
                              provider.isShownPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.blueGrey,
                            ),
                            onPressed: provider.togglePasswordVisibility,
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
                          onPressed: () async {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              AppConstants.navigateToDwsmLandingPage,
                              (route) => false,
                            );
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
}
