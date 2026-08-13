import 'package:flutter/material.dart';

class SpringWaterForm extends StatefulWidget {
  const SpringWaterForm({super.key});

  @override
  State<SpringWaterForm> createState() => _SpringWaterFormState();
}

class _SpringWaterFormState extends State<SpringWaterForm> {

  // ================= VARIABLES =================

  String? waterSupplied;
  String? flowMeterInstalled;
  String? housekeepingDone;

  bool showNoSupplyMessage = false;
  bool showNoHouseKeepingMessage = false;

  final sourceTypeController =
  TextEditingController(text: "Spring");

  final numberOfSourcesController =
  TextEditingController();

  final inletStartController =
  TextEditingController();

  final inletStopController =
  TextEditingController();

  final volumeController =
  TextEditingController();

  // ================= CALCULATION =================

  void _calculateVolume() {
    double start =
        double.tryParse(inletStartController.text) ?? 0;

    double stop =
        double.tryParse(inletStopController.text) ?? 0;

    double volume = start - stop;

    volumeController.text =
        volume.toStringAsFixed(2);
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
          "Spring Water",
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
        ),        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [

              // ================= SUPPLY SECTION =================

              _sectionCard(
                icon: Icons.water,
                title: "Water Supply Status",
                children: [

                  _dropdown(
                    "Is Water being supplied?",
                    value: waterSupplied,
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
                        waterSupplied = v;
                        showNoSupplyMessage =
                        (v == "No");
                      });
                    },
                  ),

                  if (showNoSupplyMessage)
                    _redAlertBox(
                      "No-supply supplied. Automatic notification sent to VWSC & GP.",
                    ),

                  _input(
                    "Source Type",
                    controller: sourceTypeController,
                    readOnly: true,
                  ),

                  _input(
                    "Number of Sources",
                    controller:
                    numberOfSourcesController,
                    keyboard: TextInputType.number,
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // ================= FLOW METER SECTION =================

              _sectionCard(
                icon: Icons.speed,
                title: "Flow Meter Details",
                children: [

                  _dropdown(
                    "Is Flow meter installed?",
                    value: flowMeterInstalled,
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
                        flowMeterInstalled = v;
                      });
                    },
                  ),

                  if (flowMeterInstalled == "Yes") ...[

                    _input(
                      "Initial Flow Meter Reading (Day Start)",
                      controller: inletStartController,
                      keyboard: TextInputType.number,
                      onChanged: (_) =>
                          _calculateVolume(),
                    ),

                    _input(
                      "Final Flow Meter Reading (Next Day)",
                      controller: inletStopController,
                      keyboard: TextInputType.number,
                      onChanged: (_) =>
                          _calculateVolume(),
                    ),

                    _input(
                      "Volume Supplied in 24 Hours (Auto)",
                      controller: volumeController,
                      readOnly: true,
                    ),
                  ],
                ],
              ),

              const SizedBox(height: 20),

              // ================= HOUSEKEEPING SECTION =================

              _sectionCard(
                icon: Icons.cleaning_services,
                title: "House Keeping",
                children: [

                  _dropdown(
                    "Is housekeeping being done?",
                    value: housekeepingDone,
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
                        housekeepingDone = v;
                        showNoHouseKeepingMessage =
                        (v == "No");
                      });
                    },
                  ),

                  if (showNoHouseKeepingMessage)
                    _redAlertBox(
                      "No-housekeeping done. Automatic notification sent to VWSC & GP.",
                    ),
                ],
              ),
            ],
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
          const Icon(
            Icons.warning_amber_rounded,
            color: Colors.red,
          ),
          const SizedBox(width: 10),
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
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withValues(alpha:0.18),
            blurRadius: 22,
            offset: const Offset(0, 8),
          ),
        ],
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

  Widget _input(
      String hint, {
        TextEditingController? controller,
        TextInputType keyboard =
            TextInputType.text,
        bool readOnly = false,
        Function(String)? onChanged,
      }) {
    return TextField(
      controller: controller,
      keyboardType: keyboard,
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
        contentPadding:
        const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
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
      ),
    );
  }

  Widget _dropdown(
      String hint, {
        required List<
            DropdownMenuItem<String>>
        items,
        required Function(String?)
        onChanged,
        String? value,
      }) {
    return DropdownButtonFormField<String>(
      value: value,
      icon: const Icon(
        Icons.keyboard_arrow_down_rounded,
        color: Color(0xFF1976D2),
      ),
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: const Icon(
          Icons.arrow_drop_down_circle,
          color: Color(0xFF1976D2),
          size: 18,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
        const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
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
      ),
      items: items,
      onChanged: onChanged,
    );
  }
}