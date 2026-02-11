import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/master_provider.dart';
import '../utils/custom screen/custom_dropdown.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String? state, district, block, gp, village;

  final list = ['All', 'Option 1', 'Option 2'];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final masterProvider = Provider.of<MasterProvider>(context, listen: false);
      await masterProvider.fetchState();

    });
  }

  @override
  Widget build(BuildContext context) {
    final masterProvider = context.watch<MasterProvider>();
    return Scaffold(
      backgroundColor: const Color(0xFFF2F6FF),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),

            // 🔹 SIMPLE HEADING (NO APPBAR)
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: const Text(
                'Sujlam Bharat',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A237E),
                ),
              ),
            ),
            /// MULTI-COLOR TOP CARD
            dashboardHeader(0.82),




            const SizedBox(height: 24),

            /// LOCATION FILTER
            const Text(
              'Select Location',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A237E),
              ),
            ),
            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: _card(),
              child: Column(
                children: [

                Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  CustomDropdown(
                    value: masterProvider.selectedStateId, // ✅ Selected ID
                    items: masterProvider.states.map((state) {
                      return DropdownMenuItem<String>(

                        value: state.stateid.toString(), // ✅ State ID

                        child: Text(
                          state.statename,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      );
                    }).toList(),

                    title: "State *",

                    onChanged: (value) {

                      masterProvider.setSelectedState(value); // ✅ Save state

                      if (value != null && value.isNotEmpty) {
                        masterProvider.fetchDistrict(value); // Next API
                      }
                    },

                    appBarTitle: "Select State",
                  ),
                ],
              ),

                SizedBox(
                  height: 15,
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    CustomDropdown(
                      value: masterProvider.selectedDistrictId, // ✅ Selected ID
                      items: masterProvider.districts.map((state) {
                        return DropdownMenuItem<String>(

                          value: state.districtId.toString(), // ✅ State ID

                          child: Text(
                            state.districtname,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        );
                      }).toList(),

                      title: "District *",

                      onChanged: (value) {

                        masterProvider.setSelectedDistrict(value); // ✅ Save state

                        if (value != null && value.isNotEmpty) {
                        masterProvider.fetchBlock(value); // Next API
                      }
                      },

                      appBarTitle: "Select State",
                    ),
                  ],
                ),

                  SizedBox(
                    height: 15,
                  ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    CustomDropdown(
                      value: masterProvider.selectedBlockId, // ✅ Selected ID
                      items: masterProvider.blocks.map((state) {
                        return DropdownMenuItem<String>(

                          value: state.blockid.toString(), // ✅ State ID

                          child: Text(
                            state.blockName,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        );
                      }).toList(),

                      title: "Block *",

                      onChanged: (value) {

                        masterProvider.setSelectedBlock(value); // ✅ Save state

                        if (value != null && value.isNotEmpty) {
                        masterProvider.fetchGramPanchayat(value); // Next API
                      }
                      },

                      appBarTitle: "Select Block",
                    ),
                  ],
                ),

                  SizedBox(height: 15,),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      CustomDropdown(
                        value: masterProvider.selectedGpId, // ✅ Selected ID
                        items: masterProvider.gramPanchayats.map((state) {
                          return DropdownMenuItem<String>(

                            value: state.panchayatId.toString(), // ✅ State ID

                            child: Text(
                              state.grampanchayatName,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          );
                        }).toList(),

                        title: "Gram Panchayat *",

                        onChanged: (value) {

                          masterProvider.setSelectedGp(value); // ✅ Save state

                          if (value != null && value.isNotEmpty) {
                            masterProvider.fetchVillage(value); // Next API
                          }
                        },

                        appBarTitle: "Select Gram Panchayat",
                      ),
                    ],
                  ),

                  SizedBox(height: 15,),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      CustomDropdown(
                        value: masterProvider.selectedVillageId, // ✅ Selected ID
                        items: masterProvider.villages.map((state) {
                          return DropdownMenuItem<String>(

                            value: state.villageId.toString(), // ✅ State ID

                            child: Text(
                              state.villageName,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          );
                        }).toList(),

                        title: "Village *",

                        onChanged: (value) {

                          masterProvider.setSelectedVillage(value); // ✅ Save state

                          if (value != null && value.isNotEmpty) {
                            masterProvider.fetchDirectory();// Next API
                          }
                        },

                        appBarTitle: "Select Village",
                      ),
                    ],
                  ),

                 /* SizedBox(height: 15,),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      CustomDropdown(
                        value: masterProvider.selectedHabitationId, // ✅ Selected ID
                        items: masterProvider.habitations.map((state) {
                          return DropdownMenuItem<String>(

                            value: state.habitationId.toString(), // ✅ State ID

                            child: Text(
                              state.habitationName,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          );
                        }).toList(),

                        title: "Habitaion *",

                        onChanged: (value) {

                          masterProvider.setSelectedHabitation(value); // ✅ Save state

                          if (value != null && value.isNotEmpty) {
                            masterProvider.fetchDirectory(); // Next API
                          }
                        },

                        appBarTitle: "Select Habitaion",
                      ),
                    ],
                  ),*/
                ],
              ),
            ),

            const SizedBox(height: 26),

            /// OVERVIEW
            const Text(
              'Overview',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A237E),
              ),
            ),
            const SizedBox(height: 14),

           /* if (masterProvider.tempId != null)*/
              unifiedInfoCard(masterProvider)
          ],
        ),
      ),
    );
  }

  // ---------------- Widgets ----------------

  Widget unifiedInfoCard(MasterProvider master) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 16),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [
            Color(0xFFF8FBFF),
            Color(0xFFFFFFFF),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.12),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: Column(
        children: [

          // ===== Header Strip =====
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 16,
            ),

            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF1976D2),
                  Color(0xFF42A5F5),
                ],
              ),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),

            child: Row(
              children: const [

                Icon(Icons.verified, color: Colors.white),

                SizedBox(width: 8),

                Text(
                  "Verification Summary",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),

          // ===== Body =====
          Padding(
            padding: const EdgeInsets.all(18),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                _colorInfoLine(
                  "Habitation ID",
                  master.selectedHabitationId,
                  color: Colors.grey.shade800,
                ),

                _colorInfoLine(
                  "RPWSS ID",
                  master.tempId,
                  color: const Color(0xFF1565C0),
                  big: true,
                ),

                _colorInfoLine(
                  "Sujlam Gaon ID",
                  master.serviceAreaId,
                  color: const Color(0xFF00796B),
                ),

                const SizedBox(height: 18),
                const Divider(),

                // ===== Button =====
                Align(
                  alignment: Alignment.centerRight,

                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 4,
                      backgroundColor: const Color(0xFF1976D2),
                    ),

                    onPressed: master.tempId == null
                        ? null
                        : () {
                      debugPrint("Proceed → ${master.tempId}");
                    },

                    child: const Text(
                      "Proceed →",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }



  Widget _colorInfoLine(
      String label,
      String? value, {
        required Color color,
        bool big = false,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            value == null || value.isEmpty ? "--" : value,
            style: TextStyle(
              fontSize: big ? 20 : 15,
              fontWeight: big ? FontWeight.w700 : FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }







  Widget dashboardHeader(double progress) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF2196F3),
            Color(0xFF1565C0),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          // LEFT TEXT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [

                Text(
                  "Welcome 👋",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),

                SizedBox(height: 6),

                Text(
                  "Panchayat User",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 6),

                Text(
                  "Have a productive day!",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),


          // RIGHT PROGRESS

        ],
      ),
    );
  }

  BoxDecoration _card() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 12,
          offset: Offset(0, 6),
        ),
      ],
    );
  }
}
