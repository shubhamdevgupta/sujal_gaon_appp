import 'package:flutter/material.dart';




class EscalationAlertsScreen extends StatefulWidget {
  const EscalationAlertsScreen({super.key});

  @override
  State<EscalationAlertsScreen> createState() => _EscalationAlertsScreen();
}

class _EscalationAlertsScreen extends State<EscalationAlertsScreen> {


  @override
  Widget build(BuildContext context) {

    // ======== MOCK SYSTEM FLAGS ========
    // Replace with real backend logic

    bool noSupplyToday = true;
    bool noSupplyMoreThan24 = false;
    bool repeatedNonSupply = true;
    bool disinfectionNonCompliance = false;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F6FF),

      appBar: AppBar(
        backgroundColor: const Color(0xFF1976D2),
        title: const Text(
          "Escalation & Alerts",
          style: TextStyle(color: Colors.white),
        ),
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
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [

              _systemAlertCard(
                title: "No Supply Today",
                description: "Auto alert – Push to VWSC",
                isActive: noSupplyToday,
                severity: AlertSeverity.medium,
              ),

              const SizedBox(height: 16),

              _systemAlertCard(
                title: "No Supply > 24 Hours",
                description: "Auto escalation – Push to GP",
                isActive: noSupplyMoreThan24,
                severity: AlertSeverity.high,
              ),

              const SizedBox(height: 16),

              _systemAlertCard(
                title: "Repeated Non-Supply Pattern",
                description: "Pattern alert – Push to DWSM",
                isActive: repeatedNonSupply,
                severity: AlertSeverity.critical,
              ),

              const SizedBox(height: 16),

              _systemAlertCard(
                title: "Disinfection Non-Compliance",
                description: "Auto alert – Push to VWSC / GP",
                isActive: disinfectionNonCompliance,
                severity: AlertSeverity.medium,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _systemAlertCard({
    required String title,
    required String description,
    required bool isActive,
    required AlertSeverity severity,
  }) {

    Color borderColor;
    Color bgColor;
    IconData icon;

    switch (severity) {
      case AlertSeverity.medium:
        borderColor = Colors.orange;
        bgColor = Colors.orange.shade50;
        icon = Icons.warning_amber_rounded;
        break;

      case AlertSeverity.high:
        borderColor = Colors.red;
        bgColor = Colors.red.shade50;
        icon = Icons.error_outline;
        break;

      case AlertSeverity.critical:
        borderColor = Colors.deepPurple;
        bgColor = Colors.deepPurple.shade50;
        icon = Icons.priority_high;
        break;
    }

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isActive ? bgColor : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isActive
              ? borderColor
              : Colors.blueGrey.shade200,
          width: 1.3,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.08),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [

          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: isActive
                  ? borderColor.withOpacity(0.15)
                  : Colors.blueGrey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: isActive
                  ? borderColor
                  : Colors.grey,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: isActive
                        ? borderColor
                        : Colors.black87,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),

          Icon(
            isActive
                ? Icons.notifications_active
                : Icons.check_circle_outline,
            color: isActive
                ? borderColor
                : Colors.green,
          ),
        ],
      ),
    );
  }
}

enum AlertSeverity {
  medium,
  high,
  critical,
}