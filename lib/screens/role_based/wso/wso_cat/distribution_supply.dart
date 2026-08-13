import 'package:flutter/material.dart';

class DistributionSupplyForm extends StatefulWidget {
  const DistributionSupplyForm({super.key});

  @override
  State<DistributionSupplyForm> createState() =>
      _DistributionSupplyFormState();
}

class _DistributionSupplyFormState
    extends State<DistributionSupplyForm> {

  String? zoningDone;
  String? selectedZone;
  String? flowMeterInstalled;

  final openTimeController = TextEditingController();
  final closeTimeController = TextEditingController();
  final durationController = TextEditingController();

  final flowStartController = TextEditingController();
  final flowStopController = TextEditingController();
  final totalVolumeController = TextEditingController();

  // ================= TIME PARSER =================

  DateTime _parseTime(String input) {
    final parts = input.split(":");
    return DateTime(
        2024, 1, 1,
        int.parse(parts[0]),
        int.parse(parts[1]));
  }

  void _calculateDuration() {
    if (openTimeController.text.isEmpty ||
        closeTimeController.text.isEmpty) return;

    final open = _parseTime(openTimeController.text);
    final close = _parseTime(closeTimeController.text);

    if (close.isAfter(open)) {
      final diff =
          close.difference(open).inMinutes / 60;

      durationController.text =
          diff.toStringAsFixed(2);
    } else {
      durationController.clear();
    }
  }

  void _calculateVolume() {
    double start =
        double.tryParse(flowStartController.text) ?? 0;
    double stop =
        double.tryParse(flowStopController.text) ?? 0;

    double volume = start - stop;

    totalVolumeController.text =
        volume.toStringAsFixed(2);
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

          if (onSelected != null) onSelected();
        }
      },
      decoration: _inputDecoration(label,
          icon: Icons.schedule),
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
        backgroundColor: const Color(0xFF1976D2),
        title: const Text(
          "Distribution & Supply",
          style: TextStyle(color: Colors.white),
        ),
      ),

      body: Container(  height: MediaQuery.of(context).size.height,
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

                // ================= ZONING SECTION =================

                _sectionCard(
                  icon: Icons.map,
                  title: "Zonal Distribution",
                  children: [

                    _dropdown(
                      "Is zoning done under command area?",
                      value: zoningDone,
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
                          zoningDone = v;
                          selectedZone = null;
                        });
                      },
                    ),

                    if (zoningDone == "Yes")
                      _dropdown(
                        "Select Zone",
                        value: selectedZone,
                        items: List.generate(
                          10,
                              (index) =>
                              DropdownMenuItem(
                                value:
                                "Zone ${index + 1}",
                                child: Text(
                                    "Zone ${index + 1}"),
                              ),
                        ),
                        onChanged: (v) =>
                            setState(() =>
                            selectedZone = v),
                      ),
                  ],
                ),

                const SizedBox(height: 20),

                // ================= VALVE SUPPLY =================

                _sectionCard(
                  icon: Icons.water,
                  title: "Valve Distribution",
                  children: [

                    _timeField(
                      "Valve Open Time",
                      openTimeController,
                    ),

                    _timeField(
                      "Valve Close Time",
                      closeTimeController,
                      onSelected:
                      _calculateDuration,
                    ),

                    _input(
                      "Supply Duration (hrs)",
                      controller:
                      durationController,
                      readOnly: true,
                    ),

                    _dropdown(
                      "Is Flow meter installed?",
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
                          setState(() =>
                          flowMeterInstalled = v),
                    ),

                    if (flowMeterInstalled == "Yes") ...[

                      _input(
                        "Flow Meter Reading Start",
                        controller:
                        flowStartController,
                        keyboard:
                        TextInputType.number,
                        onChanged: (_) =>
                            _calculateVolume(),
                      ),

                      _input(
                        "Flow Meter Reading Stop",
                        controller:
                        flowStopController,
                        keyboard:
                        TextInputType.number,
                        onChanged: (_) =>
                            _calculateVolume(),
                      ),
                    ],

                    _input(
                      "Total Volume Supplied (Auto)",
                      controller:
                      totalVolumeController,
                      readOnly: true,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ================= COMMON WIDGETS =================

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