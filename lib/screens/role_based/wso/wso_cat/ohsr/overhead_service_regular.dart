import 'package:flutter/material.dart';

class OhsrRegular extends StatefulWidget {
  const OhsrRegular({super.key});

  @override
  State<OhsrRegular> createState() => _OHSRFormState();
}

class _OHSRFormState extends State<OhsrRegular> {

  // ================= VARIABLES =================

  String? waterReceived;
  String? flowMeterInstalled;
  String? fillType;

  final capacityController = TextEditingController(text: "100"); // auto
  final numberOfReservoirsController = TextEditingController();

  final inletStartController = TextEditingController();
  final inletStopController = TextEditingController();

  final fillStartController = TextEditingController();
  final fillEndController = TextEditingController();

  final observedLevelController = TextEditingController();
  final numberOfFillsController = TextEditingController();

  final volumeFilledController = TextEditingController();

  final outletOpenController = TextEditingController();
  final outletCloseController = TextEditingController();
  final supplyDurationController = TextEditingController();

  final outletStartController = TextEditingController();
  final outletStopController = TextEditingController();
  final totalSuppliedController = TextEditingController();


  bool showNoSupplyMessage = false;

  // ================= CALCULATIONS =================

// ONLY showing core logic improvements section-by-section
// Integrate inside your existing UI structure

// ================= ADD THESE CONTROLLERS =================

  final fillStartTimeController = TextEditingController();
  final fillEndTimeController = TextEditingController();

  int fillCount = 0;

// ================= TIME PARSER =================

  DateTime _parseTime(String input) {
    final parts = input.split(":");
    return DateTime(
        2024,
        1,
        1,
        int.parse(parts[0]),
        int.parse(parts[1]));
  }

// ================= CALCULATE NUMBER OF FILLS =================

  void _calculateFills() {
    if (fillStartTimeController.text.isEmpty ||
        fillEndTimeController.text.isEmpty) return;

    final start = _parseTime(fillStartTimeController.text);
    final end = _parseTime(fillEndTimeController.text);

    if (end.isAfter(start)) {
      fillCount = 1; // per entry
      numberOfFillsController.text = fillCount.toString();
    } else {
      numberOfFillsController.text = "";
    }

    _calculateVolumeFilled();
  }

// ================= VOLUME FILLED =================

  void _calculateVolumeFilled() {
    double capacity =
        double.tryParse(capacityController.text) ?? 0;

    double fills =
        double.tryParse(numberOfFillsController.text) ?? 0;

    double volume = 0;

    // Case 1 – Flow meter installed
    if (flowMeterInstalled == "Yes") {

      double start =
          double.tryParse(inletStartController.text) ?? 0;

      double stop =
          double.tryParse(inletStopController.text) ?? 0;

      volume = start - stop;

      if (volume < 0) volume = 0;

    } else {

      // Case 2 – Manual logic

      if (fillType == "Full") {
        volume = fills * capacity;
      }

      if (fillType == "Partial") {

        double level =
            double.tryParse(observedLevelController.text) ?? 0;

        volume = capacity * fills * (level / 100);
      }
    }

    volumeFilledController.text =
        volume.toStringAsFixed(2);
  }

// ================= SUPPLY DURATION =================

  void _calculateSupplyDuration() {
    if (outletOpenController.text.isEmpty ||
        outletCloseController.text.isEmpty) return;

    final open = _parseTime(outletOpenController.text);
    final close = _parseTime(outletCloseController.text);

    if (close.isAfter(open)) {
      final diff =
          close.difference(open).inMinutes / 60;

      supplyDurationController.text =
          diff.toStringAsFixed(2);
    } else {
      supplyDurationController.text = "";
    }
  }

// ================= OUTLET VOLUME =================

  void _calculateOutletVolume() {
    double start =
        double.tryParse(outletStartController.text) ?? 0;

    double stop =
        double.tryParse(outletStopController.text) ?? 0;

    double volume = start - stop;

    if (volume < 0) volume = 0;

    totalSuppliedController.text =
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
        title: const Text("OHSR Regular",
            style: TextStyle(color: Colors.white)),
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

              // ================= WATER RECEIVED =================

              _sectionCard(
                icon: Icons.water,
                title: "Water Receipt",
                children: [

                  _dropdown(
                    "Water received from Source?",
                    value: waterReceived,
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
                        waterReceived = v;
                        showNoSupplyMessage = (v == "No");
                      });
                    },
                  ),

