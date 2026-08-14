import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../models/njm_ftk_response/habitation_assest.dart';
import '../../../../../providers/wso/wso_provider.dart';
import '../../../../../service/local_storage_service.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/app_dialog.dart';
import '../../../../../utils/auth/user_session_manager.dart';
import '../../../../../utils/device_utils.dart';
import '../../../../../utils/enum/app_dialog.dart';
import '../../../../../utils/toast_helper.dart';


class PumpingMain extends StatefulWidget {
  const PumpingMain({super.key});

  @override
  State<PumpingMain> createState() => _PumpingMain();
}

class _PumpingMain extends State<PumpingMain> {
  // ================= VARIABLES =================
  final LocalStorageService _localStorage = LocalStorageService();
  final session = UserSessionManager();
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
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      controller.text = picked.format(context);
      _calculatePumpingHours();
    }
  }

  void _calculatePumpingHours() {
    if (startTimeController.text.isEmpty || stopTimeController.text.isEmpty)
      return;

    final start = TimeOfDay(
      hour: int.parse(startTimeController.text.split(":")[0]),
      minute: int.parse(startTimeController.text.split(":")[1].split(" ")[0]),
    );

    final stop = TimeOfDay(
      hour: int.parse(stopTimeController.text.split(":")[0]),
      minute: int.parse(stopTimeController.text.split(":")[1].split(" ")[0]),
    );

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
      double startReading = double.tryParse(flowStartController.text) ?? 0;

      double stopReading = double.tryParse(flowStopController.text) ?? 0;

      // Case 1: Start - Stop (as per your document)
      volume = startReading - stopReading;

      // Prevent negative result
      if (volume < 0) {
        volume = 0;
      }
    } else {
      double discharge = double.tryParse(dischargeController.text) ?? 0;

      double pumpingHours = double.tryParse(pumpingHoursController.text) ?? 0;

      // Case 2: Discharge × Pumping Hours
      volume = discharge * pumpingHours;
    }

    volumeController.text = volume.toStringAsFixed(2);
  }

  // ================= UI =================

  @override
  void initState() {
    session.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final njm_wsoProvider = context.watch<WsoProvider>();
    final SjlAllAsset asset =
        ModalRoute.of(context)!.settings.arguments as SjlAllAsset;
    return Scaffold(
      backgroundColor: const Color(0xFFF2F6FF),

      appBar: AppBar(
        backgroundColor: const Color(0xFF1976D2),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
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
              // ================= BASIC DETAILS =================
              _sectionCard(
                icon: Icons.water,
                title: "Pump Details",
                children: [
                  _dropdown(
                    "Type of Pump",
                    value: njm_wsoProvider.selectedPumpLabel,
                    items: njm_wsoProvider.typesofpumpMap.keys.toList(),
                    onChanged: (value) {
                      njm_wsoProvider.setSelectedtypesofpump(value);
                      print("pump id ${njm_wsoProvider.selectedtypesofpumpId}");
                    },
                  ),

                  _dropdown(
                    "Location",
                    value: njm_wsoProvider.selectedlocationlabel,
                    items: njm_wsoProvider.typesoflocationMap.keys.toList(),
                    onChanged: (value) {
                      njm_wsoProvider.setSelectedtypesoflocation(value);
                      print(
                        "location id ${njm_wsoProvider.selectedlocationId}",
                      );
                    },
                  ),

                  _input(
                    "Discharge of Pump (m3/h)",
                    controller: njm_wsoProvider.dischargeController,
                    keyboard: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                  ),

                  _input(
                    "Head of Pump (m)",
                    controller: njm_wsoProvider.headController,
                    keyboard: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              _sectionCard(
                icon: Icons.speed,
                title: "Flow Meter Details",
                children: [
                  _dropdown(
                    "Flow Meter Installed?",
                    value: njm_wsoProvider.Isflow_meter_yesno,
                    items: njm_wsoProvider.yesnoMap.keys.toList(),
                    onChanged: (value) {
                      njm_wsoProvider.setIsFlowMeterYesNo(value);
                    },
                  ),
                ],
              ),

              const SizedBox(height: 30),
              _submitButton(njm_wsoProvider, asset),
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
        border: Border.all(color: Colors.blueGrey.shade200, width: 1.2),

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

  Widget _submitButton(WsoProvider provider, SjlAllAsset asset) {
    return InkWell(
      onTap: () async {
        await provider.insertOrUpdateGroundWaterPumpHouse(
          id: 0,
          stateId: 31,
          rpwssId: asset.rpwssId!,
          outVillageId: asset.outVillageId!,
          assetId: asset.assetId!,
          assetTypeId: asset.assetTypeId!,
          assetType: asset.assetType!,
          habitationId: 1030748,
          typeOfPumpId: provider.selectedtypesofpumpId!,
          feedingTypeId: provider.selectedlocationId!,
          dischargeOfPump: double.parse(provider.dischargeController.text),
          dischargeUnit: 'm3/h',
          headPump: double.parse(provider.headController.text),
          headPumpUnit: 'm',
          isFlowMeterInstalled: provider.Isflow_meter_yesnoId!,
          createdBy: session.userId,
          createdIp: DeviceInfoUtil.deviceId,
        );
        await provider.groundWaterResponse!.status == true
            ? AppDialog.show(
                context,
                type: AppDialogType.success,
                message: provider.wsoSsgRegistrationResponse?.message,
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppConstants.navigateToWSOCategory,
                    (route) => false,
                  );
                },
              )
            : ToastHelper.showToastMessage(provider.errorMsg!);
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
            "Save Pump Entry",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
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
      isExpanded: true,
      // 🔥 VERY IMPORTANT FIX
      decoration: InputDecoration(
        labelText: label,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
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
                overflow: TextOverflow.ellipsis, // 🔥 prevent overflow
              ),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }
}
