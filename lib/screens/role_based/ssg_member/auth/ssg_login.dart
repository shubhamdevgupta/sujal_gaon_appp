import 'package:flutter/material.dart';
import 'package:jal_sanchalan/providers/wso_ssg_provider.dart';
import 'package:jal_sanchalan/utils/enum/user_type.dart';
import 'package:provider/provider.dart';

import '../../../../providers/authentication_provider.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/toast_helper.dart';

class SSGMemberLogin extends StatefulWidget {
  const SSGMemberLogin({super.key});

  @override
  State<SSGMemberLogin> createState() => _SSGMemberLogin();
}

class _SSGMemberLogin extends State<SSGMemberLogin> {
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  bool isPasswordVisible = false;
  bool isOtpMode = false;
  bool isOtpSent = false;

  @override
  Widget build(BuildContext context) {
    final njmFtkProvider = context.watch<WsoSSGProvider>();

    return Scaffold(
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
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
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
                "Sujalam Shakti Login",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0C4A6E),
                ),
              ),

              const SizedBox(height: 2),

              const Text(
                "Login using your registered Sujalam Shakti credentials",
                style: TextStyle(fontSize: 13, color: Color(0xFF64748B)),
              ),

              const SizedBox(height: 12),

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
                        obscureText: !njmFtkProvider.isShownPassword,
                        decoration: _inputDecoration(
                          "Enter Password",
                          Icons.lock,
                          suffix: IconButton(
                            icon: Icon(
                              njmFtkProvider.isShownPassword
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
                        isLoading: njmFtkProvider.isLoading,
                        onTap: (){
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            AppConstants.navigateToSSGLandingpage,
                                (route) => false,
                          );
                        },
                      ),
                    ],

                    /// OTP LOGIN
                    if (isOtpMode) ...[
                      if (!isOtpSent)
                        _mainButton(
                          text: "Send OTP",
                          isLoading: njmFtkProvider.isLoading,
                          onTap: () {
                            final provider = context.read<WsoSSGProvider>();
                            String mobile = mobileController.text.trim();

                            if (mobile.length != 10) {
                              showMessage("Enter valid mobile number");
                              return;
                            }

                            provider.loginWsoSSGUserByOtp(
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
                          },
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
                          isLoading: njmFtkProvider.isLoading,
                          onTap: () {
                            final provider = context.read<WsoSSGProvider>();

                            String enteredOtp = otpController.text.trim();

                            if (enteredOtp.length != 6) {
                              showMessage("Enter valid OTP");
                              return;
                            }
                            provider.verifyOtp(
                              enteredOtp,
                              () {
                                Navigator.pushNamed(
                                  context,
                                  AppConstants.navigateToSSGLandingpage,
                                );
                              },
                              (error) {
                                showMessage(error);
                              },
                            );
                          },
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

  void loginWithPassword() async {
    final provider = context.read<WsoSSGProvider>();

    String mobile = mobileController.text.trim();
    String password = passwordController.text.trim();

    if (mobile.length != 10 || password.isEmpty) {
      showMessage("Enter valid details");
      return;
    }

    await provider.loginWsoSSGUserByPassword(
      mobile,
      password,
      UserType.ftk.id,
      () {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppConstants.navigateToSSGLandingpage,
          (route) => false,
        );
      },
      (errorMessage) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(errorMessage)));
        ToastHelper.showToastMessage(errorMessage);
      },
    );
  }

  void sendOTP() {
    final provider = context.read<WsoSSGProvider>();
    String mobile = mobileController.text.trim();

    if (mobile.length != 10) {
      showMessage("Enter valid mobile number");
      return;
    }

    provider.loginWsoSSGUserByOtp(
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
    final provider = context.read<WsoSSGProvider>();

    String enteredOtp = otpController.text.trim();

    if (enteredOtp.length != 6) {
      showMessage("Enter valid OTP");
      return;
    }

    provider.verifyOtp(
      enteredOtp,
      () {
        Navigator.pushNamed(context, AppConstants.navigateToSSGLandingpage);
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
