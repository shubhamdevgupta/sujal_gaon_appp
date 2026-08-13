import 'package:flutter/material.dart';

class MembersCommunitywqms extends StatefulWidget {
  const MembersCommunitywqms({super.key});

  @override
  State<MembersCommunitywqms> createState() => _MembersCommunitywqms();
}

class _MembersCommunitywqms extends State<MembersCommunitywqms> {
  String? selectedGender;
  String? selectedQualification;
  String? selectedTrainingStatus;
  String? selectedValidationStatus;

  DateTime? dob;
  DateTime? validationDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1976D2),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "SSG Registration",
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
              _sectionCard(
                icon: Icons.groups,
                title: "Organization Details",
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.blue.shade200),
                    ),
                    child: const Text(
                      "Members for Community WQMS – Water Quality Testing",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),

                  _input("Full Name", maxLength: 100),

                  _input("Father Name", maxLength: 100),

                  _dropdown(
                    "Gender",
                    value: selectedGender,
                    items: const ["Male", "Female"],
                    onChanged: (value) {
                      setState(() {
                        selectedGender = value;
                      });
                    },
                  ),

                  _datePicker(
                    label: "Date of Birth",
                    date: dob,
                    onSelect: (value) {
                      setState(() {
                        dob = value;
                      });
                    },
                  ),

                  _input("Mobile Number", keyboard: TextInputType.phone),

                  _input(
                    "Aadhaar (Last 4 Digits)",
                    keyboard: TextInputType.number,
                    maxLength: 4,
                  ),

                  _input("Complete Address", maxLines: 2, maxLength: 500),

                  _dropdown(
                    "Educational Qualification",
                    value: selectedQualification,
                    items: const [
                      "Below 8th",
                      "8th",
                      "10th",
                      "12th",
                      "Graduate and above",
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedQualification = value;
                      });
                    },
                  ),

                  _dropdown(
                    "Received Training on FTK Earlier",
                    value: selectedTrainingStatus,
                    items: const ["Yes", "No"],
                    onChanged: (value) {
                      setState(() {
                        selectedTrainingStatus = value;
                      });
                    },
                  ),

                  if (selectedTrainingStatus == "Yes")
                    _input(
                      "Years of Experience",
                      keyboard: TextInputType.number,
                    ),

                  _readOnly("Date of Registration", formatDate(DateTime.now())),

                  _dropdown(
                    "Validation Status",
                    value: selectedValidationStatus,
                    items: const ["Verified", "Pending"],
                    onChanged: (value) {
                      setState(() {
                        selectedValidationStatus = value;
                      });
                    },
                  ),

                  if (selectedValidationStatus == "Verified")
                    _datePicker(
                      label: "Validation Date",
                      date: validationDate,
                      onSelect: (value) {
                        setState(() {
                          validationDate = value;
                        });
                      },
                    ),
                ],
              ),

              const SizedBox(height: 10),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Submit
                  },
                  label: const Text(
                    "Submit",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1976D2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
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

  // ================= INPUT =================

  // ================= DROPDOWN =================

  Widget _dropdown(
    String hint, {
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      isExpanded: true,
      value: value,
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
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      items: items.map((e) {
        return DropdownMenuItem<String>(
          value: e,
          child: Text(e, overflow: TextOverflow.ellipsis, maxLines: 1),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  // ================= READ ONLY =================

  Widget _readOnly(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F7FB),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.blueGrey.shade200),
      ),
      child: Row(
        children: [
          Text("$label: ", style: const TextStyle(fontWeight: FontWeight.w600)),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Color(0xFF1976D2),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= DATE PICKER =================
  String formatDate(DateTime? date) {
    if (date == null) return "";
    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year}";
  }

  Widget _datePicker({
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

        if (picked != null) onSelect(picked);
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.blueGrey.shade400),
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_today, color: Color(0xFF1565C0)),
            const SizedBox(width: 12),
            Text(
              date == null ? label : "${date.day}/${date.month}/${date.year}",
            ),
          ],
        ),
      ),
    );
  }
}
