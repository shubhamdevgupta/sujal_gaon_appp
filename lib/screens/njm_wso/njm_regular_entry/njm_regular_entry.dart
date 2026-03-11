import 'package:flutter/material.dart';
import 'package:jal_sanchalan/models/njm_ftk_response/habitation_assest.dart';
import 'package:jal_sanchalan/providers/njm_wso/njm_wso_provider.dart';
import 'package:provider/provider.dart';

import '../../../../utils/app_constants.dart';
import '../../../service/local_storage_service.dart';
import '../../../utils/auth/user_session_manager.dart';

class NjmRegularEntry extends StatefulWidget {
  const NjmRegularEntry({super.key});

  @override
  State<NjmRegularEntry> createState() => _NjmRegularEntry();
}

class _NjmRegularEntry extends State<NjmRegularEntry> {
  final session = UserSessionManager();
  final LocalStorageService _localStorage = LocalStorageService();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = context.read<NjmWsoProvider>();

      await provider.fetchHabitationAssetsID(31, 1030748, session.userId);
      // await provider.fetchHabitationAssetsID(_localStorage.getInt(AppConstants.prefStateId)!, provider.habitationId!, session.userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF4FF),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.blue.shade700.withOpacity(0.9),
        title: const Text("NJM", style: TextStyle(color: Colors.white)),
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
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Consumer<NjmWsoProvider>(
                  builder: (context, provider, child) {
                    final serviceArea = provider
                        .habitationAssetResponse?.sjlHabitationServiceArea?.habitationServicearea;
                    if (serviceArea == null) {
                      return const SizedBox();
                    }
                    return Column(
                      children: [
                        buildHabitationCard(serviceArea),
                        SizedBox(height: 5),
                        buildAssetsCard(provider),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
Widget buildHabitationCard(String serviceArea) {
  const Color habitationThemeColor = Color(0xFF1565C0); // Deep JJM Blue

  return Container(
    margin: const EdgeInsets.symmetric( vertical: 5),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(24),
      gradient: LinearGradient(
        colors: [const Color(0xFFE3F2FD), Colors.white],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      border: Border.all(color: Colors.blue.shade100.withOpacity(0.5)),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      child: Row(
        children: [
          /// ICON WITH SOFT GLOW (Matches Asset Card Icon Style)
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: habitationThemeColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
                Icons.location_on_rounded,
                color: habitationThemeColor,
                size: 26
            ),
          ),
          const SizedBox(width: 16),

          /// TEXT CONTENT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Habitation Service Area",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                    color: Colors.blue, // Label style
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  serviceArea,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                    color: Color(0xFF263238), // Deep charcoal for readability
                  ),
                  // Prevents overflow if the name is very long
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          /// DECORATIVE ELEMENT (Optional: Small checkmark or map icon)
          Icon(
            Icons.map_outlined,
            color: habitationThemeColor.withOpacity(0.2),
            size: 20,
          ),
        ],
      ),
    ),
  );
}
Widget buildAssetsCard(NjmWsoProvider provider) {
  return Container(
    margin: const EdgeInsets.symmetric( vertical: 5),
    padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(24),
      gradient: LinearGradient(
        colors: [const Color(0xFFE3F2FD), Colors.white],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      border: Border.all(color: Colors.blue.shade100.withOpacity(0.5)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.waves_rounded, size: 20, color: Color(0xFF1976D2)),
            const SizedBox(width: 8),
            const Text(
              "Assets Involved",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1565C0),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        buildAssetList(provider),
      ],
    ),
  );
}
final List<Map<String, dynamic>> dummyPumpInventory = [
  {
    "assetId": 310161109,
  },
  {
    "assetId": 310161110,
  },
];
Widget buildAssetList(NjmWsoProvider provider) {

  /// Dummy Pump Inventory Data
  final List<Map<String, dynamic>> dummyPumpInventory = [
    {"assetId": 310161109},
    {"assetId": 310161110},
  ];

  return ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: provider.habitationAssetResponse!.sjlAllAssetList!.length,
    itemBuilder: (context, index) {

      SjlAllAsset asset = provider.habitationAssetResponse!.sjlAllAssetList![index];

      /// Source UI
      return buildNormalAssetCard(
        context,
        asset,
        dummyPumpInventory,
        index, // important for expansion state
      );
    },
  );
}

