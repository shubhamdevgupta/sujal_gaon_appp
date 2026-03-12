import 'package:flutter/material.dart';

import 'enum/app_dialog.dart';


class AppDialog {

  static void show(
      BuildContext context, {

        AppDialogType type = AppDialogType.info,

        String? title,
        String? message,

        String buttonText = "OK",

        VoidCallback? onPressed,

        bool barrierDismissible = false,

      }) {

    String assetPath;
    Color titleColor;

    switch (type) {
      case AppDialogType.success:
        assetPath = 'assets/icons/check.png';
        titleColor = Colors.green;
        title ??= "Success!";
        break;

      case AppDialogType.error:
        assetPath = 'assets/icons/error.png';
        titleColor = Colors.red;
        title ??= "Failed!";
        break;

      case AppDialogType.warning:
        assetPath = 'assets/icons/warning.png';
        titleColor = Colors.orange;
        title ??= "Warning!";
        break;

      case AppDialogType.info:
      default:
        assetPath = 'assets/icons/info.png';
        titleColor = Colors.blue;
        title ??= "Info";
    }

    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) {

        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),

          titlePadding: const EdgeInsets.only(top: 20),

          contentPadding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 10,
          ),

          actionsPadding: const EdgeInsets.only(bottom: 10, right: 10),

          title: Column(
            children: [

              Image.asset(
                assetPath,
                height: 60,
                width: 80,
              ),

              const SizedBox(height: 10),

              Text(
                title!,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: titleColor,
                ),
              ),
            ],
          ),

          content: Text(
            message ?? "",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),

          actions: [

            Center(
              child: ElevatedButton(

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 12,
                  ),
                ),

                onPressed: () {

                  Navigator.pop(context);

                  if (onPressed != null) {
                    onPressed();
                  }

                },

                child: Text(
                  buttonText,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

          ],
        );
      },
    );
  }
}