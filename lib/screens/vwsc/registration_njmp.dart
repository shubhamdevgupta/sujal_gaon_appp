import 'package:flutter/material.dart';
import 'package:jal_sanchalan/providers/vwsc/vwsc_provider.dart';
import 'package:jal_sanchalan/service/local_storage_service.dart';
import 'package:jal_sanchalan/utils/app_constants.dart';
import 'package:jal_sanchalan/utils/enum/user_type.dart';
import 'package:provider/provider.dart';

import '../../providers/master_provider.dart';
import '../../utils/auth/user_session_manager.dart';
import '../../utils/custom screen/custom_dropdown.dart';

class NJMPRegistrationForm extends StatefulWidget {
  const NJMPRegistrationForm({super.key});

  @override
  State<NJMPRegistrationForm> createState() => _NJMPRegistrationFormState();
}

class _NJMPRegistrationFormState extends State<NJMPRegistrationForm> {
  String? trainingLevel;
  String? selectedVillage;
  String? selectedHabitation;
  final LocalStorageService _localStorage = LocalStorageService();
  final session = UserSessionManager();
  DateTime? fromDate;
  DateTime? toDate;


  @override
  void initState() {
    super.initState();
    session.init();
    final masterProvider = Provider.of<MasterProvider>(context, listen: false);
    masterProvider.fetchVillage(_localStorage.getString(AppConstants.prefPanchayatId)!);
  }

  @override
  Widget build(BuildContext context) {
    final masterProvider = context.watch<MasterProvider>();
    final vwscProvider = context.watch<VwscProvider>();
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),

      appBar: AppBar(
        backgroundColor: const Color(0xFF1565C0),
        title: const Text(
          "NJM Registration",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
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
                    icon: Icons.person,
                    title: "Operator Details",
                    children: [
                      _input(
                        "Name of the Operator",
                        controller: vwscProvider.nameController,
                      ),
                      _input(
                        "Contact Number",
                        keyboard: TextInputType.phone,
                        controller: vwscProvider.phoneController,
                      ),
                      _input(
                        "Email Id",
                        keyboard: TextInputType.emailAddress,
                        controller: vwscProvider.emailController,
                      ),
                      _input(
                        "Complete Address",
                        maxLines: 3,
                        controller: vwscProvider.addressController,
                      ),
                      _dropdown(
                        "Level of Training",
                        value: vwscProvider.selectedLevelLabel,
                        items: vwscProvider.levelTranningMap.keys.toList(),
                        onChanged: (value) {
                          vwscProvider.setSelectedLevel(value);
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 22),

                  _sectionCard(
                    icon: Icons.location_city,
                    title: "Village & Habitation Selection",
                    children: [
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

              const SizedBox(height: 22),

              /*     _sectionCard(
                icon: Icons.map,
                title: "Authority & Area of Operation",
                children: [
                  _input("Appointment Authority Details"),

                  _dropdown(
                    "Select Village (Area of Operation)",
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
                ],
              ), */

              // ================= VALIDATION =================
              _sectionCard(
                icon: Icons.date_range,
                title: "Validation Period",
                children: [
                  _datePicker(
                    label: "Valid From",
                    date: vwscProvider.fromDate,
                    onSelect: (d) => vwscProvider.setFromDate(d),
                  ),
                  _datePicker(
                    label: "Valid To",
                    date: vwscProvider.toDate,
                    onSelect: (d) => vwscProvider.setToDate(d),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              _submitButton(vwscProvider, masterProvider),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // ================= SECTION CARD =================
  String formatDate(DateTime? date) {
    if (date == null) return "";
    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year}";
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

  Widget _dropdown(
    String label, {
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF1565C0)),
        ),
      ),
      items: items
          .map((item) => DropdownMenuItem(value: item, child: Text(item)))
          .toList(),
      onChanged: onChanged,
    );
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

  // ================= BUTTON =================

  Widget _submitButton(VwscProvider provider, MasterProvider masterProvider) {
    return InkWell(
      onTap: () {
        provider.registerNjmFTK(
          regId: 0,
          userTypeId: UserType.njmp.id,
          stateId: int.parse(_localStorage.getString(AppConstants.prefState)!),
          districtId: int.parse(
            _localStorage.getString(AppConstants.prefDistrict)!,
          ),
          blockId: int.parse(
            _localStorage.getString(AppConstants.prefBlockId)!,
          ),
          panchayatId: int.parse(
            _localStorage.getString(AppConstants.prefPanchayatId)!,
          ),
          villageId: int.parse(masterProvider.selectedVillageId!),
          firstName: provider.nameController.text,
          lastName: '',
          mobileNumber: int.parse(provider.phoneController.text),
          designation: '',
          email: provider.emailController.text,
          gender: '',
          address: provider.addressController.text,
          levelTrainingId: provider.selectedLevelId!,
          ipAddress: provider.deviceId.toString(),
          createdBy: session.userId,
          validatedFrom: formatDate(provider.fromDate),
          validatedTo: formatDate(provider.toDate),
          habitationIds: masterProvider.selectedHabitationIds.toString(),
        );
      },
      child: Container(
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
      ),
    );
  }
}