Widget buildSourceAssetCard(BuildContext context, SjlAllAsset asset) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.blue.shade50.withOpacity(.4),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// TITLE
          Row(
            children: [
              Icon(
                _getAssetIcon(asset.assetTypeId),
                color: Colors.blue.shade700,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                asset.assetType ?? "",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          /// MAIN TESTING
          _sourceActionTile(
            title: "Pump entry",
            icon: Icons.science_outlined,
            color: Colors.blue.shade100,
            onTap: () {
              Navigator.pushNamed(
                context,
                AppConstants.navigateToGroundwatersourcetubeMain,
                arguments: asset,
              );
            },
          ),

          const SizedBox(height: 8),

          /// REGULAR TESTING
          _sourceActionTile(
            title: "Pump activity",
            icon: Icons.check_circle_outline,
            color: Colors.green.shade100,
            onTap: () {
              Navigator.pushNamed(
                context,
                AppConstants.navigateToGroundwatersourcetubeRegular,
              );
            },
          ),
        ],
      ),
    ),
  );
}

Widget _sourceActionTile({
  required String title,
  required IconData icon,
  required Color color,
  required VoidCallback onTap,
}) {
  return InkWell(
    borderRadius: BorderRadius.circular(10),
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.black87),

          const SizedBox(width: 10),

          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            ),
          ),

          /// RIGHT ARROW
          Icon(Icons.chevron_right, color: Colors.grey.shade600),
        ],
      ),
    ),
  );
}
bool isPumpExpanded = false;
Map<int, bool> expandedAssets = {};

Widget buildNormalAssetCard(
    BuildContext context,
    SjlAllAsset asset,
    List dummyPumpInventory,
    int index,
    ) {
  // Constant Blue theme as requested
  const Color themeColor = Color(0xFF1976D2);

  return StatefulBuilder(
    builder: (BuildContext context, StateSetter setState) {
      bool isExpanded = expandedAssets[index] ?? false;
      String typeName = asset.assetType ?? "N/A";
      // Convert assetTypeId to String for your switch-case logic
      String assetTypeId = asset.assetTypeId?.toString() ?? "";

      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isExpanded ? themeColor.withOpacity(0.3) : Colors.grey.shade200),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: const Offset(0, 2)),
          ],
        ),
        child: Column(
          children: [
            /// --- HEADER ---
            InkWell(
              onTap: () => setState(() => expandedAssets[index] = !isExpanded),
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    CircleAvatar(radius: 18, backgroundColor: themeColor.withOpacity(0.1), child: Icon(_getAssetIcon(asset.assetTypeId), color: themeColor, size: 18)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(typeName, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF1A1C1E))),
                          Text("${dummyPumpInventory.length} Active Units", style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
                        ],
                      ),
                    ),
                    Icon(isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, color: themeColor, size: 20),
                  ],
                ),
              ),
            ),

            /// --- SUB-ASSET CARDS ---
            if (isExpanded)
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                child: Column(
                  children: dummyPumpInventory.map((pump) {
                    return Container(
                      margin: const EdgeInsets.only(top: 8),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.blue.shade100),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Asset ID: ${pump["assetId"]}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(Icons.water_drop, size: 12, color: themeColor),
                                    const SizedBox(width: 4),
                                    const Text("Capacity: 2.5 MLD", style: TextStyle(fontSize: 11, color: Colors.grey)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () => _navigateToAssetForm(context, assetTypeId),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: themeColor,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                            ),
                            child: const Text("Add", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
          ],
        ),
      );
    },
  );
}
void _navigateToAssetForm(BuildContext context, String assetTypeId) {
  switch (assetTypeId) {
    case "0":
      Navigator.pushNamed(context, AppConstants.navigateToGroundwatersourcetubeMain);
      break;
    case "10":
      Navigator.pushNamed(context, AppConstants.navigateToGroundwatersourcetubeMain);
      break;
    case "2":
      Navigator.pushNamed(context, AppConstants.navigateToPumpsForm);
      break;
    case "8":
      Navigator.pushNamed(context, AppConstants.navigateToOHSRForm);
      break;
    case "11":
      Navigator.pushNamed(context, AppConstants.navigateToDisinfectionForm);
      break;
    case "5":
      Navigator.pushNamed(context, AppConstants.navigateToDisinfectionForm);
      break;
    default:
      break;
  }
}

/// ================= CARD WIDGET =================
IconData _getAssetIcon(int? type) {
  switch (type) {
    case 0:
      return Icons.water;
    case 2:
      return Icons.settings_input_component;
    case 8:
      return Icons.storage;
    case 11:
      return Icons.science;
    case 4:
      return Icons.pending_actions_sharp;
    case 5:
      return Icons.water_drop_sharp;
    default:
      return Icons.device_unknown;
  }
}
