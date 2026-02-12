import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/dictorey_model.dart';
import '../models/district_model.dart';
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

  final ScrollController _scrollController = ScrollController();

  double _sliderPosition = 0.0;

  double _sliderHeight = 1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final masterProvider = Provider.of<MasterProvider>(context, listen: false);
      await masterProvider.fetchState();

      _scrollController.addListener(() {

        if (!_scrollController.hasClients) return;

        final maxScroll =
            _scrollController.position.maxScrollExtent;

        if (maxScroll <= 0) return;

        setState(() {
          _sliderPosition =
              (_scrollController.offset / maxScroll)
                  .clamp(0.0, 1.0);
        });
      });
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
                          masterProvider.fetchDirectory();
                      /*  masterProvider.fetchBlock(value);*/ // Next API
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

            vwscPaniSection(), // 👈 HERE


            /// OVERVIEW
            const Text(
              'Overview',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A237E),
              ),
            ),


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
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      padding: const EdgeInsets.all(10),

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

              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [

                  Text(
                    "Proceed",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),

                  SizedBox(width: 6),

                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.white,
                  ),
                ],
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

  Widget verificationSlider(List<RpwssResultList> dataList) {

    return SizedBox(
      height: 400,

      child: Row(
        children: [

          /// LEFT: CARD LIST
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: dataList.length,

              itemBuilder: (context, index) {

                final item = dataList[index];

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

          const SizedBox(width: 10),

          /// RIGHT: MODERN SLIDER
          _buildVerticalSlider(),
        ],
      ),
    );
  }


  Widget _buildVerticalSlider() {

    return LayoutBuilder(
      builder: (context, constraints) {

        _sliderHeight = constraints.maxHeight;

        return GestureDetector(

          onVerticalDragUpdate: (details) {

            double newPos =
                details.localPosition.dy / _sliderHeight;

            newPos = newPos.clamp(0.0, 1.0);

            final maxScroll =
                _scrollController.position.maxScrollExtent;

            _scrollController.jumpTo(newPos * maxScroll);
          },

          child: Container(
            width: 14,

            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(20),
            ),

            child: Stack(
              children: [

                /// SLIDER THUMB
                Positioned(
                  top: _sliderPosition *
                      (_sliderHeight - 40),

                  child: Container(
                    width: 14,
                    height: 40,

                    decoration: BoxDecoration(
                      color: const Color(0xFF1976D2),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }



  Widget vwscPaniSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),

      child: Row(
        children: [

          /// VWSC
          Expanded(
            child: _infoBox(
              title: "VWSC",
              subtitle: "Village Water & Sanitation Committee",
              icon: Icons.groups_rounded,
              color: const Color(0xFF1976D2),
            ),
          ),

          const SizedBox(width: 12),

          /// PANI SAMITI
          Expanded(
            child: _infoBox(
              title: "Pani Samiti",
              subtitle: "Water Management Committee",
              icon: Icons.water_drop_rounded,
              color: const Color(0xFF0288D1),
            ),
          ),
        ],
      ),
    );
  }
  Widget _infoBox({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {

    return Container(
      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(16),

        border: Border.all(
          color: color.withOpacity(0.25),
          width: 1,
        ),

        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.12),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,

        children: [

          /// ICON
          Container(
            padding: const EdgeInsets.all(8),

            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),

            child: Icon(
              icon,
              size: 26,
              color: color,
            ),
          ),

          const SizedBox(height: 10),

          /// TITLE
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),

          const SizedBox(height: 2),

          /// SUBTITLE
          Text(
            subtitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,

            style: TextStyle(
              fontSize: 11.5,
              color: Colors.grey.shade700,
              height: 1.3,
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
