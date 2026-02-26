import 'package:flutter/material.dart';

class LocationFormScreen extends StatefulWidget {
  const LocationFormScreen({super.key});

  @override
  State<LocationFormScreen> createState() => _LocationFormScreenState();
}

class _LocationFormScreenState extends State<LocationFormScreen> {

  String? selectedState;
  String? selectedDistrict;
  String? selectedBlock;
  String? selectedVillage;
  String? selectedHabitation;
  String? selectedScheme;

  final lgdController = TextEditingController();
  final jjmController = TextEditingController();

  /// Demo Data (Replace With API)
  final List<String> states = ["Uttar Pradesh", "Bihar", "Madhya Pradesh"];

  final Map<String, List<String>> districts = {
    "Uttar Pradesh": ["Lucknow", "Varanasi"],
    "Bihar": ["Patna", "Gaya"],
    "Madhya Pradesh": ["Bhopal", "Indore"],
  };

  final Map<String, List<String>> blocks = {
    "Lucknow": ["Block A", "Block B"],
    "Patna": ["Block X", "Block Y"],
  };

  final Map<String, List<String>> villages = {
    "Block A": ["Village 1", "Village 2"],
    "Block X": ["Village 3", "Village 4"],
  };

  final Map<String, List<String>> habitations = {
    "Village 1": ["Hab 1", "Hab 2"],
    "Village 3": ["Hab 3", "Hab 4"],
  };

  final Map<String, List<String>> schemes = {
    "Village 1": ["Scheme 101", "Scheme 102"],
    "Village 3": ["Scheme 201", "Scheme 202"],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F6FF),

      appBar: AppBar(
        backgroundColor: const Color(0xFF1976D2),

        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context),),
        title: const Text("Location Details",style: TextStyle(color: Colors.white),),
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
                icon: Icons.location_on,
                title: "Location (Up to Habitation)",
                children: [

                  /// STATE
                  _dropdown(
                    "Select State / UT",
                    value: selectedState,
                    items: states,
                    onChanged: (v) {
                      setState(() {
                        selectedState = v;
                        selectedDistrict = null;
                        selectedBlock = null;
                        selectedVillage = null;
                        selectedHabitation = null;
                        selectedScheme = null;
                      });
                    },
                  ),

                  /// DISTRICT
                  _dropdown(
                    "Select District",
                    value: selectedDistrict,
                    items: selectedState == null
                        ? []
                        : districts[selectedState] ?? [],
                    onChanged: (v) {
                      setState(() {
                        selectedDistrict = v;
                        selectedBlock = null;
                        selectedVillage = null;
                      });
                    },
                  ),

                  /// BLOCK
                  _dropdown(
                    "Select Block",
                    value: selectedBlock,
                    items: selectedDistrict == null
                        ? []
                        : blocks[selectedDistrict] ?? [],
                    onChanged: (v) {
                      setState(() {
                        selectedBlock = v;
                        selectedVillage = null;
                      });
                    },
                  ),

                  /// VILLAGE
                  _dropdown(
                    "Select Village",
                    value: selectedVillage,
                    items: selectedBlock == null
                        ? []
                        : villages[selectedBlock] ?? [],
                    onChanged: (v) {
                      setState(() {
                        selectedVillage = v;
                        selectedHabitation = null;
                        selectedScheme = null;
                      });
                    },
                  ),

                  /// LGD CODE
                  _input("LGD Code"),

                  /// JJM ID
                  _input("JJM Village ID"),

                  /// HABITATION
                  _dropdown(
                    "Select Habitation",
                    value: selectedHabitation,
                    items: selectedVillage == null
                        ? []
                        : habitations[selectedVillage] ?? [],
                    onChanged: (v) {
                      setState(() {
                        selectedHabitation = v;
                      });
                    },
                  ),

                  /// SCHEME
                  _dropdown(
                    "Select JJM Scheme",
                    value: selectedScheme,
                    items: selectedVillage == null
                        ? []
                        : schemes[selectedVillage] ?? [],
                    onChanged: (v) {
                      setState(() {
                        selectedScheme = v;
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

  // ====================================================
  // DROPDOWN
  // ====================================================

  Widget _dropdown(
      String hint, {
        required String? value,
        required List<String> items,
        required Function(String?) onChanged,
      }) {
    final bool isDisabled = items.isEmpty;

    return DropdownButtonFormField<String>(
      value: value,
      icon: const Icon(
        Icons.keyboard_arrow_down_rounded,
        color: Color(0xFF1976D2),
      ),

      decoration: InputDecoration(
        hintText: hint,

        prefixIcon: const Icon(
          Icons.location_city,
          color: Color(0xFF1976D2),
          size: 18,
        ),

        filled: true,
        fillColor: isDisabled
            ? Colors.grey.shade100
            : Colors.white,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),

        // 🔥 Dark textured border
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

        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: Colors.blueGrey.shade200,
            width: 1.0,
          ),
        ),
      ),

      items: items
          .map(
            (e) => DropdownMenuItem(
          value: e,
          child: Text(
            e,
            style: const TextStyle(fontSize: 14),
          ),
        ),
      )
          .toList(),

      onChanged: isDisabled ? null : onChanged,
    );
  }


  // ====================================================
  // BUTTON
  // ====================================================

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