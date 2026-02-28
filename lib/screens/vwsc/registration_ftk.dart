import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/master_provider.dart';
import '../../utils/custom screen/custom_dropdown.dart';

class SHGFTKRegistrationForm extends StatefulWidget {
  const SHGFTKRegistrationForm({super.key});

  @override
  State<SHGFTKRegistrationForm> createState() => _SHGFTKRegistrationFormState();
}

class _SHGFTKRegistrationFormState extends State<SHGFTKRegistrationForm> {
  String? selectedVillage;
  String? selectedHabitation;

  DateTime? fromDate;
  DateTime? toDate;

  // ===== Demo Auto Data (Replace with API) =====
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
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    final masterProvider = Provider.of<MasterProvider>(context, listen: false);

    await masterProvider.fetchVillage("252219");
  }

  @override
  Widget build(BuildContext context) {
    final masterProvider = context.watch<MasterProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1976D2),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "SHGs / FTK Registration",
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionCard(
                    icon: Icons.location_city,
                    title: "Village & Habitation Selection",
                    children: [
                      /// ===============================
                      /// VILLAGE DROPDOWN
                      /// ===============================
                      CustomDropdown(
                        value: masterProvider.selectedVillageId,
                        items: masterProvider.villages.map((village) {
                          return DropdownMenuItem<String>(
                            value: village.villageId.toString(),
                            child: Text(
                              village.villageName,
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        }).toList(),
                        title: "Village *",
                        onChanged: (value) {
                          masterProvider.setSelectedVillage(value);

                          if (value != null && value.isNotEmpty) {
                            masterProvider.fetchHabitation(value);
                          }
                        },
                        appBarTitle: "Select Village",
                      ),

                      /// ===============================
                      /// HABITATION SECTION
                      /// ===============================
                      if (masterProvider.selectedVillageId != null) ...[
                        if (masterProvider.isLoading)
                          const Padding(
                            padding: EdgeInsets.all(12),
                            child: Center(child: CircularProgressIndicator()),
                          ),

                        if (!masterProvider.isLoading &&
                            masterProvider.habitations.isEmpty)
                          const Padding(
                            padding: EdgeInsets.all(12),
                            child: Text("No Habitations Found"),
                          ),

                        if (masterProvider.habitations.isNotEmpty) ...[
                          const Text(
                            "Select Habitations",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),

                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: masterProvider.habitations.map((hab) {
                              final habId = hab.habitationId.toString();

                              final isSelected = masterProvider
                                  .selectedHabitationIds
                                  .contains(habId);

                              return FilterChip(
                                label: Text(
                                  hab.habitationName,
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black87,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),

                                selected: isSelected,

                                onSelected: (_) {
                                  masterProvider.toggleHabitation(habId);
                                },

                                selectedColor: Colors.blue,

                                // 🔵 Blue when selected
                                backgroundColor: Colors.grey.shade100,

                                checkmarkColor: Colors.white,

                                elevation: isSelected ? 4 : 0,

                                shadowColor: Colors.blue.withOpacity(0.4),

                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  side: BorderSide(
                                    color: isSelected
                                        ? Colors.blue
                                        : Colors.grey.shade300,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ],
                    ],
                  ),
                ],
              ),

              SizedBox(height: 22,),
              // ================= PERSONAL DETAILS =================
              _sectionCard(
                icon: Icons.person,
                title: "Personal Details",
                children: [
                  _input("Name (First + Last Name)"),

                  _input("Contact Number", keyboard: TextInputType.phone),

                  _input("Complete Address", maxLines: 3),
                ],
              ),

              const SizedBox(height: 22),

              /*              // ================= JJM REGISTRY =================
              _sectionCard(
                icon: Icons.account_balance,
                title: "JJM IMIS Registry Details",
                children: [

                  _readOnly("Gram Panchayat", gpName),
                  _readOnly("GP LGD Code", gpLGD),

                  _readOnly("Village", villageName),
                  _readOnly("Village LGD Code", villageLGD),

                  _readOnly("District", districtName),
                  _readOnly("District LGD Code", districtLGD),

                  _readOnly("State", stateName),
                ],
              ),

              const SizedBox(height: 22),*/

              // ================= AREA OF OPERATION =================
              _sectionCard(
                icon: Icons.map,
                title: "Area of Operation",
                children: [
                  _dropdown(
                    "Select Village",
                    value: selectedVillage,
                    items: villages,
                    onChanged: (v) {
                      setState(() {
                        selectedVillage = v;
                        selectedHabitation = null;
                      });
                    },
                  ),

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

              const SizedBox(height: 30),

              _submitButton(),

              const SizedBox(height: 40),
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
          borderSide: BorderSide(color: Colors.blueGrey.shade400, width: 1.3),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF1976D2), width: 1.8),
        ),
      ),

      items: items
          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          .toList(),

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

        if (picked != null) onSelect(picked);
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.blueGrey.shade400, width: 1.3),
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_today, color: Color(0xFF1976D2)),
            const SizedBox(width: 12),
            Text(
              date == null ? label : "${date.day}/${date.month}/${date.year}",
            ),
          ],
        ),
      ),
    );
  }

  // ================= SUBMIT BUTTON =================

  Widget _submitButton() {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E88E5), Color(0xFF1565C0)],
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: const Center(
        child: Text(
          "Submit Registration",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
