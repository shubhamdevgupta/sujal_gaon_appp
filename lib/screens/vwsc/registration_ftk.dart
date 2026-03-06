import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/master_provider.dart';
import '../../providers/vwsc/vwsc_provider.dart';
import '../../service/local_storage_service.dart';
import '../../utils/app_constants.dart';
import '../../utils/auth/user_session_manager.dart';
import '../../utils/custom screen/custom_dropdown.dart';
import '../../utils/enum/user_type.dart';
import '../../utils/toast_helper.dart';

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

  final LocalStorageService _localStorage = LocalStorageService();
  final session = UserSessionManager();

  @override
  void initState() {
    super.initState();
    session.init();
    final masterProvider = Provider.of<MasterProvider>(context, listen: false);
    masterProvider.fetchVillage(
      _localStorage.getString(AppConstants.prefPanchayatId)!,
    );
  }

  @override
  Widget build(BuildContext context) {
    final masterProvider = context.watch<MasterProvider>();
    final vwscProvider = context.watch<VwscProvider>();

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
              _sectionCard(
                icon: Icons.map,
                title: "Area of Operation",
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
              const SizedBox(height: 22),
              _sectionCard(
                icon: Icons.person,
                title: "Personal Details",
                children: [
                  _input(
                    "Name (First + Last Name)",
                    controller: vwscProvider.nameController,
                  ),

                  _input(
                    "Mobile Number",
                    controller: vwscProvider.phoneController,
                    keyboard: TextInputType.phone,
                  ),

                  _input(
                    "Email Id",
                    keyboard: TextInputType.emailAddress,
                    controller: vwscProvider.emailController,
                  ),

                  _input(
                    "Complete Address",
                    controller: vwscProvider.addressController,
                    maxLines: 3,
                  ),
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


              _submitButton(vwscProvider, masterProvider),

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

  //====== validation ===============

  bool _validateForm(VwscProvider provider, MasterProvider masterProvider) {
    // Village validation
    if (masterProvider.selectedVillageId == null ||
        masterProvider.selectedVillageId!.isEmpty) {
      ToastHelper.showErrorSnackBar(context, "Please select village");
      return false;
    }

    // Habitation validation
    if (masterProvider.selectedHabitationIds.isEmpty) {
      ToastHelper.showErrorSnackBar(context, "Please select at least one habitation");
      return false;
    }

    // Name validation
    if (provider.nameController.text.trim().isEmpty) {
      ToastHelper.showErrorSnackBar(context, "Please enter operator name");
      return false;
    }

    // Mobile validation
    String mobile = provider.phoneController.text.trim();
    if (mobile.isEmpty) {
      ToastHelper.showErrorSnackBar(context, "Please enter mobile number");
      return false;
    }

    if (mobile.length != 10 || !RegExp(r'^[0-9]+$').hasMatch(mobile)) {
      ToastHelper.showErrorSnackBar(context, "Enter valid 10 digit mobile number");
      return false;
    }

    // Email validation (optional)
/*    String email = provider.emailController.text.trim();
    if (email.isNotEmpty) {
      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(email)) {
        ToastHelper.showErrorSnackBar(context, "Enter valid email address");
        return false;
      }
    }*/

    // Address validation
    if (provider.addressController.text.trim().isEmpty) {
      ToastHelper.showErrorSnackBar(context, "Please enter address");
      return false;
    }

    // Training Level validation
    if (provider.selectedLevelId == null) {
      ToastHelper.showErrorSnackBar(context, "Please select training level");
      return false;
    }

    return true;
  }

  // ================= SUBMIT BUTTON =================

  Widget _submitButton(VwscProvider provider, MasterProvider masterProvider) {
    provider.fetchDeviceId();
    return InkWell(
      onTap: () async {

        if (!_validateForm(provider, masterProvider)) {
          return;
        }
        await provider.registerNjmFTK(
          regId: 0,
          userTypeId: UserType.ftk.id,
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
          levelTrainingId: 0,
          ipAddress: provider.deviceId.toString(),
          createdBy: session.userId,
          validatedFrom: formatDate(provider.fromDate),
          validatedTo: formatDate(provider.toDate),
          habitationIds: masterProvider.selectedHabitationIdsAsString,
        );
        if (provider.njmFtkRegistrationResponse != null &&
            provider.njmFtkRegistrationResponse!.status == true) {
          showDialog(
            context: context,
            barrierDismissible: false, // Disable tap outside to dismiss
            builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              titlePadding: const EdgeInsets.only(top: 20),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 10,
              ),
              actionsPadding: const EdgeInsets.only(bottom: 10, right: 10),
              title: Column(
                children: [
                  Image.asset(
                    'assets/icons/check.png',
                    // <-- Your success image (PNG) path here
                    height: 60,
                    width: 80,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Success!",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              content: Text(
                provider.njmFtkRegistrationResponse?.message ??
                    'FTK Registration completed!',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
              actions: [
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 12,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context); // Close dialog
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        AppConstants.navigateToFtkLandingpage,
                        (route) => false, // Clear back stack
                      );
                      provider.clearData();
                    },
                    child: const Text(
                      "OK",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          ToastHelper.showErrorSnackBar(
            context,
            provider.njmFtkRegistrationResponse!.message ??
                "Registration Failed",
          );
        }
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
