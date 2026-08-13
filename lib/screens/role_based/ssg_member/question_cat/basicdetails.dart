import 'package:flutter/material.dart';

class Basicdetails extends StatefulWidget {
  const Basicdetails({super.key});

  @override
  State<Basicdetails> createState() => _Basicdetails();
}

class _Basicdetails extends State<Basicdetails> {
  String? trainingLevel;
  String? selectedVillage;
  String? selectedHabitation;

  DateTime? fromDate;
  DateTime? toDate;

  // Demo auto values (Replace with API)
  final String gpName = "Hooda Gram Panchayat";
  final String gpLGD = "123456";
  final String villageName = "Sujal Gaon";
  final String villageLGD = "654321";
  final String districtName = "Sonipat";
  final String districtLGD = "111222";
  final String stateName = "Haryana";

  final List<String> villages = ["Sujal Gaon", "Rampur", "Khera"];

  final Map<String, List<String>> habitations = {
    "Sujal Gaon": ["Hab-1", "Hab-2"],
    "Rampur": ["Hab-A", "Hab-B"],
    "Khera": ["Hab-X", "Hab-Y"],
  };

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
        title: const Text(
          "Basic Details",
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
              const SizedBox(height: 26),

              // ================= OPERATOR DETAILS =================
              _sectionCard(
                icon: Icons.person,
                title: "Operator Details",
                children: [
                  _input("Name of Operator"),

                  _input("Contact Number", keyboard: TextInputType.phone),

                  _input("Complete Address", keyboard: TextInputType.multiline),

                  _dropdown(
                    "Level of Training",
                    items: const [
                      DropdownMenuItem(
                        value: "Not Trained",
                        child: Text("Not Trained"),
                      ),
                      DropdownMenuItem(
                        value: "Nal Jal Mitra",
                        child: Text("Nal Jal Mitra (PMKVY-JJM)"),
                      ),
                      DropdownMenuItem(
                        value: "State Programme",
                        child: Text("Trained under State Programme"),
                      ),
                    ],
                    onChanged: (v) {
                      setState(() {
                        trainingLevel = v;
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 22),

              // ================= AUTO POPULATED =================
              _sectionCard(
                icon: Icons.account_balance,
                title: "JJM IMIS Details",
                children: [
                  _readOnly("Gram Panchayat", gpName),
                  _readOnly("GP LGD Code", gpLGD),

                  _readOnly("Village", villageName),
                  _readOnly("Village LGD", villageLGD),

                  _readOnly("District", districtName),
                  _readOnly("District LGD", districtLGD),

                  _readOnly("State", stateName),
                ],
              ),

              const SizedBox(height: 22),

              // ================= AUTHORITY =================
              _sectionCard(
                icon: Icons.verified_user,
                title: "Appointment Authority",
                children: [_input("Authority Name & Designation")],
              ),

              const SizedBox(height: 22),

              // ================= AREA OF OPERATION =================
              _sectionCard(
                icon: Icons.map,
                title: "Area of Operation",
                children: [
                  _dropdown(
                    "Select Village",
                    value: selectedVillage,
                    items: villages
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (v) {
                      setState(() {
                        selectedVillage = v;
                        selectedHabitation = null;
                      });
                    },
                  ),

                  const SizedBox(height: 16),

                  _dropdown(
                    "Select Habitation",
                    value: selectedHabitation,
                    items: selectedVillage == null
                        ? []
                        : habitations[selectedVillage]!
                              .map(
                                (e) =>
                                    DropdownMenuItem(value: e, child: Text(e)),
                              )
                              .toList(),
                    onChanged: (v) {
                      setState(() {
                        selectedHabitation = v;
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 22),

              // ================= VALIDATION PERIOD =================
              _sectionCard(
                icon: Icons.date_range,
                title: "Validated For",
                children: [
                  _datePickerBox(
                    label: "Valid From",
                    date: fromDate,
                    onSelect: (picked) {
                      setState(() {
                        fromDate = picked;
                      });
                    },
                  ),

                  _datePickerBox(
                    label: "Valid To",
                    date: toDate,
                    onSelect: (picked) {
                      setState(() {
                        toDate = picked;
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 32),

              _saveButton(),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // ====================================================
  // HEADER
  // ====================================================

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E88E5), Color(0xFF0D47A1)],
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      child: const Row(
        children: [
          Icon(Icons.water_drop, color: Colors.white),
          SizedBox(width: 10),
          Text(
            "NJMP Operator Registration",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
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

        prefixIcon: const Icon(Icons.edit, color: Color(0xFF1976D2), size: 18),

        filled: true,
        fillColor: Colors.white,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),

        // 🔥 Darker textured border
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
    String hint, {
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

        // 🔥 Dark textured border (same as input)
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.blueGrey.shade400, width: 1.3),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF1976D2), width: 1.8),
        ),
      ),
      items: items,
      onChanged: onChanged,
    );
  }

  Widget _readOnly(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Text("$label: ", style: const TextStyle(fontWeight: FontWeight.w600)),
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

  Widget _datePickerBox({
    required String label,
    required DateTime? date,
    required Function(DateTime) onSelect,
  }) {
    return InkWell(
      onTap: () async {
        DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );

        if (picked != null) {
          onSelect(picked);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFFF9FBFF),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_today, color: Color(0xFF1976D2)),
            const SizedBox(width: 10),
            Text(
              date == null ? label : "${date.day}/${date.month}/${date.year}",
            ),
          ],
        ),
      ),
    );
  }

  Widget _saveButton() {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E88E5), Color(0xFF0D47A1)],
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: const Center(
        child: Text(
          "Submit Registration",
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
