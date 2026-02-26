import 'package:flutter/material.dart';
import 'dart:math';

class WaterSampleForm extends StatefulWidget {
  const WaterSampleForm({super.key});

  @override
  State<WaterSampleForm> createState() => _WaterSampleFormState();
}

class _WaterSampleFormState extends State<WaterSampleForm> {

  // ================= DATA =================

  String? selectedCategory;
  String? selectedTestType;
  String? ticketTo;
  String? labSubmitted;

  final otherCategoryController = TextEditingController();
  final testingPointController = TextEditingController();
  final labIdController = TextEditingController();

  final turbidityController = TextEditingController();
  final frcController = TextEditingController();

  bool bacteriologicalPresence = false;

  String sampleId = "";

  @override
  void initState() {
    super.initState();
    _generateSampleId();
  }

  // ================= SAMPLE ID =================

  void _generateSampleId() {
    String lgdCode = "12345"; // Replace from Location Screen

    String x = "A";

    switch (selectedCategory) {
      case "Household Far End":
        x = "A";
        break;
      case "Household Near End":
        x = "B";
        break;
      case "School":
        x = "C";
        break;
      case "Anganwadi":
        x = "D";
        break;
      case "Others":
        x = "E";
        break;
    }

    String y = Random().nextInt(99999).toString().padLeft(5, '0');

    setState(() {
      sampleId = "$lgdCode$x$y";
    });
  }

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
        title: const Text("Water Sample Data",style: TextStyle(color: Colors.white),),
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
                icon: Icons.science,
                title: "Water Sample Information",
                children: [

                  // CATEGORY
                  _dropdown(
                    "Category",
                    value: selectedCategory,
                    items: const [
                      "Household Far End",
                      "Household Near End",
                      "School",
                      "Anganwadi",
                      "Others",
                    ],
                    onChanged: (v) {
                      setState(() {
                        selectedCategory = v;
                        _generateSampleId();
                      });
                    },
                  ),

                  // OTHERS
                  if (selectedCategory == "Others")
                    _input(
                      "Specify Other (Max 100 chars)",
                      controller: otherCategoryController,
                      maxLength: 100,
                    ),

                  // TESTING POINT
                  _input(
                    "Testing Point Details (Address / Institution)",
                    controller: testingPointController,
                    maxLength: 1000,
                    maxLines: 4,
                  ),

                  // SAMPLE ID
                  _readOnlyField("Sample ID", sampleId),

                  // TEST TYPE
                  _dropdown(
                    "Type of Testing",
                    value: selectedTestType,
                    items: const [
                      "Routine",
                      "Complaint-based",
                      "Follow-up",
                      "Post-remedial",
                    ],
                    onChanged: (v) {
                      setState(() {
                        selectedTestType = v;
                      });
                    },
                  ),

                  // PHOTO
                  _photoBox(),

                ],
              ),

              const SizedBox(height: 22),

              // ================= FTK =================
              _sectionCard(
                icon: Icons.fact_check,
                title: "FTK Test Results",
                children: [

                  _input(
                    "Turbidity (NTU)",
                    controller: turbidityController,
                    keyboard: TextInputType.number,
                  ),

                  _input(
                    "Free Residual Chlorine (ppm)",
                    controller: frcController,
                    keyboard: TextInputType.number,
                    onChanged: (_) => _validateFRC(),
                  ),

                  _bacteriologicalField(),

                  _alertBox(),

                ],
              ),

              const SizedBox(height: 22),

              // ================= TICKET =================
              _sectionCard(
                icon: Icons.support_agent,
                title: "Ticket Information",
                children: [

                  _dropdown(
                    "Ticket Raised To",
                    value: ticketTo,
                    items: const [
                      "VWSC",
                      "PHED Lab",
                    ],
                    onChanged: (v) {
                      setState(() {
                        ticketTo = v;
                        labSubmitted = null;
                      });
                    },
                  ),

                  if (ticketTo == "PHED Lab")
                    _dropdown(
                      "Sample Submitted to Lab?",
                      value: labSubmitted,
                      items: const ["Yes", "No"],
                      onChanged: (v) {
                        setState(() {
                          labSubmitted = v;
                        });
                      },
                    ),

                  if (ticketTo == "PHED Lab")
                    _input(
                      "Lab Sample ID",
                      controller: labIdController,
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

  // ================= VALIDATION =================

  String? alertMessage;

  void _validateFRC() {

    double frc = double.tryParse(frcController.text) ?? 0;

    if (bacteriologicalPresence) {
      alertMessage =
      "NOT SAFE: Submit sample in lab & raise ticket to VWSC.";
    } else if (frc <= 0) {
      alertMessage = "Bacteriological risk detected.";
    } else if (frc > 0 && frc <= 2) {
      alertMessage =
      "Inadequate chlorination. Repeat FTK test.";
    } else {
      alertMessage = null;
    }

    setState(() {});
  }

  // ================= WIDGETS =================

  Widget _alertBox() {
    if (alertMessage == null) return const SizedBox();

    return Container(
      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red),
      ),

      child: Row(
        children: [

          const Icon(Icons.warning, color: Colors.red),

          const SizedBox(width: 8),

          Expanded(
            child: Text(
              alertMessage!,
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bacteriologicalField() {
    return Row(
      children: [

        const Text(
          "Bacteriological Presence",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),

        const Spacer(),

        Switch(
          value: bacteriologicalPresence,
          activeColor: Colors.red,
          onChanged: (v) {
            setState(() {
              bacteriologicalPresence = v;
              _validateFRC();
            });
          },
        ),
      ],
    );
  }

  Widget _photoBox() {
    return InkWell(
      onTap: () {
        // TODO: Integrate Camera
      },

      child: Container(
        height: 120,

        decoration: BoxDecoration(
          color: const Color(0xFFF9FBFF),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade300),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [

            Icon(
              Icons.camera_alt,
              color: Color(0xFF1976D2),
              size: 30,
            ),

            SizedBox(height: 8),

            Text("Capture Sample Photo"),
          ],
        ),
      ),
    );
  }

  Widget _readOnlyField(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade300),
      ),

      child: Row(
        children: [

          Text(
            "$label: ",
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),

          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionCard({
    required IconData icon,
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.95),
            Colors.blue.shade50.withOpacity(0.9),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),

        borderRadius: BorderRadius.circular(22),

        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.18),
            blurRadius: 22,
            offset: const Offset(0, 8),
          ),
        ],

        border: Border.all(
          color: Colors.white.withOpacity(0.4),
        ),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          /// Header
          Container(
            padding: const EdgeInsets.all(12),

            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue.shade600,
                  Colors.blue.shade800,
                ],
              ),

              borderRadius: BorderRadius.circular(14),
            ),

            child: Row(
              children: [

                Container(
                  height: 36,
                  width: 36,

                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),

                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 20,
                  ),
                ),

                const SizedBox(width: 12),

                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

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
        Function(String)? onChanged,
      }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(14),

        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: TextField(
        controller: controller,
        keyboardType: keyboard,
        maxLines: maxLines,
        maxLength: maxLength,
        onChanged: onChanged,

        decoration: InputDecoration(
          hintText: hint,

          prefixIcon: const Icon(
            Icons.edit,
            color: Color(0xFF1976D2),
            size: 18,
          ),

          filled: true,
          fillColor: Colors.transparent,

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
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
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(14),

        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: DropdownButtonFormField<String>(
        value: value,

        decoration: InputDecoration(
          hintText: hint,

          prefixIcon: const Icon(
            Icons.arrow_drop_down_circle,
            color: Color(0xFF1976D2),
            size: 18,
          ),

          filled: true,
          fillColor: Colors.transparent,

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
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
      ),
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