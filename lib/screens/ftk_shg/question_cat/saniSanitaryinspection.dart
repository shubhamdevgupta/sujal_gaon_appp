import 'package:flutter/material.dart';

class SanitaryInspectionForm extends StatefulWidget {
  const SanitaryInspectionForm({super.key});

  @override
  State<SanitaryInspectionForm> createState() =>
      _SanitaryInspectionFormState();
}

class _SanitaryInspectionFormState
    extends State<SanitaryInspectionForm> {

  // ================= DATA =================

  String? inspectionLocation;
  String? assessment;
  String? checklistFilled;
  String? raiseTicket;

  final otherLocationController =
  TextEditingController();

  final mediumRiskController =
  TextEditingController();

  final highRiskController =
  TextEditingController();

  final totalRiskController =
  TextEditingController();

  final descriptionController =
  TextEditingController();

  // ================= UI =================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F6FF),

      appBar: AppBar(
        backgroundColor: const Color(0xFF1976D2),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Sanitary Inspection",style: TextStyle(color: Colors.white),),
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
          padding: const EdgeInsets.all(16),

          child: Column(
            children: [

              _sectionCard(
                icon: Icons.health_and_safety,
                title: "Inspection Details",
                children: [

                  /// LOCATION
                  _dropdown(
                    "Location of Inspection",
                    value: inspectionLocation,
                    items: const [
                      "Source",
                      "ESR",
                      "GLSR",
                      "School",
                      "Anganwadi",
                      "Standpost",
                      "FHTC",
                      "Others",
                    ],
                    onChanged: (v) {
                      setState(() {
                        inspectionLocation = v;
                      });
                    },
                  ),

                  /// OTHERS
                  if (inspectionLocation == "Others")
                    _input(
                      "Specify Other (Max 100 chars)",
                      controller: otherLocationController,
                      maxLength: 100,
                    ),

                  /// CHECKLIST
                  _radioGroup(
                    "Checklist Filled?",
                    value: checklistFilled,
                    onChanged: (v) {
                      setState(() {
                        checklistFilled = v;
                      });
                    },
                  ),

                  /// UPLOAD CHECKLIST
                  if (checklistFilled == "Yes")
                    _uploadBox("Upload Checklist (Photo / PDF)"),

                  /// ASSESSMENT
                  _dropdown(
                    "Assessment",
                    value: assessment,
                    items: const [
                      "Low Risk (Green)",
                      "Medium Risk (Yellow)",
                      "High Risk (Red)",
                    ],
                    onChanged: (v) {
                      setState(() {
                        assessment = v;
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 22),

              // ================= RISK =================
              _sectionCard(
                icon: Icons.warning,
                title: "Risk Points",
                children: [

                  _input(
                    "Medium Risk Points",
                    controller: mediumRiskController,
                    keyboard: TextInputType.number,
                    onChanged: (_) => _calculateTotal(),
                  ),

                  _input(
                    "High Risk Points",
                    controller: highRiskController,
                    keyboard: TextInputType.number,
                    onChanged: (_) => _calculateTotal(),
                  ),

                  _input(
                    "Total Risk Points",
                    controller: totalRiskController,
                    keyboard: TextInputType.number,
                    readOnly: true,
                  ),

                  _uploadBox("Upload Risk Point Photos"),
                ],
              ),

              const SizedBox(height: 22),

              // ================= DESCRIPTION =================
              _sectionCard(
                icon: Icons.description,
                title: "Observations",
                children: [

                  _input(
                    "Brief Description of Risk",
                    controller: descriptionController,
                    maxLines: 4,
                    maxLength: 500,
                  ),

                  _radioGroup(
                    "Raise Ticket to VWSC?",
                    value: raiseTicket,
                    onChanged: (v) {
                      setState(() {
                        raiseTicket = v;
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 30),

              _saveButton(),
            ],
          ),
        ),
      ),
    );
  }

  // ================= LOGIC =================

  void _calculateTotal() {
    int m = int.tryParse(mediumRiskController.text) ?? 0;
    int h = int.tryParse(highRiskController.text) ?? 0;

    totalRiskController.text = (m + h).toString();
  }

  // ================= WIDGETS =================

  Widget _uploadBox(String title) {
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: () {
        // TODO: Open Camera / File picker
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.97),
          borderRadius: BorderRadius.circular(22),

          // Elegant textured border
          border: Border.all(
            color: const Color(0xFFB0BEC5), // blue-grey tone
            width: 1.4,
          ),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [

            // 🔵 CAMERA ICON CONTAINER
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: const Color(0xFF1976D2).withOpacity(0.08),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: const Color(0xFF1976D2),
                  width: 1.3,
                ),
              ),
              child: const Icon(
                Icons.camera_alt_rounded,
                size: 28,
                color: Color(0xFF1976D2),
              ),
            ),

            const SizedBox(width: 18),

            // 🔹 TEXT SECTION
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.2,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    "Tap to capture photo or upload file",
                    style: TextStyle(
                      fontSize: 12.5,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),

            // ➤ Action indicator
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _radioGroup(
      String title, {
        required String? value,
        required Function(String) onChanged,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 10),

        Row(
          children: [

            _radioButton("Yes", value, onChanged),

            const SizedBox(width: 20),

            _radioButton("No", value, onChanged),
          ],
        ),
      ],
    );
  }

  Widget _radioButton(
      String label,
      String? groupValue,
      Function(String) onChanged,
      ) {
    bool selected = label == groupValue;

    return InkWell(
      onTap: () => onChanged(label),

      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 8,
        ),

        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFF1976D2).withOpacity(0.12)
              : Colors.transparent,

          borderRadius: BorderRadius.circular(8),

          border: Border.all(
            color: selected
                ? const Color(0xFF1976D2)
                : Colors.grey.shade400,
          ),
        ),

        child: Row(
          children: [

            Icon(
              selected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              size: 18,
              color: const Color(0xFF1976D2),
            ),

            const SizedBox(width: 6),

            Text(label),
          ],
        ),
      ),
    );
  }

  Widget _sectionCard({
    required IconData icon,
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.97),
            Colors.blue.shade50.withOpacity(0.9),
          ],
        ),
        borderRadius: BorderRadius.circular(22),

        // 🔥 Added subtle border texture
        border: Border.all(
          color: Colors.blueGrey.shade200,
          width: 1.2,
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.18),
            blurRadius: 22,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [
              Icon(icon, color: const Color(0xFF1976D2)),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // 🔵 Partition Line
          Divider(
            thickness: 1.2,
            color: Colors.blueGrey.shade200,
          ),

          const SizedBox(height: 16),

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

  Widget _input(
      String hint, {
        TextEditingController? controller,
        TextInputType keyboard = TextInputType.text,
        int maxLines = 1,
        int? maxLength,
        bool readOnly = false,
        Function(String)? onChanged,
      }) {
    return TextField(
      controller: controller,
      keyboardType: keyboard,
      maxLines: maxLines,
      maxLength: maxLength,
      readOnly: readOnly,
      onChanged: onChanged,

      decoration: InputDecoration(
        hintText: hint,

        prefixIcon: const Icon(
          Icons.edit,
          color: Color(0xFF1976D2),
          size: 18,
        ),

        filled: true,
        fillColor: Colors.white,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),

        // 🔥 Darker textured border
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: Colors.blueGrey.shade400,
            width: 1.3,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: Color(0xFF1976D2),
            width: 1.8,
          ),
        ),
      ),
    );
  }

  Widget _dropdown(
      String hint, {
        required String? value,
        required List<String> items,
        required Function(String?) onChanged,
      }) {
    return DropdownButtonFormField<String>(
      value: value,

      decoration: InputDecoration(
        hintText: hint,

        prefixIcon: const Icon(
          Icons.arrow_drop_down_circle,
          color: Color(0xFF1976D2),
          size: 18,
        ),

        filled: true,
        fillColor: Colors.white,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: Colors.blueGrey.shade400,
            width: 1.3,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: Color(0xFF1976D2),
            width: 1.8,
          ),
        ),
      ),

      items: items
          .map(
            (e) => DropdownMenuItem(
          value: e,
          child: Text(e),
        ),
      )
          .toList(),

      onChanged: onChanged,
    );
  }
  Widget _saveButton() {
    return Container(
      width: double.infinity,
      height: 54,

      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF1E88E5),
            Color(0xFF0D47A1),
          ],
        ),

        borderRadius: BorderRadius.circular(28),

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
          "Save & Continue",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}