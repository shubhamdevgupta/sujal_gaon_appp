import 'package:flutter/material.dart';

import '../models/master_directory/block_model.dart';
import '../models/master_directory/dictorey_model.dart';
import '../models/master_directory/district_model.dart';
import '../models/master_directory/gp_model.dart';
import '../models/master_directory/habitaion_model.dart';
import '../models/master_directory/state_model.dart';
import '../models/master_directory/village_mdoel.dart';
import '../repository/master_repository.dart';

class MasterProvider extends ChangeNotifier {

  final MasterRepository _masterRepository ;
  MasterProvider(this._masterRepository);

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




  List<HabitationList> habitations = [];
  String? selectedHabitationId;

  void setSelectedHabitation(String? value) {
    selectedHabitationId = value;
    notifyListeners();
  }

  List<String> selectedHabitationIds = [];

  void toggleHabitation(String id) {
    if (selectedHabitationIds.contains(id)) {
      selectedHabitationIds.remove(id);
    } else {
      selectedHabitationIds.add(id);
    }
    notifyListeners();
  }
  String get selectedHabitationIdsAsString {
    return selectedHabitationIds.join(',');
  }


  List<RpwssResultList> directoryList = [];

  String? tempId;
  String? serviceAreaId;

  Future<void> fetchState() async {
    _isLoading = true;
    notifyListeners();

    try {
      final rawState = await _masterRepository.fetchState();

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
      await _masterRepository.fetchDistrict(stateId);

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
      await _masterRepository.fetchBlock(districtId);

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
      await _masterRepository.fetchGramPanchayat(blockId);

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
      await _masterRepository.fetchVillage(panchayatId);

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


  void setSelectedVillage(String? value) {
    selectedVillageId = value;
    selectedHabitationIds.clear();
    habitations.clear();
    notifyListeners();
  }



  Future<void> fetchHabitation(String villageId) async {

    // Reset old
    habitations = [];
    selectedHabitationId = null;

    _isLoading = true;
    notifyListeners();

    try {

      final rawHab =
      await _masterRepository.fetchHabitation(villageId);

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


  Future<void> fetchDirectory() async {

    // Make sure all IDs exist
    if (selectedStateId == null ||
        selectedDistrictId == null
        ) {

      debugPrint("❌ Directory: Missing selection");
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {

      final rawDir =
      await _masterRepository.fetchDirectory(
        selectedStateId!,
        selectedDistrictId!
     /*   selectedBlockId!,
        selectedGpId!,
        selectedVillageId!,*/

      );

      baseStatus = rawDir.status;

      if (rawDir.status == 1 && rawDir.result.isNotEmpty) {

        directoryList = rawDir.result;

        // Usually only 1 record comes
        final data = directoryList.first;

        tempId = data.temporaryId;
        serviceAreaId = data.serviceAreaId;

        debugPrint("Directory Loaded");
        debugPrint("TempId: $tempId");
        debugPrint("ServiceAreaId: $serviceAreaId");

      } else {

        errorMsg = rawDir.message;
        directoryList = [];

        tempId = null;
        serviceAreaId = null;
      }

    } catch (e) {

      debugPrint("Directory Error: $e");
      errorMsg = "Failed to load directory data";

    } finally {

      _isLoading = false;
      notifyListeners();
    }
  }






}
