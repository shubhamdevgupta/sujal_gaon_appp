import 'package:flutter/material.dart';

import '../../utils/app_constants.dart';



class NjmWsoRegistration extends StatefulWidget {
  const NjmWsoRegistration({super.key});

  @override
  State<NjmWsoRegistration> createState() =>
      _NjmWsoRegistrationState();
}

class _NjmWsoRegistrationState extends State<NjmWsoRegistration> {


  String? trainingStatus;   // Yes / No
  DateTime? trainingDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F6FF),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),

          child: Column(
            children: [

              // ================= HEADER =================
              _buildHeader(context),

              const SizedBox(height: 26),

              // ================= MEMBER DETAILS =================
              _sectionCard(
                icon: Icons.person,
                title: "Member Details",
                children: [

                  _dropdown("Role"),


                  _input("Mobile Number",
                      keyboard: TextInputType.phone),

                  _input("Full Name"),


                ],
              ),

              const SizedBox(height: 22),

              // ================= DESIGNATION =================
              _sectionCard(
                icon: Icons.badge,
                title: "Designation",

                children: [

                  _dropdown("Designation & affiliation, if any"),

                  _input("Functional Designation"),
                ],
              ),

              const SizedBox(height: 22),

              // ================= TENURE =================
              _sectionCard(
                icon: Icons.school,
                title: "FTK Training Status",
                children: [

                  _trainingStatusField(),

                ],
              ),

              const SizedBox(height: 22),

              // ================= CONTACT =================
         /*     _sectionCard(
                icon: Icons.call,
                title: "Contact Details",

                children: [



                  _input("Email",
                      keyboard: TextInputType.emailAddress),
                ],
              ),*/

              const SizedBox(height: 32),

              // ================= BUTTON =================
              _saveButton(),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // ====================================================
  // HEADER
  // ====================================================

  Widget _buildHeader( BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 26,
        horizontal: 20,
      ),

      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF1E88E5),
            Color(0xFF0D47A1),
          ],
        ),

        borderRadius: BorderRadius.circular(22),

        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.25),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),

      child: Row(
        children: [

          // 🔙 Back Button
          InkWell(
            onTap: () {
              Navigator.pushReplacementNamed(
                context,
                AppConstants.navigateToVWSCLandingScreen,
              );
            },

            borderRadius:  BorderRadius.circular(20),

            child: const Padding(
              padding: EdgeInsets.all(4),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),

          const SizedBox(width: 6),

          // App Icon
          const Icon(
            Icons.water_drop,
            color: Colors.white,
            size: 24,
          ),

          const SizedBox(width: 10),

          // Title
          const Text(
            "Register NJM/WSO",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),

    );
  }

  // ====================================================
  // SECTION CARD
  // ====================================================

  Widget _sectionCard({
    required IconData icon,
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.97),

        borderRadius: BorderRadius.circular(22),

        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.1),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          // Section Title
          Row(
            children: [

              Container(
                padding: const EdgeInsets.all(8),

                decoration: BoxDecoration(
                  color: const Color(0xFF1976D2).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),

                child: Icon(
                  icon,
                  color: const Color(0xFF1976D2),
                  size: 20,
                ),
              ),

              const SizedBox(width: 10),

              Text(
                title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1976D2),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          ...children.map(
                (e) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: e,
            ),
          ),
        ],
      ),
    );
  }

  // ====================================================
  // INPUT
  // ====================================================

  Widget _input(
      String hint, {
        TextInputType keyboard = TextInputType.text,
      }) {
    return TextField(
      keyboardType: keyboard,

      decoration: InputDecoration(
        hintText: hint,

        filled: true,
        fillColor: const Color(0xFFF9FBFF),

        prefixIcon: const Icon(
          Icons.edit,
          size: 18,
          color: Color(0xFF1976D2),
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // ====================================================
  // DROPDOWN
  // ====================================================

  Widget _dropdown(String hint) {
    return DropdownButtonFormField<String>(

      decoration: InputDecoration(
        hintText: hint,

        filled: true,
        fillColor: const Color(0xFFF9FBFF),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),

      items: const [
        DropdownMenuItem(value: "1", child: Text("Option 1")),
        DropdownMenuItem(value: "2", child: Text("Option 2")),
      ],

      onChanged: (v) {},
    );
  }


  Widget _trainingStatusField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Text(
          "Training Done?",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 10),

        // Radio Buttons
        Row(
          children: [

            _radioButton("Yes"),
            const SizedBox(width: 20),
            _radioButton("No"),

          ],
        ),

        const SizedBox(height: 12),

        // Show Date if Yes
        if (trainingStatus == "Yes")
          _datePickerBox(),
      ],
    );
  }


  Widget _radioButton(String value) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        setState(() {
          trainingStatus = value;

          // Clear date if No selected
          if (value == "No") {
            trainingDate = null;
          }
        });
      },

      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 8,
        ),

        decoration: BoxDecoration(
          color: trainingStatus == value
              ? const Color(0xFF1976D2).withOpacity(0.12)
              : Colors.transparent,

          borderRadius: BorderRadius.circular(8),

          border: Border.all(
            color: trainingStatus == value
                ? const Color(0xFF1976D2)
                : Colors.grey.shade400,
          ),
        ),

        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [

            Icon(
              trainingStatus == value
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              size: 18,
              color: const Color(0xFF1976D2),
            ),

            const SizedBox(width: 6),

            Text(value),
          ],
        ),
      ),
    );
  }

  Widget _datePickerBox() {
    return InkWell(
      borderRadius: BorderRadius.circular(14),

      onTap: () async {

        DateTime? picked = await showDatePicker(
          context: context,
          initialDate: trainingDate ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );

        if (picked != null) {
          setState(() {
            trainingDate = picked;
          });
        }
      },

      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.circular(14),

          border: Border.all(
            color: Colors.grey.shade300,
          ),

          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),

        child: Row(
          children: [

            const Icon(
              Icons.date_range,
              color: Color(0xFF1976D2),
              size: 20,
            ),

            const SizedBox(width: 10),

            Text(
              trainingDate == null
                  ? "Select Training Date"
                  : _formatDate(trainingDate!),

              style: TextStyle(
                fontSize: 14,

                color: trainingDate == null
                    ? Colors.grey
                    : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year}";
  }


  // ====================================================
  // BUTTON
  // ====================================================




  Widget _saveButton() {
    return Container(
      width: double.infinity,
      height: 56,

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
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: const Center(
        child: Text(
          "Save Member",
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}
