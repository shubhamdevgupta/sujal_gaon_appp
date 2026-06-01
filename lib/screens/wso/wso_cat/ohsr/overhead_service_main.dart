import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/wso/ohsr_provider.dart';

class OhsrMain extends StatefulWidget {
  const OhsrMain({super.key});

  @override
  State<OhsrMain> createState() => _OHSRFormState();
}

class _OHSRFormState extends State<OhsrMain> {

  @override
  Widget build(BuildContext context) {
    final ohsrProvider = context.watch<OhsrProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFF2F6FF),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: const Color(0xFF1976D2),
        title: const Text("OHSR Main", style: TextStyle(color: Colors.white)),
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
                icon: Icons.water,
                title: "Water Receipt",
                children: [
                  _dropdown(
                    "Water received from Source?",
                    value: ohsrProvider.isWaterRecived,
                    items: ohsrProvider.yesNoMap.keys.toList(),
                    onChanged: (value) {
                      ohsrProvider.setWaterRecipt(value);
                    },
                  ),

                  if (ohsrProvider.isWaterRecivedId==1)
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
                    controller: ohsrProvider.numberOfReservoirsController,
                    keyboard: TextInputType.number,
                  ),

                  _input(
                    "Capacity (KL)",
                    controller: ohsrProvider.capacityController,
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
                    value: ohsrProvider.flowMeter,
                    items: ohsrProvider.yesNoMap.keys.toList(),
                    onChanged: (value) {
                      ohsrProvider.setFlowMeter(value);
                    },
                  ),

                ],
              ),
            ],
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
            Colors.white.withOpacity(0.97),
            Colors.blue.shade50.withOpacity(0.9),
          ],
        ),
        borderRadius: BorderRadius.circular(22),

        // 🔥 Added subtle border texture
        border: Border.all(color: Colors.blueGrey.shade200, width: 1.2),

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
          Divider(thickness: 1.2, color: Colors.blueGrey.shade200),

          const SizedBox(height: 16),

          ...children.map(
            (e) =>
                Padding(padding: const EdgeInsets.only(bottom: 16), child: e),
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
          borderSide: BorderSide(color: Colors.blueGrey.shade400, width: 1.3),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF1976D2), width: 1.8),
        ),
      ),
    );
  }

  Widget _dropdown(
      String label, {
        required String? value,
        required List<String> items,
        required Function(String?) onChanged,
      }) {
    return DropdownButtonFormField<String>(
      value: value,
      isExpanded: true,   // 🔥 VERY IMPORTANT FIX
      decoration: InputDecoration(
        labelText: label,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF1565C0)),
        ),
      ),
      items: items
          .map(
            (item) => DropdownMenuItem(
          value: item,
          child: Text(
            item,
            overflow: TextOverflow.ellipsis,  // 🔥 prevent overflow
          ),
        ),
      )
          .toList(),
      onChanged: onChanged,
    );
  }
}
