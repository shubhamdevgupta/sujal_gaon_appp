import 'package:flutter/material.dart';
import 'package:jal_sanchalan/utils/app_constants.dart';
import 'package:jal_sanchalan/utils/device_utils.dart';
import 'package:provider/provider.dart';
import 'dart:math';

import '../../../../../models/njm_ftk_response/habitation_assest.dart';
import '../../../../../providers/njm_wso/njm_wso_provider.dart';
import '../../../../../service/local_storage_service.dart';
import '../../../../../utils/auth/user_session_manager.dart';

class GroundwatersourcetubeMain extends StatefulWidget {

  const GroundwatersourcetubeMain({super.key});

  @override
  State<GroundwatersourcetubeMain> createState() =>
      _GroundwatersourcetubeMain();
}

class _GroundwatersourcetubeMain extends State<GroundwatersourcetubeMain> {

  final LocalStorageService _localStorage = LocalStorageService();
  final session = UserSessionManager();

  String? pumpType;
  String? locationType;
  String? flowMeterInstalled;

  final dischargeController = TextEditingController();
  final headController = TextEditingController();
  final startTimeController = TextEditingController();
  final stopTimeController = TextEditingController();

  final flowStartController = TextEditingController();
  final flowStopController = TextEditingController();

  final pumpingHoursController = TextEditingController();
  final volumeController = TextEditingController();

  // ================= CALCULATIONS =================

  void _calculatePumpingHours() {
    if (startTimeController.text.isEmpty ||
        stopTimeController.text.isEmpty) return;

    try {
      final start = _parseTime(startTimeController.text);
      final stop = _parseTime(stopTimeController.text);

      final difference =
          stop.difference(start).inMinutes / 60;

      if (difference > 0) {
        pumpingHoursController.text =
            difference.toStringAsFixed(2);
        _calculateVolume();
      }
    } catch (_) {}
  }

  DateTime _parseTime(String input) {
    final parts = input.split(":");
    return DateTime(
        2024,
        1,
        1,
        int.parse(parts[0]),
        int.parse(parts[1]));
  }

  void _calculateVolume() {
    double volume = 0;

    if (flowMeterInstalled == "Yes") {
      double start =
          double.tryParse(flowStartController.text) ?? 0;
      double stop =
          double.tryParse(flowStopController.text) ?? 0;

      volume = stop - start;
    } else {
      double discharge =
          double.tryParse(dischargeController.text) ?? 0;
      double hours =
          double.tryParse(pumpingHoursController.text) ?? 0;

      volume = discharge * hours;
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
    final njm_wsoProvider = context.watch<NjmWsoProvider>();
    final SjlAllAsset asset = ModalRoute.of(context)!.settings.arguments as SjlAllAsset;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),

      appBar: AppBar(
        backgroundColor: const Color(0xFF1976D2),
        title: const Text(
          "Ground Water Source ",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
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

              // ================= CONFIGURATION =================
              _sectionCard(
                icon: Icons.settings,
                title: "Pump Configuration",
                children: [

                  _dropdown(
                    "Type of Pump",
                    value: njm_wsoProvider.selectedtypesofpump,
                    items: njm_wsoProvider.typesofpumpMap.keys.toList(),
                    onChanged: (value) {
                      njm_wsoProvider.setSelectedtypesofpump(value);
                    },
                  ),



                  _input(
                    "Discharge of Pump (m3/h)",
                    controller: njm_wsoProvider.dischargeController,
                    keyboard: TextInputType.number,
                  ),

                  _input(
                    "Head of Pump (m)",
                    controller: njm_wsoProvider.headController,
                    keyboard: TextInputType.number,
                  ),
                ],
              ),

              const SizedBox(height: 22),

              // ================= FLOW METER =================
              _sectionCard(
                icon: Icons.speed,
                title: "Flow Meter Details",
                children: [

                  _dropdown(
                    "Flow Meter Installed?",
                    value: njm_wsoProvider.Isflow_meter_yesno,
                    items: njm_wsoProvider.yesnoMap.keys.toList(),
                    onChanged: (value) {
                      njm_wsoProvider.setIsflowmeteryesno(value);
                    },
                  ),


                  if (flowMeterInstalled == "Yes") ...[
                    _input(
                      "Flow Meter Reading (Start)",
                      controller: flowStartController,
                      keyboard: TextInputType.number,
                      onChanged: (_) => _calculateVolume(),
                    ),

                    _input(
                      "Flow Meter Reading (Stop)",
                      controller: njm_wsoProvider.flowStopController,
                      keyboard: TextInputType.number,
                      onChanged: (_) => _calculateVolume(),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 22),

              _submitButton(njm_wsoProvider,asset),




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

  // ================= SUBMIT =================
  Widget _submitButton(NjmWsoProvider provider,SjlAllAsset asset) {
    return InkWell(
      onTap: () {
        provider.insertOrUpdateGroundWaterPumpHouse(
            id: 0,
            stateId: _localStorage.getInt(AppConstants.prefStateId)!,
            rpwssId: 4514525,
            outVillageId: 0,
            assetId: asset.assetId!,
            assetTypeId: 0,
            assetType: "Source",
            habitationId: provider.habitationId!,
            typeOfPumpId: provider.selectedtypesofpumpId! ,
            feedingTypeId: 0,
            dischargeOfPump: double.parse(provider.dischargeController.text),
            dischargeUnit: 'm3/h',
            headPump:  double.parse(provider.headController.text),
            headPumpUnit: 'm',
            isFlowMeterInstalled: provider.Isflow_meter_yesnoId! ,
            createdBy: session.userId,
            createdIp: DeviceInfoUtil.deviceId

        );
      },
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF1E88E5),
              Color(0xFF1565C0),
            ],
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: const Center(
          child: Text(
            "Save Pump Entry",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}