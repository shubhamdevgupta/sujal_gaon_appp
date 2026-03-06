import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:jal_sanchalan/utils/enum/user_type.dart';
import 'package:provider/provider.dart';
import '../../providers/authentication_provider.dart';
import '../../utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/authentication_provider.dart';
import '../../utils/app_constants.dart';

class FtkShgLogin extends StatefulWidget {
  const FtkShgLogin({super.key});

  @override
  State<FtkShgLogin> createState() => _FtkShgLogin();
}

class _FtkShgLogin extends State<FtkShgLogin> {
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  bool isPasswordVisible = false;
  bool isOtpMode = false;
  bool isOtpSent = false;

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthenticationProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFEAF4FF),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
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
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 30),

              const CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.water_drop,
                  size: 40,
                  color: Color(0xFF1565C0),
                ),
              ),

              const SizedBox(height: 15),

              const Text(
                "Sujal Gaon App",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1565C0),
                ),
              ),

              const SizedBox(height: 25),

              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "FTK/SGH User Login",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// Mobile
                    const Text("Registered Mobile Number"),
                    const SizedBox(height: 6),
                    TextField(
                      controller: mobileController,
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      decoration: _inputDecoration(
                        "Enter Mobile Number",
                        Icons.phone,
                      ),
                    ),

                    const SizedBox(height: 15),

                    /// PASSWORD LOGIN
                    if (!isOtpMode) ...[
                      const Text("Password"),
                      const SizedBox(height: 6),
                      TextField(
                        controller: passwordController,
                        obscureText: !authProvider.isShownPassword,
                        decoration: _inputDecoration(
                          "Enter Password",
                          Icons.lock,
                          suffix: IconButton(
                            icon: Icon(
                              authProvider.isShownPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: context
                                .read<AuthenticationProvider>()
                                .togglePasswordVisibility,
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),

                      _mainButton(
                        text: "Login",
                        isLoading: authProvider.isLoading,
                        onTap: loginWithPassword,
                      ),
                    ],

                    /// OTP LOGIN
                    if (isOtpMode) ...[
                      if (!isOtpSent)
                        _mainButton(
                          text: "Send OTP",
                          isLoading: authProvider.isLoading,
                          onTap: sendOTP,
                        )
                      else ...[
                        const Text("Enter OTP"),
                        const SizedBox(height: 6),
                        TextField(
                          controller: otpController,
                          keyboardType: TextInputType.number,
                          maxLength: 6,
                          decoration: _inputDecoration("Enter OTP", Icons.sms),
                        ),
                        const SizedBox(height: 20),
                        _mainButton(
                          text: "Verify OTP",
                          isLoading: authProvider.isLoading,
                          onTap: verifyOTP,
                        ),
                      ],
                    ],

                    const SizedBox(height: 15),

                    Center(
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            isOtpMode = !isOtpMode;
                            isOtpSent = false;
                            otpController.clear();
                          });
                        },
                        child: Text(
                          isOtpMode
                              ? "Login using Password"
                              : "Or, Verify using OTP",
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
    );
  }

  // ===================== LOGIC ======================

  void loginWithPassword() {
    final provider = context.read<AuthenticationProvider>();

    String mobile = mobileController.text.trim();
    String password = passwordController.text.trim();

    if (mobile.length != 10 || password.isEmpty) {
      showMessage("Enter valid details");
      return;
    }

   /* provider.panchayatLoginUser(
      mobile,
      password,
      "1",
      () {
        Navigator.pushNamed(context, AppConstants.navigateToNJMLandingScreen);
      },
      (error) {
        showMessage(error ?? "Login Failed");
      },
    );*/
  }

  void sendOTP() {
    final provider = context.read<AuthenticationProvider>();
    String mobile = mobileController.text.trim();

    if (mobile.length != 10) {
      showMessage("Enter valid mobile number");
      return;
    }

    provider.loginNjmFtkUserByOtp(
      mobile,
      UserType.ftk.id,
      () {
        showMessage("OTP Sent Successfully");
        setState(() {
          isOtpSent = true;
        });
      },
      (error) {
        showMessage(error ?? "Failed to send OTP");
      },
    );
  }

  void verifyOTP() {
    final provider = context.read<AuthenticationProvider>();

    String enteredOtp = otpController.text.trim();

    if (enteredOtp.length != 6) {
      showMessage("Enter valid OTP");
      return;
    }

    provider.verifyOtp(
      enteredOtp,
      () {
        Navigator.pushNamed(context, AppConstants.navigateToFtkLandingpage);
      },
      (error) {
        showMessage(error);
      },
    );
  }

  // ================= UI HELPERS =================

  Widget _mainButton({
    required String text,
    required bool isLoading,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: isLoading ? null : onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1565C0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(
                text,
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
      ),
    );
  }

  InputDecoration _inputDecoration(
    String hint,
    IconData icon, {
    Widget? suffix,
  }) {
    return InputDecoration(
      prefixIcon: Icon(icon),
      hintText: hint,
      counterText: "",
      suffixIcon: suffix,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF1565C0)),
      ),
    );
  }

  void showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}