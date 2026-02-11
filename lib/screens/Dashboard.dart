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
      /*appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Jal Seva',
          style: TextStyle(
            color: Color(0xFF1A237E),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),*/
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
        verificationSlider(masterProvider.directoryList),

        ],
        ),
      ),
    );
  }

  // ---------------- Widgets ----------------

  Widget verificationCard({
    required String habitationId,
    required String rpwssId,
    required String sujlamId,
    required VoidCallback onProceed,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),

        // 🔷 Gradient Border Effect
        border: Border.all(
          color: const Color(0xFF1976D2),
          width: 1.5,
        ),

        gradient: const LinearGradient(
          colors: [
            Color(0xFFF9FCFF),
            Colors.white,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.12),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          /// HEADER
          Row(
            children: const [
              Icon(Icons.verified, color: Color(0xFF1976D2)),
              SizedBox(width: 8),
              Text(
                "Verification Summary",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1976D2),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
          const Divider(),

          /// DATA ROWS
          _infoRow("Habitation ID", habitationId),
          _infoRow("RPWSS ID", rpwssId),
          _infoRow("Sujlam Gaon", sujlamId),

          const SizedBox(height: 20),

          /// BUTTON
          Align(
            alignment: Alignment.centerRight,

            child: ElevatedButton(
              onPressed: onProceed,

              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1976D2),
                padding: const EdgeInsets.symmetric(
                  horizontal: 26,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),

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
    );
  }

  /// Small reusable row
  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),

      child: Row(
        children: [

          SizedBox(
            width: 120,
            child: Text(
              "$label :",
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          Expanded(
            child: Text(
              value.isEmpty ? "--" : value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  int currentIndex = 0;

  Widget verificationSlider(List<dynamic> dataList) {
    return Column(
      children: [

        /// SLIDER
        SizedBox(
          height: 260,

          child: PageView.builder(
            itemCount: dataList.length,

            onPageChanged: (index) {
              currentIndex = index;
            },

            itemBuilder: (context, index) {

              final item = list[index];

              return verificationCard(

                habitationId: item.habitationName ?? "--",

                rpwssId: item.temporaryId ?? "--",

                sujlamId: item.serviceAreaId ?? "--",

                onProceed: () {
                  debugPrint("Proceed → ${item.temporaryId}");
                },
              );
            },
          ),
        ),

        const SizedBox(height: 6),

        /// DOT INDICATOR
        Row(
          mainAxisAlignment: MainAxisAlignment.center,

          children: List.generate(
            dataList.length,
                (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),

              margin: const EdgeInsets.symmetric(horizontal: 4),

              height: 8,
              width: currentIndex == index ? 22 : 8,

              decoration: BoxDecoration(
                color: currentIndex == index
                    ? const Color(0xFF1976D2)
                    : Colors.grey.shade400,

                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
      ],
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
