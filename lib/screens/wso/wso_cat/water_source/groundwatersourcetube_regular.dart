import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jal_sanchalan/utils/device_utils.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/njm_wso/njm_wso_provider.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_dialog.dart';
import '../../../../utils/enum/app_dialog.dart';
import '../../../../utils/toast_helper.dart';

class GroundwatersourcetubeRegular extends StatefulWidget {
  const GroundwatersourcetubeRegular({super.key});

  @override
  State<GroundwatersourcetubeRegular> createState() =>
      _GroundwatersourcetubeRegular();
}

class _GroundwatersourcetubeRegular
    extends State<GroundwatersourcetubeRegular> {
  @override
  Widget build(BuildContext context) {
    final njm_wsoProvider = context.watch<NjmWsoProvider>();
    final tubeBoreWellId = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),

      appBar: AppBar(
        backgroundColor: const Color(0xFF1976D2),
        title: const Text(
          "Ground Water Source",
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
              // ================= OPERATION =================
              _sectionCard(
                icon: Icons.access_time,
                title: "Pump Operation",
                children: [
                  _input(
                    "Pump Start Time",
                    controller: njm_wsoProvider.pumpStartTimeController,
                    readOnly: true,
                    onTap: () async {
                      final dateTime = await pickDateTime(context);

                      if (dateTime != null) {
                        njm_wsoProvider.setPumpStart(dateTime);
                      }
                    },
                  ),

                  _input(
                    "Pump Stop Time",
                    controller: njm_wsoProvider.pumpStopTimeController,
                    readOnly: true,
                    onTap: () async {
                      final dateTime = await pickDateTime(context);

                      if (dateTime != null) {
                        njm_wsoProvider.setPumpStop(dateTime);
                      }
                    },
                  ),
                  _input(
                    "Pumping Hours (Auto)",
                    controller: njm_wsoProvider.pumpingHoursController,
                    readOnly: true,
                  ),
                ],
              ),

              const SizedBox(height: 22),

              // ================= FLOW METER =================
              _sectionCard(
                icon: Icons.speed,
                title: "Flow Meter Details",
                children: [
                  if (true) ...[
                    _input(
                      "Flow Meter Reading (Start)",
                      controller: njm_wsoProvider.flowMeterStartController,
                      keyboard: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                    ),
                    _input(
                      "Flow Meter Reading (Stop)",
                      controller: njm_wsoProvider.flowMeterStopController,
                      keyboard: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 22),

              // ================= VOLUME =================
          /*    _sectionCard(
                icon: Icons.analytics,
                title: "Auto Calculated Volume",
                children: [
                  _input(
                    "Volume Supplied (KL / m3)",
                    controller: njm_wsoProvider.volumeController,
                    readOnly: true,
                  ),
                ],
              ),*/

              _submitButton(tubeBoreWellId),

            ],
          ),
        ),
      ),
    );
  }

  Future<DateTime?> pickDateTime(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (date == null) return null;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time == null) return null;

    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
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
    VoidCallback? onTap,
    Function(String)? onChanged,
  }) {
    List<TextInputFormatter>? formatters;

    /// Restrict input based on keyboard type
    if (keyboard == TextInputType.number) {
      formatters = [FilteringTextInputFormatter.digitsOnly];
    }

    /// Allow decimal values
    if (keyboard == const TextInputType.numberWithOptions(decimal: true)) {
      formatters = [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))];
    }

    return TextField(
      controller: controller,
      keyboardType: keyboard,
      maxLines: maxLines,
      maxLength: maxLength,
      readOnly: readOnly,
      onChanged: onChanged,
      onTap: onTap,
      inputFormatters: formatters,

      decoration: InputDecoration(
        hintText: hint,

        prefixIcon: const Icon(Icons.edit, color: Color(0xFF1976D2), size: 18),

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

  Widget _submitButton(int tubeBoreWellId) {
    final provider = context.read<NjmWsoProvider>();
    return InkWell(
      onTap: () async {
        await provider.insertPumpRegularEntry(
          id: 0,
          stateId: 31,
          tubeBoreWellId: tubeBoreWellId,
          isManualStartStop: 0,
          pumpStartDateTime: provider.pumpStartApi,
          pumpStopDateTime: provider.pumpStopApi,
          flowMeterReading: "KL",
          flowMeterStart: double.parse(provider.flowMeterStartController.text),
          flowMeterStop: double.parse(provider.flowMeterStopController.text),
          createdBy: 41494,
          createdIp: DeviceInfoUtil.deviceId,
        );
        await provider.groundWaterResponse!.status == true
            ? AppDialog.show(
                context,
                type: AppDialogType.success,
                title: provider.groundWaterResponse!.id.toString(),
                message: provider.groundWaterResponse?.message,
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppConstants.navigateToWSORegularEntry,
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
}