                  if (showNoSupplyMessage)
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.red),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.warning, color: Colors.red),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              "No-supply received. Automatic notification sent to VWSC & GP.",
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 20),

              _sectionCard(
                icon: Icons.storage,
                title: "Reservoir Information",
                children: [

                  _input(
                    "Reservoir Type",
                    controller: TextEditingController(text: "OHSR"),
                    readOnly: true,
                  ),

                  _input(
                    "Number of Reservoirs",
                    controller: numberOfReservoirsController,
                    keyboard: TextInputType.number,
                  ),

                  _input(
                    "Capacity (KL)",
                    controller: capacityController,
                    readOnly: true,
                  ),
                ],
              ),
              // ================= INLET FLOW =================
              const SizedBox(height: 20),
              _sectionCard(
                icon: Icons.speed,
                title: "Inlet Flow Details",
                children: [

                  _dropdown(
                    "Flow Meter Installed at Inlet?",
                    value: flowMeterInstalled,
                    items: const [
                      DropdownMenuItem(
                          value: "Yes",
                          child: Text("Yes")),
                      DropdownMenuItem(
                          value: "No",
                          child: Text("No")),
                    ],
                    onChanged: (v) =>
                        setState(() => flowMeterInstalled = v),
                  ),

                  if (flowMeterInstalled == "Yes") ...[
                    _input("Inlet Reading Start",
                        controller: inletStartController,
                        keyboard: TextInputType.number,
                        onChanged: (_) =>
                            _calculateVolumeFilled()),

                    _input("Inlet Reading Stop",
                        controller: inletStopController,
                        keyboard: TextInputType.number,
                        onChanged: (_) =>
                            _calculateVolumeFilled()),
                  ],
                ],
              ),

              const SizedBox(height: 20),

              // ================= FILL DETAILS =================

              _sectionCard(
                icon: Icons.water_drop,
                title: "Filling Details",
                children: [

                  _dropdown(
                    "Fill Type",
                    value: fillType,
                    items: const [
                      DropdownMenuItem(
                          value: "Full",
                          child: Text("Full")),
                      DropdownMenuItem(
                          value: "Partial",
                          child: Text("Partial")),
                    ],
                    onChanged: (v) =>
                        setState(() => fillType = v),
                  ),

                  if (fillType == "Partial")
                    _input("Observed Level (%)",
                        controller:
                        observedLevelController,
                        keyboard: TextInputType.number,
                        onChanged: (_) =>
                            _calculateVolumeFilled()),

                  _input("Number of Fills",
                      controller:
                      numberOfFillsController,
                      keyboard: TextInputType.number,
                      onChanged: (_) =>
                          _calculateVolumeFilled()),

                  _input("Volume Filled (Auto)",
                      controller: volumeFilledController,
                      readOnly: true),
                ],
              ),

              const SizedBox(height: 20),

              // ================= OUTLET SUPPLY =================

              _sectionCard(
                icon: Icons.outbond,
                title: "Outlet Supply",
                children: [

                  _timePickerField(
                    "Outlet Valve Open Time",
                    controller: outletOpenController,
                  ),

                  _timePickerField(
                    "Outlet Valve Close Time",
                    controller: outletCloseController,
                    onTimeSelected: _calculateSupplyDuration,
                  ),

                  _input(
                    "Supply Duration (hrs)",
                    controller: supplyDurationController,
                    readOnly: true,
                  ),

                  _input(
                    "Outlet Flow Start Reading",
                    controller: outletStartController,
                    keyboard: TextInputType.number,
                    onChanged: (_) => _calculateOutletVolume(),
                  ),

                  _input(
                    "Outlet Flow Stop Reading",
                    controller: outletStopController,
                    keyboard: TextInputType.number,
                    onChanged: (_) => _calculateOutletVolume(),
                  ),

                  _input(
                    "Total Volume Supplied",
                    controller: totalSuppliedController,
                    readOnly: true,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _timePickerField(
      String label, {
        required TextEditingController controller,
        Function()? onTimeSelected,
      }) {
    return TextField(
      controller: controller,
      readOnly: true, // 👈 Prevent manual typing
      onTap: () async {
        TimeOfDay? picked = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );

        if (picked != null) {
          final formatted =
              "${picked.hour.toString().padLeft(2, '0')}:"
              "${picked.minute.toString().padLeft(2, '0')}";

          controller.text = formatted;

          if (onTimeSelected != null) {
            onTimeSelected();
          }
        }
      },
      decoration: InputDecoration(
        hintText: label,

        prefixIcon: const Icon(
          Icons.schedule,
          color: Color(0xFF1976D2),
          size: 18,
        ),

        suffixIcon: const Icon(
          Icons.access_time_rounded,
          color: Color(0xFF1976D2),
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

        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(14)),
          borderSide: BorderSide(
            color: Color(0xFF1976D2),
            width: 1.8,
          ),
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
            Colors.white.withValues(alpha:0.97),
            Colors.blue.shade50.withValues(alpha:0.9),
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
            color: Colors.blue.withValues(alpha:0.18),
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
      String label, {
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


  Widget _dropdown(
      String label, {
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
}