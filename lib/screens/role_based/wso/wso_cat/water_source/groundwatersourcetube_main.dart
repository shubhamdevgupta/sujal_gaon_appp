import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jal_sanchalan/providers/wso/wso_provider.dart';
import 'package:jal_sanchalan/utils/app_constants.dart';
import 'package:jal_sanchalan/utils/device_utils.dart';
import 'package:jal_sanchalan/utils/toast_helper.dart';
import 'package:provider/provider.dart';
import 'dart:math';

import '../../../../../models/njm_ftk_response/habitation_assest.dart';
import '../../../../../service/local_storage_service.dart';
import '../../../../../utils/app_dialog.dart';
import '../../../../../utils/auth/user_session_manager.dart';
import '../../../../../utils/enum/app_dialog.dart';

class GroundwatersourcetubeMain extends StatefulWidget {

  const GroundwatersourcetubeMain({super.key});

  @override
  State<GroundwatersourcetubeMain> createState() => _GroundwatersourcetubeMain();
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


  @override
  void initState() {
      session.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final wsoProvider = context.watch<WsoProvider>();
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
                    value: wsoProvider.selectedPumpLabel,
                    items: wsoProvider.typesofpumpMap.keys.toList(),
                    onChanged: (value) {
                      wsoProvider.setSelectedtypesofpump(value);
                      print("pump id ${wsoProvider.selectedtypesofpumpId}");
                    },
                  ),


                  _dropdown(
                    "Location",
                    value: wsoProvider.selectedlocationlabel,
                    items: wsoProvider.typesoflocationMap.keys.toList(),
                    onChanged: (value) {
                      wsoProvider.setSelectedtypesoflocation(value);
                      print("location id ${wsoProvider.selectedlocationId}");
                    },
                  ),
                  _input(
                    "Discharge of Pump (m3/h)",
                    controller: wsoProvider.dischargeController,
                    keyboard: const TextInputType.numberWithOptions(decimal: true),
                  ),

                  _input(
                    "Head of Pump (m)",
                    controller: wsoProvider.headController,
                    keyboard: const TextInputType.numberWithOptions(decimal: true),
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
                    value: wsoProvider.Isflow_meter_yesno,
                    items: wsoProvider.yesnoMap.keys.toList(),
                    onChanged: (value) {
                      wsoProvider.setIsFlowMeterYesNo(value);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 22),

              _submitButton(wsoProvider,asset),




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
            Colors.white.withValues(alpha:0.97),
            Colors.blue.shade50.withValues(alpha:0.9),
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
      })
  {

    List<TextInputFormatter>? formatters;

    /// Restrict input based on keyboard type
    if (keyboard == TextInputType.number) {
      formatters = [
        FilteringTextInputFormatter.digitsOnly,
      ];
    }

    /// Allow decimal values
    if (keyboard == const TextInputType.numberWithOptions(decimal: true)) {
      formatters = [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
      ];
    }

    return TextField(
      controller: controller,
      keyboardType: keyboard,
      maxLines: maxLines,
      maxLength: maxLength,
      readOnly: readOnly,
      onChanged: onChanged,
      inputFormatters: formatters,

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
 // provider.fetchHabitationAssetsID(31, 1030748, session.userId);
  //TODO  remove the staic values from there
  Widget _submitButton(WsoProvider provider,SjlAllAsset asset) {
    return InkWell(
      onTap: () async
      {
       await provider.insertOrUpdateGroundWaterPumpHouse(
            id: 0,
            stateId: 31,
            rpwssId: asset.rpwssId!,
            outVillageId: asset.outVillageId!,
            assetId: asset.assetId!,
            assetTypeId: asset.assetTypeId!,
            assetType: asset.assetType!,
            habitationId: 1030748,
            typeOfPumpId: provider.selectedtypesofpumpId! ,
            feedingTypeId: provider.selectedlocationId!,
            dischargeOfPump: double.parse(provider.dischargeController.text),
            dischargeUnit: 'm3/h',
            headPump:  double.parse(provider.headController.text),
            headPumpUnit: 'm',
            isFlowMeterInstalled: provider.Isflow_meter_yesnoId! ,
            createdBy: session.userId,
            createdIp: DeviceInfoUtil.deviceId
        );
       await provider.groundWaterResponse!.status ==true ?AppDialog.show(
          context,
          type: AppDialogType.success,
          message: provider.wsoSsgRegistrationResponse?.message,
          onPressed: () {

            Navigator.pushNamed(
              context,
              AppConstants.navigateToWSOCategory,
            );
          },
        ):ToastHelper.showToastMessage(provider.errorMsg!);
        
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