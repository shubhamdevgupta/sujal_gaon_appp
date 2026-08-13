import 'package:flutter/material.dart';

class PumpingRegular extends StatefulWidget {
  const PumpingRegular({super.key});

  @override
  State<PumpingRegular> createState() => _PumpingRegular();
}

class _PumpingRegular extends State<PumpingRegular> {

  // ================= VARIABLES =================

  String? pumpType;
  String? locationType;
  String? flowMeterInstalled;

  final dischargeController = TextEditingController();
  final headController = TextEditingController();

  final startTimeController = TextEditingController();
  final stopTimeController = TextEditingController();

  final pumpingHoursController = TextEditingController();

  final flowStartController = TextEditingController();
  final flowStopController = TextEditingController();

  final volumeController = TextEditingController();

  // ================= TIME PICKER =================

  Future<void> _pickTime(TextEditingController controller) async {
    TimeOfDay? picked =
    await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (picked != null) {
      controller.text = picked.format(context);
      _calculatePumpingHours();
    }
  }

  void _calculatePumpingHours() {
    if (startTimeController.text.isEmpty ||
        stopTimeController.text.isEmpty) return;

    final start = TimeOfDay(
        hour: int.parse(startTimeController.text.split(":")[0]),
        minute: int.parse(startTimeController.text.split(":")[1].split(" ")[0]));

    final stop = TimeOfDay(
        hour: int.parse(stopTimeController.text.split(":")[0]),
        minute: int.parse(stopTimeController.text.split(":")[1].split(" ")[0]));

    final startMinutes = start.hour * 60 + start.minute;
    final stopMinutes = stop.hour * 60 + stop.minute;

    if (stopMinutes > startMinutes) {
      double hours = (stopMinutes - startMinutes) / 60;
      pumpingHoursController.text = hours.toStringAsFixed(2);
      _calculateVolume();
    }
  }
  void _calculateVolume() {
    double volume = 0;

    if (flowMeterInstalled == "Yes") {

      double startReading =
          double.tryParse(flowStartController.text) ?? 0;

      double stopReading =
          double.tryParse(flowStopController.text) ?? 0;

      // Case 1: Start - Stop (as per your document)
      volume = startReading - stopReading;

      // Prevent negative result
      if (volume < 0) {
        volume = 0;
      }

    } else {

      double discharge =
          double.tryParse(dischargeController.text) ?? 0;

      double pumpingHours =
          double.tryParse(pumpingHoursController.text) ?? 0;

      // Case 2: Discharge × Pumping Hours
      volume = discharge * pumpingHours;
    }

    volumeController.text = volume.toStringAsFixed(2);
  }
  // ================= UI =================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F6FF),

      appBar: AppBar(
        backgroundColor: const Color(0xFF1976D2),
        title: const Text(
          "Ground Water Pump",
          style: TextStyle(color: Colors.white),
        ),
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

              // ================= TIME DETAILS =================

              _sectionCard(
                icon: Icons.access_time,
                title: "Pumping Time",
                children: [

                  InkWell(
                    onTap: () => _pickTime(startTimeController),
                    child: _input("Pump Start Time",
                        controller: startTimeController,
                        readOnly: true),
                  ),

                  InkWell(
                    onTap: () => _pickTime(stopTimeController),
                    child: _input("Pump Stop Time",
                        controller: stopTimeController,
                        readOnly: true),
                  ),

                  _input("Pumping Hours (Auto)",
                      controller: pumpingHoursController,
                      readOnly: true),
                ],
              ),

              const SizedBox(height: 20),

              // ================= FLOW METER =================

              _sectionCard(
                icon: Icons.speed,
                title: "Flow Meter Details",
                children: [

                  _dropdown(
                    "Flow Meter Installed?",
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
                        _calculateVolume();
                      });
                    },
                  ),

                  if (flowMeterInstalled == "Yes") ...[
                    _input("Flow Meter Reading Start",
                        controller: flowStartController,
                        keyboard: TextInputType.number,
                        onChanged: (_) => _calculateVolume()),

                    _input("Flow Meter Reading Stop",
                        controller: flowStopController,
                        keyboard: TextInputType.number,
                        onChanged: (_) => _calculateVolume()),
                  ],

                  _input("Volume Supplied (Auto)",
                      controller: volumeController,
                      readOnly: true),
                ],
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

// ================= REUSE YOUR EXISTING FUNCTIONS =================
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