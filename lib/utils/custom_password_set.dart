import 'package:flutter/material.dart';

class CreatePasswordDialog extends StatefulWidget {
  final String name;
  final String email;
  final String mobile;
  final Function(String password) onSubmit;

  const CreatePasswordDialog({
    super.key,
    required this.name,
    required this.email,
    required this.mobile,
    required this.onSubmit,
  });

  static Future<void> show(
      BuildContext context, {
        required String name,
        required String email,
        required String mobile,
        required Function(String password) onSubmit,
      }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => CreatePasswordDialog(
        name: name,
        email: email,
        mobile: mobile,
        onSubmit: onSubmit,
      ),
    );
  }

  @override
  State<CreatePasswordDialog> createState() => _CreatePasswordDialogState();
}

class _CreatePasswordDialogState extends State<CreatePasswordDialog> {

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool passwordMatch = true;
  bool showPassword = false;
  bool showConfirmPassword = false;

  @override
  Widget build(BuildContext context) {

    return Dialog(insetPadding: const EdgeInsets.symmetric(horizontal: 16),

    child: ConstrainedBox(
    constraints: BoxConstraints(
    maxHeight: MediaQuery.of(context).size.height * 0.8,
    ),

      child: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),

              /// GRADIENT BACKGROUND
              gradient: LinearGradient(
                colors: [
                  Colors.white,
                  Colors.blue.shade50,
                  Colors.blue.shade100.withOpacity(.3),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                /// HEADER
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      vertical: 14, horizontal: 16),
                  decoration: const BoxDecoration(
                    color: Color(0xFF1565C0),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.lock_outline, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        "Create Password",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      /// USER DETAILS
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(.8),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.blue.withOpacity(.3),
                          ),
                        ),
                        child: Column(
                          children: [

                            _infoRow("Name", widget.name, Icons.person),

                            const SizedBox(height: 8),

                            _infoRow("Email", widget.email, Icons.email),

                            const SizedBox(height: 8),

                            _infoRow("Mobile", widget.mobile, Icons.phone),
                          ],
                        ),
                      ),

                      const SizedBox(height: 18),
                      const Divider(),
                      const SizedBox(height: 14),

                      /// PASSWORD
                      TextField(
                        controller: passwordController,
                        obscureText: !showPassword,
                        onChanged: (_) {
                          setState(() {
                            passwordMatch =
                                passwordController.text ==
                                    confirmPasswordController.text;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: "Create Password",
                          prefixIcon: const Icon(Icons.lock),

                          suffixIcon: IconButton(
                            icon: Icon(
                              showPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                showPassword = !showPassword;
                              });
                            },
                          ),

                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),

                      const SizedBox(height: 14),

                      /// CONFIRM PASSWORD
                      TextField(
                        controller: confirmPasswordController,
                        obscureText: !showConfirmPassword,
                        onChanged: (_) {
                          setState(() {
                            passwordMatch =
                                passwordController.text ==
                                    confirmPasswordController.text;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: "Confirm Password",
                          prefixIcon: const Icon(Icons.lock_outline),

                          suffixIcon: passwordMatch
                              ? const Icon(Icons.check_circle,
                              color: Colors.green)
                              : const Icon(Icons.error, color: Colors.red),

                          errorText:
                          passwordMatch ? null : "Passwords do not match",

                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// SUBMIT
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1565C0),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () async {

                            final password = passwordController.text.trim();
                            final confirmPassword =
                            confirmPasswordController.text.trim();

                            if (password.isEmpty || confirmPassword.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Please enter password")),
                              );
                              return;
                            }

                            if (password != confirmPassword) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Passwords do not match")),
                              );
                              return;
                            }

                            await widget.onSubmit(password);

                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Submit",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
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
    ));
  }

  Widget _infoRow(String label, String value, IconData icon) {
    return Row(
      children: [

        Container(
          padding:
          const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        const SizedBox(width: 10),

        Icon(icon, color: Colors.blue, size: 18),

        const SizedBox(width: 6),

        Expanded(child: Text(value)),
      ],
    );
  }
}