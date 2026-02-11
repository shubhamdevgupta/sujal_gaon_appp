import 'package:flutter/material.dart';

import '../models/block_model.dart';
import '../models/district_model.dart';
import '../models/gp_model.dart';
import '../models/habitaion_model.dart';
import '../models/state_model.dart';
import '../models/village_mdoel.dart';
import '../repository/master_repositary.dart';
import '../utils/custom screen/global_exception_handler.dart';

class MasterProvider extends ChangeNotifier {

  final MasterRepositary _masterRepositary = MasterRepositary();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  int? baseStatus;
  String? errorMsg;


  List<Statelist> states = []; // ✅ State list

  String? selectedStateId; // ✅ Selected State ID

  void setSelectedState(String? value) {
    selectedStateId = value;
    notifyListeners();
  }

  List<DistrictList> districts = []; // ✅ State list

  String? selectedDistrictId; // ✅ Selected State ID

  void setSelectedDistrict(String? value) {
    selectedDistrictId = value;
    notifyListeners();
  }


  List<Blocklist> blocks = [];
  String? selectedBlockId;



  void setSelectedBlock(String? value) {
    selectedBlockId = value;
    notifyListeners();
  }


  List<Grampanchayatlist> gramPanchayats = [];

  String? selectedGpId;

  void setSelectedGp(String? value) {
    selectedGpId = value;
    notifyListeners();
  }

  List<Villagelist> villages = [];
  String? selectedVillageId;

  void setSelectedVillage(String? value) {
    selectedVillageId = value;
    notifyListeners();
  }


  List<HabitationList> habitations = [];
  String? selectedHabitationId;

  void setSelectedHabitation(String? value) {
    selectedHabitationId = value;
    notifyListeners();
  }



  Future<void> fetchState() async {
    _isLoading = true;
    notifyListeners();

    try {
      final rawState = await _masterRepositary.fetchState();

      baseStatus = rawState.status;

      if (rawState.status == 1) {

        states = rawState.result; // ✅ FIX HERE
        print("--------> States $states");

        debugPrint("---------States Loaded: ${states.length}");

      } else {
        errorMsg = rawState.message;
      }

    } catch (e) {

      debugPrint('Error in fetching state: $e');
      errorMsg = "Failed to load state.";

    } finally {

      _isLoading = false;
      notifyListeners();
    }
  }



  Future<void> fetchDistrict(String stateId) async {

    setSelectedState(stateId);

    // ✅ Reset previous data
    selectedDistrictId = null;
    districts = [];

    _isLoading = true;
    notifyListeners();

    try {

      final rawDistrict =
      await _masterRepositary.fetchDistrict(stateId);

      baseStatus = rawDistrict.status;

      if (rawDistrict.status == 1) {

        districts = rawDistrict.result;

        debugPrint("--------> Districts: $districts");
        debugPrint("---------District Loaded: ${districts.length}");

      } else {

        errorMsg = rawDistrict.message;
      }

    } catch (e) {

      debugPrint('Error in fetching District: $e');
      errorMsg = "Failed to load District.";

    } finally {

      _isLoading = false;
      notifyListeners();
    }
  }


  Future<void> fetchBlock(String districtId) async {

    selectedBlockId = null;
    blocks = [];

    _isLoading = true;
    notifyListeners();

    try {

      final rawBlock =
      await _masterRepositary.fetchBlock(districtId);

      baseStatus = rawBlock.status;

      if (rawBlock.status == 1) {

        blocks = rawBlock.result;

        debugPrint("Blocks Loaded: ${blocks.length}");

      } else {
        errorMsg = rawBlock.message;
      }

    } catch (e) {

      debugPrint("Error fetching block: $e");

    } finally {

      _isLoading = false;
      notifyListeners();
    }
  }


  Future<void> fetchGramPanchayat(String blockId) async {

    // Reset old
    gramPanchayats = [];
    selectedGpId = null;

    _isLoading = true;
    notifyListeners();

    try {

      final rawGp =
      await _masterRepositary.fetchGramPanchayat(blockId);

      baseStatus = rawGp.status;

      if (rawGp.status == 1) {

        gramPanchayats = rawGp.result;

        debugPrint("GP Loaded: ${gramPanchayats.length}");

      } else {
        errorMsg = rawGp.message;
      }

    } catch (e) {

      debugPrint("GP Error: $e");

    } finally {

      _isLoading = false;
      notifyListeners();
    }
  }


  Future<void> fetchVillage(String panchayatId) async {

    // Reset old
    villages = [];
    selectedVillageId = null;

    _isLoading = true;
    notifyListeners();

    try {

      final rawVillage =
      await _masterRepositary.fetchVillage(panchayatId);

      baseStatus = rawVillage.status;

      if (rawVillage.status == 1) {

        villages = rawVillage.result;

        debugPrint("Villages Loaded: ${villages.length}");

      } else {
        errorMsg = rawVillage.message;
      }

    } catch (e) {

      debugPrint("Village Error: $e");

    } finally {

      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchHabitation(String villageId) async {

    // Reset old
    habitations = [];
    selectedHabitationId = null;

    _isLoading = true;
    notifyListeners();

    try {

      final rawHab =
      await _masterRepositary.fetchHabitation(villageId);

      baseStatus = rawHab.status;

      if (rawHab.status == 1) {

        habitations = rawHab.result;

        debugPrint("Habitations Loaded: ${habitations.length}");

      } else {
        errorMsg = rawHab.message;
      }

    } catch (e) {

      debugPrint("Habitation Error: $e");

    } finally {

      _isLoading = false;
      notifyListeners();
    }
  }





}
