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
                'Jal Seva',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A237E),
                ),
              ),
            ),
            /// MULTI-COLOR TOP CARD
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF1565C0), // Blue
                    Color(0xFF00838F), // Teal
                  ],
                ),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Water Coverage',
                          style: TextStyle(color: Colors.white70),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Progress Overview',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Nationwide implementation status',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                  _progressCircle(0.82),
                ],
              ),
            ),




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
                            masterProvider.fetchHabitation(value); // Next API
                          }
                        },

                        appBarTitle: "Select Village",
                      ),
                    ],
                  ),

                  SizedBox(height: 15,),

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

                         /* if (value != null && value.isNotEmpty) {
                            masterProvider.fetchHabitation(value); // Next API
                          }*/
                        },

                        appBarTitle: "Select Habitaion",
                      ),
                    ],
                  ),
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

            Row(
              children: [
                _overviewCard(
                  title: 'Total Villages',
                  value: '586,944',
                  icon: Icons.location_city,
                  colors: const [
                    Color(0xFF5C6BC0),
                    Color(0xFF3949AB),
                  ],
                ),
                const SizedBox(width: 14),
                _overviewCard(
                  title: 'ODF Plus',
                  value: '568,544',
                  icon: Icons.water_drop,
                  colors: const [
                    Color(0xFF26A69A),
                    Color(0xFF00796B),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- Widgets ----------------

  Widget _progressCircle(double progress) {
    return SizedBox(
      width: 72,
      height: 72,
      child: Stack(
        children: [
          CircularProgressIndicator(
            value: progress,
            strokeWidth: 7,
            backgroundColor: Colors.white24,
            valueColor:
            const AlwaysStoppedAnimation<Color>(Colors.amber),
          ),
          Center(
            child: Text(
              '${(progress * 100).toInt()}%',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dropdown(
      IconData icon,
      Color iconColor,
      String label,
      String? value,
      ValueChanged<String?> onChanged,
      ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: iconColor),
          labelText: label,
          filled: true,
          fillColor: const Color(0xFFF1F4FF),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
        items: list
            .map(
              (e) => DropdownMenuItem(
            value: e,
            child: Text(e),
          ),
        )
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _overviewCard({
    required String title,
    required String value,
    required IconData icon,
    required List<Color> colors,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: colors),
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(height: 16),
            Text(
              value,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              title,
              style: const TextStyle(color: Colors.white70),
            ),
          ],
        ),
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
