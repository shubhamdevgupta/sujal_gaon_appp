import 'package:flutter/material.dart';

class DisinfectionForm extends StatefulWidget {
  const DisinfectionForm({super.key});

  @override
  State<DisinfectionForm> createState() =>
      _DisinfectionFormState();
}

class _DisinfectionFormState
    extends State<DisinfectionForm> {

  String? disinfectionDone;
  String? disinfectionTiming;
  String? disinfectionType;
  String? chlorinationType;

  bool showNoDisinfectionAlert = false;

  final otherDisinfectionController =
  TextEditingController();

  final residualChlorineController =
  TextEditingController();

  final turbidityController =
  TextEditingController();

  String? chlorineStatusMessage;
  Color chlorineStatusColor = Colors.transparent;

  // ================= VALIDATION =================

  void _checkResidualChlorine() {

    double value =
        double.tryParse(
            residualChlorineController.text) ??
            0;

    if (value < 0.2) {
      chlorineStatusMessage =
      "Inadequate Chlorination (<0.2 ppm)";
      chlorineStatusColor = Colors.orange;
    }
    else if (value >= 0.2 && value <= 0.5) {
      chlorineStatusMessage =
      "Optimal Chlorination (0.2–0.5 ppm)";
      chlorineStatusColor = Colors.green;
    }
    else if (value > 1.0) {
      chlorineStatusMessage =
      "Over-chlorination (>1.0 ppm)";
      chlorineStatusColor = Colors.red;
    }
    else {
      chlorineStatusMessage = null;
    }

    setState(() {});
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
        backgroundColor: const Color(0xFF1976D2),
        title: const Text(
          "Disinfection / Chlorination",
          style: TextStyle(color: Colors.white),
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
                  icon: Icons.health_and_safety,
                  title: "Disinfection Details",
                  children: [

                    // 1. Whether Disinfection Done

                    _dropdown(
                      "Whether Disinfection being done?",
                      value: disinfectionDone,
                      items: const [
                        DropdownMenuItem(
                          value: "Yes",
                          child: Text("Yes"),
                        ),
                        DropdownMenuItem(
                          value: "No",
                          child: Text("No"),
                        ),
                      ],
                      onChanged: (v) {
                        setState(() {
                          disinfectionDone = v;
                          showNoDisinfectionAlert =
                          (v == "No");
                        });
                      },
                    ),

                    if (showNoDisinfectionAlert)
                      _redAlertBox(
                          "No Disinfection being done. Automatic notification sent to VWSC & GP."),

                    if (disinfectionDone == "Yes") ...[

                      // 2. Timing

                      _dropdown(
                        "Disinfection Timing",
                        value: disinfectionTiming,
                        items: const [
                          DropdownMenuItem(
                            value: "Before filling",
                            child:
                            Text("Before filling"),
                          ),
                          DropdownMenuItem(
                            value: "After filling",
                            child:
                            Text("After filling"),
                          ),
                        ],
                        onChanged: (v) =>
                            setState(() =>
                            disinfectionTiming = v),
                      ),

                      // 3. Type of Disinfection

                      _dropdown(
                        "Type of Disinfection",
                        value: disinfectionType,
                        items: const [
                          DropdownMenuItem(
                              value: "Chlorination",
                              child:
                              Text("Chlorination")),
                          DropdownMenuItem(
                              value:
                              "Silver-ionization",
                              child: Text(
                                  "Silver-ionization")),
                          DropdownMenuItem(
                              value: "UV",
                              child: Text("UV")),
                          DropdownMenuItem(
                              value: "Ozonation",
                              child:
                              Text("Ozonation")),
                          DropdownMenuItem(
                              value: "Others",
                              child:
                              Text("Others")),
                        ],
                        onChanged: (v) =>
                            setState(() =>
                            disinfectionType = v),
                      ),

                      if (disinfectionType == "Others")
                        _input(
                          "Specify Other",
                          controller:
                          otherDisinfectionController,
                        ),

                      // ================= CHLORINATION LOGIC =================

                      if (disinfectionType ==
                          "Chlorination") ...[

                        _dropdown(
                          "Type of Chlorination",
                          value: chlorinationType,
                          items: const [
                            DropdownMenuItem(
                              value:
                              "Bleaching Powder",
                              child: Text(
                                  "Bleaching Powder based"),
                            ),
                            DropdownMenuItem(
                              value:
                              "Gaseous",
                              child: Text(
                                  "Gaseous Chlorination"),
                            ),
                            DropdownMenuItem(
                              value:
                              "Chlorine solution",
                              child: Text(
                                  "Chlorine solution"),
                            ),
                            DropdownMenuItem(
                              value:
                              "Sodium hypochlorite",
                              child: Text(
                                  "Sodium hypochlorite"),
                            ),
                            DropdownMenuItem(
                              value: "Other",
                              child:
                              Text("Other"),
                            ),
                          ],
                          onChanged: (v) =>
                              setState(() =>
                              chlorinationType = v),
                        ),

                        _input(
                          "Residual Chlorine (ppm)",
                          controller:
                          residualChlorineController,
                          keyboard:
                          TextInputType.number,
                          onChanged: (_) =>
                              _checkResidualChlorine(),
                        ),

                        if (chlorineStatusMessage !=
                            null)
                          Container(
                            padding:
                            const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color:
                              chlorineStatusColor
                                  .withValues(alpha:0.1),
                              borderRadius:
                              BorderRadius.circular(
                                  12),
                              border: Border.all(
                                  color:
                                  chlorineStatusColor),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.info,
                                  color:
                                  chlorineStatusColor,
                                ),
                                const SizedBox(
                                    width: 8),
                                Expanded(
                                  child: Text(
                                    chlorineStatusMessage!,
                                    style: TextStyle(
                                      color:
                                      chlorineStatusColor,
                                      fontWeight:
                                      FontWeight
                                          .w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],

                      // 4. Turbidity

                      _input(
                        "Turbidity (NTU)",
                        controller:
                        turbidityController,
                        keyboard:
                        TextInputType.number,
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
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(14),
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
                fontWeight: FontWeight.w600,
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
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withValues(alpha:0.97),
            Colors.blue.shade50.withValues(alpha:0.9),
          ],
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.blueGrey.shade200,
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
                  color: const Color(0xFF1976D2)),
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
          Divider(
            thickness: 1.2,
            color: Colors.blueGrey.shade200,
          ),
          const SizedBox(height: 16),
          ...children.map(
                (e) => Padding(
              padding:
              const EdgeInsets.only(bottom: 16),
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