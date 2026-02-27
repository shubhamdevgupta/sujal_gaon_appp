import 'package:flutter/material.dart';

class NonSupplyForm extends StatefulWidget {
  const NonSupplyForm({super.key});

  @override
  State<NonSupplyForm> createState() =>
      _NonSupplyFormState();
}

class _NonSupplyFormState
    extends State<NonSupplyForm> {

  String? waterSupplied;
  String? disruptionReason;

  final startTimeController =
  TextEditingController();
  final endTimeController =
  TextEditingController();
  final actionController =
  TextEditingController();

  bool showReasonMandatory = false;

  // ================= TIME PARSER =================

  DateTime _parseTime(String input) {
    final parts = input.split(":");
    return DateTime(
      2024,
      1,
      1,
      int.parse(parts[0]),
      int.parse(parts[1]),
    );
  }

  void _validateEndTime() {
    if (startTimeController.text.isEmpty ||
        endTimeController.text.isEmpty) return;

    final start =
    _parseTime(startTimeController.text);
    final end =
    _parseTime(endTimeController.text);

    if (!end.isAfter(start)) {
      _showSnack(
          "End Time must be after Start Time");
      endTimeController.clear();
    }
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  // ================= TIME PICKER =================

  Widget _timeField(
      String label,
      TextEditingController controller,
      {Function()? onSelected}) {

    return TextField(
      controller: controller,
      readOnly: true,
      onTap: () async {
        TimeOfDay? picked =
        await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );

        if (picked != null) {
          controller.text =
          "${picked.hour.toString().padLeft(2, '0')}:"
              "${picked.minute.toString().padLeft(2, '0')}";

          if (onSelected != null)
            onSelected();
        }
      },
      decoration: _inputDecoration(
        label,
        icon: Icons.schedule,
      ),
    );
  }

  // ================= UI =================

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFF2F6FF),

      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor:
        const Color(0xFF1976D2),
        title: const Text(
          "Non-Supply & Disruptions",
          style:
          TextStyle(color: Colors.white),
        ),
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
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [

                _sectionCard(
                  icon: Icons.report_problem,
                  title: "Disruption Details",
                  children: [

                    // 1. Was Water Supplied

                    _dropdown(
                      "Was Water Supplied Today?",
                      value: waterSupplied,
                      items: const [
                        DropdownMenuItem(
                            value: "Yes",
                            child: Text("Yes")),
                        DropdownMenuItem(
                            value: "No",
                            child: Text("No")),
                      ],
                      onChanged: (v) {
                        setState(() {
                          waterSupplied = v;
                          showReasonMandatory =
                          (v == "No");
                        });
                      },
                    ),

                    if (showReasonMandatory)
                      _redAlertBox(
                          "Disruption reason is mandatory when water is not supplied."),

                    // 2. Disruption Reason

                    if (waterSupplied == "No")
                      _dropdown(
                        "Disruption Reason",
                        value: disruptionReason,
                        items: const [
                          DropdownMenuItem(
                              value: "Power",
                              child:
                              Text("Power")),
                          DropdownMenuItem(
                              value: "Pump",
                              child:
                              Text("Pump")),
                          DropdownMenuItem(
                              value: "No inflow",
                              child:
                              Text("No inflow")),
                          DropdownMenuItem(
                              value: "Source dry",
                              child:
                              Text("Source dry")),
                          DropdownMenuItem(
                              value:
                              "Tank damage",
                              child:
                              Text("Tank damage")),
                          DropdownMenuItem(
                              value: "Other",
                              child:
                              Text("Other")),
                        ],
                        onChanged: (v) =>
                            setState(() =>
                            disruptionReason = v),
                      ),

                    if (waterSupplied == "No") ...[

                      _timeField(
                        "Disruption Start Time",
                        startTimeController,
                      ),

                      _timeField(
                        "Disruption End Time",
                        endTimeController,
                        onSelected:
                        _validateEndTime,
                      ),

                      _input(
                        "Temporary Action Taken",
                        controller:
                        actionController,
                        keyboard:
                        TextInputType.multiline,
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ================= COMMON UI =================

  Widget _redAlertBox(String message) {
    return Container(
      padding:
      const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius:
        BorderRadius.circular(14),
        border: Border.all(
          color: Colors.red.shade400,
          width: 1.3,
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.warning,
              color: Colors.red),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.red,
                fontWeight:
                FontWeight.w600,
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
      padding:
      const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white
                .withOpacity(0.97),
            Colors.blue.shade50
                .withOpacity(0.9),
          ],
        ),
        borderRadius:
        BorderRadius.circular(22),
        border: Border.all(
          color:
          Colors.blueGrey.shade200,
          width: 1.2,
        ),
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon,
                  color: const Color(
                      0xFF1976D2)),
              const SizedBox(
                  width: 10),
              Text(
                title,
                style:
                const TextStyle(
                  fontSize: 17,
                  fontWeight:
                  FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Divider(
            thickness: 1.2,
            color: Colors
                .blueGrey.shade200,
          ),
          const SizedBox(height: 16),
          ...children.map(
                (e) => Padding(
              padding:
              const EdgeInsets.only(
                  bottom: 16),
              child: e,
            ),
          ),
        ],
      ),
    );
  }

  Widget _input(String label, {
    TextEditingController? controller,
    TextInputType keyboard = TextInputType.text,
    bool readOnly = false,
    Function(String)? onChanged,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboard,
      readOnly: readOnly,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.always,

        labelStyle: const TextStyle(
          color: Color(0xFF1976D2),
          fontWeight: FontWeight.w600,
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
    );
  }


  Widget _dropdown(String label, {
    required List<DropdownMenuItem<String>> items,
    required Function(String?) onChanged,
    String? value,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      icon: const Icon(
        Icons.keyboard_arrow_down_rounded,
        color: Color(0xFF1976D2),
      ),
      decoration: InputDecoration(
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.always,

        labelStyle: const TextStyle(
          color: Color(0xFF1976D2),
          fontWeight: FontWeight.w600,
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
      items: items,
      onChanged: onChanged,
    );
  }

  InputDecoration _inputDecoration(
      String hint,
      {required IconData icon}) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon,
          color: const Color(0xFF1976D2)),
      filled: true,
      fillColor: Colors.white,
      contentPadding:
      const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14),
      enabledBorder: OutlineInputBorder(
        borderRadius:
        BorderRadius.circular(14),
        borderSide: BorderSide(
          color: Colors.blueGrey.shade400,
          width: 1.3,
        ),
      ),
      focusedBorder:
      const OutlineInputBorder(
        borderRadius:
        BorderRadius.all(
            Radius.circular(14)),
        borderSide: BorderSide(
          color: Color(0xFF1976D2),
          width: 1.8,
        ),
      ),
    );
  }
}