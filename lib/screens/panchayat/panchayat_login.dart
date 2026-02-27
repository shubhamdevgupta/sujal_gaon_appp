import 'package:flutter/material.dart';
import 'package:jal_sanchalan/providers/authentication_provider.dart';
import 'package:jal_sanchalan/utils/custom%20screen/app_text_field.dart';
import 'package:provider/provider.dart';

import '../../utils/app_constants.dart';
import '../../utils/toast_helper.dart';

class PanchayatLogin extends StatefulWidget {
  const PanchayatLogin({super.key});

  @override
  State<PanchayatLogin> createState() => _PanchayatLoginState();
}

class _PanchayatLoginState extends State<PanchayatLogin> {
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController captchaController = TextEditingController();

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
                    color: Colors.white.withOpacity(0.42),
                    // Transparency5
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
                      color: Colors.white.withOpacity(0.4),
                      // Glass border
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
                            "Gram Panchayat Login",
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
                        "Registered Mobile/Username",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),

                      const SizedBox(height: 6),

                      AppTextField(
                        controller: mobileController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.phone),
                          hintText: "Enter Mobile Number or Username",
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

                /*      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 50,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF1F3F4),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '${provider.randomOne} + ${provider.randomTwo} = ?',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'OpenSans',
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          InkWell(
                            onTap: provider.generateCaptcha,
                            borderRadius: BorderRadius.circular(30),
                            child: CircleAvatar(
                              backgroundColor: Colors.blue.shade50,
                              child: const Icon(
                                Icons.refresh,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 25),*/

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
                            Navigator.pushReplacementNamed(
                              context,
                              AppConstants.navigateToPanchayatLandingScreen,
                            );
                         /*     provider.loginUser(
                                mobileController.text,
                                passwordController.text,
                                () {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    AppConstants.navigateToPanchayatDashboard,
                                  );
                                },
                                (errorMessage) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(errorMessage)),
                                  );
                                  ToastHelper.showToastMessage(errorMessage);
                                },
                              );*/


                            Navigator.pushNamed(
                              context,
                              AppConstants.navigateToPanchayatLandingScreen,
                            );
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),

                      /*          /// OR
                      const Center(
                        child: Text(
                          "Or, Verify using OTP",
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),

                      const SizedBox(height: 15),

                      /// Send OTP
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFF1565C0)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            sendOTP();
                          },
                          child: const Text(
                            "Send OTP",
                            style: TextStyle(
                              color: Color(0xFF1565C0),
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// Register
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don’t have an account? "),
                          GestureDetector(
                            onTap: () {
                              // Navigate to Register Screen
                            },
                            child: const Text(
                              "Register Now",
                              style: TextStyle(
                                color: Color(0xFF1565C0),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),*/
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

  bool validateLoginInput(AuthenticationProvider provider) {
    String password = passwordController.text.trim();
    String captcha = captchaController.text.trim();

    int? enteredCaptcha = int.tryParse(captcha);
    // Using a single if-else statement
    provider.errorMsg = (password.isNotEmpty
        ? (captcha.isNotEmpty &&
                  enteredCaptcha ==
                      provider
                          .captchResult // Compare as int
              ? ""
              : "Please Enter Correct Captcha")
        : "Please Enter Password");

    return provider.errorMsg.isEmpty;
  }
}
