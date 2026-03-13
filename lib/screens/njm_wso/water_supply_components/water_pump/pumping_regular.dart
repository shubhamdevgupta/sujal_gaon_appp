import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../providers/njm_wso/njm_wso_provider.dart';
import '../../../../service/local_storage_service.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_dialog.dart';
import '../../../../utils/auth/user_session_manager.dart';
import '../../../../utils/device_utils.dart';
import '../../../../utils/enum/app_dialog.dart';
import '../../../../utils/toast_helper.dart';

class PumpingRegular extends StatefulWidget {
  const PumpingRegular({super.key});

  @override
  State<PumpingRegular> createState() => _PumpingRegular();
}

class _PumpingRegular extends State<PumpingRegular> {

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
    TimeOfDay? picked =
    await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (picked != null) {
      controller.text = picked.format(context);
      _calculatePumpingHours();
    }
  }

  void _calculatePumpingHours() {
    if (startTimeController.text.isEmpty ||
        stopTimeController.text.isEmpty) return;

    final start = TimeOfDay(
        hour: int.parse(startTimeController.text.split(":")[0]),
        minute: int.parse(startTimeController.text.split(":")[1].split(" ")[0]));

    final stop = TimeOfDay(
        hour: int.parse(stopTimeController.text.split(":")[0]),
        minute: int.parse(stopTimeController.text.split(":")[1].split(" ")[0]));

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

      double startReading =
          double.tryParse(flowStartController.text) ?? 0;

      double stopReading =
          double.tryParse(flowStopController.text) ?? 0;

      // Case 1: Start - Stop (as per your document)
      volume = startReading - stopReading;

      // Prevent negative result
      if (volume < 0) {
        volume = 0;
      }

    } else {

      double discharge =
          double.tryParse(dischargeController.text) ?? 0;

      double pumpingHours =
          double.tryParse(pumpingHoursController.text) ?? 0;

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
    final njm_wsoProvider = context.watch<NjmWsoProvider>();
    final tubeBoreWellId = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      backgroundColor: const Color(0xFFF2F6FF),

      appBar: AppBar(
        backgroundColor: const Color(0xFF1976D2),
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

              // ================= TIME DETAILS =================

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
              const SizedBox(height: 20),

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
              SizedBox(
                height: 10,
              ),

              _submitButton(tubeBoreWellId),

              const SizedBox(height: 30),
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
      String label, {
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
      onTap: onTap,
      inputFormatters: formatters,

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
          createdBy: session.userId,
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
              AppConstants.navigateToNjmRegularEntry,
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
      items: items,
      onChanged: onChanged,
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
}