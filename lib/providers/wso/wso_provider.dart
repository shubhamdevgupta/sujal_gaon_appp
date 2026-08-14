import 'package:flutter/cupertino.dart';

import '../../models/njm_ftk_response/WsoSSGRegistrationResponse.dart';
import '../../models/njm_ftk_response/habitation_assest.dart';
import '../../models/vwsc/njm_ftk_memberList.dart';
import '../../models/wso/wso_get_ground_water.dart';
import '../../models/wso/wso_groundwatersource_response.dart';
import '../../repository/njm_wso/njm_wso_repo.dart';
import '../../utils/global_exception_handler.dart';

class WsoProvider extends ChangeNotifier {
  final WsoRepo _njmWsoRepo;

  WsoProvider(this._njmWsoRepo);

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<NjmFtKMember> njmFtkUsers = [];

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController appointAuthConroller = TextEditingController();

  Wsossgregistrationresponse? _wsossgregistrationresponse;

  Wsossgregistrationresponse? get wsoSsgRegistrationResponse =>
      _wsossgregistrationresponse;

  String? errorMsg = '';

  DateTime? _fromDate;
  DateTime? _toDate;

  DateTime? get fromDate => _fromDate;

  DateTime? get toDate => _toDate;

  String? pumpType;
  String? locationType;
  String? flowMeterInstalled;

  int? selectedHabitationId;

  int? get habitationId => selectedHabitationId;

  final dischargeController = TextEditingController();
  final headController = TextEditingController();
  final pumpStartTimeController = TextEditingController();
  final pumpStopTimeController = TextEditingController();

  final flowMeterStartController = TextEditingController();
  final flowMeterStopController = TextEditingController();

  final pumpingHoursController = TextEditingController();
  final volumeController = TextEditingController();

  String? _Isflow_meter_yesno;
  String? get Isflow_meter_yesno => _Isflow_meter_yesno;

  int? _Isflow_meter_yesnoId;
  int? get Isflow_meter_yesnoId => _Isflow_meter_yesnoId;

  String get pumpStartApi =>
      _pumpStart?.toIso8601String() ?? "";
  String get pumpStopApi =>
      _pumpStop?.toIso8601String() ?? "";


  GroundWaterPumpResponse? _groundWaterResponse;

  GroundWaterPumpResponse? get groundWaterResponse => _groundWaterResponse;

  HabitationAssetResponse? _habitationAssetResponse;

  HabitationAssetResponse? get habitationAssetResponse =>
      _habitationAssetResponse;

  GwTubeBoreWellPumpHouseResponse? _gwTubeBoreWellPumpHouseList;

  GwTubeBoreWellPumpHouseResponse? get gwTubeBoreWellPumpHouseList =>
      _gwTubeBoreWellPumpHouseList;

  int? _selectedtypesofpumpId;

  int? get selectedtypesofpumpId => _selectedtypesofpumpId;


  DateTime? _pumpStart;
  DateTime? _pumpStop;

  /// SET START TIME
  void setPumpStart(DateTime dateTime) {

    _pumpStart = dateTime;

    pumpStartTimeController.text = _formatDateTime(dateTime);

    _calculatePumpHours();

    notifyListeners();
  }

  /// SET STOP TIME
  void setPumpStop(DateTime dateTime) {

    _pumpStop = dateTime;

    pumpStopTimeController.text = _formatDateTime(dateTime);

    _calculatePumpHours();

    notifyListeners();
  }

  /// CALCULATE HOURS
  void _calculatePumpHours() {

    if (_pumpStart != null && _pumpStop != null) {

      final diff = _pumpStop!.difference(_pumpStart!);

      final hours = diff.inMinutes / 60;

      pumpingHoursController.text = hours.toStringAsFixed(2);

    }

  }

  /// FORMAT DATE
  String _formatDateTime(DateTime dt) {

    return "${dt.day.toString().padLeft(2,'0')}-"
        "${dt.month.toString().padLeft(2,'0')}-"
        "${dt.year} "
        "${dt.hour.toString().padLeft(2,'0')}:"
        "${dt.minute.toString().padLeft(2,'0')}";

  }

  final Map<String, int> typesofpumpMap = {
    "Submersible": 1,
    "Horizontal": 2,
    "Vertical": 3,
  };

  String? get selectedPumpLabel {
    if (_selectedtypesofpumpId == null) return null;

    return typesofpumpMap.entries
        .firstWhere((e) => e.value == _selectedtypesofpumpId)
        .key;
  }

  void setSelectedtypesofpump(String? label) {
    if (label != null) {
      _selectedtypesofpumpId = typesofpumpMap[label];
    } else {
      _selectedtypesofpumpId = null;
    }
    notifyListeners();
  }
 int? _selectedlocationId;
  int? get selectedlocationId => _selectedlocationId;

  final Map<String, int> typesoflocationMap = {
    "Feeding": 1,
    "Direct distribution through pumping": 2,
  };

  String? get selectedlocationlabel {
    if (_selectedlocationId == null) return null;

    return typesoflocationMap.entries
        .firstWhere((e) => e.value == _selectedlocationId)
        .key;
  }

  void setSelectedtypesoflocation(String? label) {
    if (label != null) {
      _selectedlocationId = typesoflocationMap[label];
    } else {
      _selectedlocationId = null;
    }
    notifyListeners();
  }

  final Map<String, int> yesnoMap = {"yes": 1, "no": 0};

  void setIsFlowMeterYesNo(String? label) {
    _Isflow_meter_yesno = label;

    if (label != null) {
      _Isflow_meter_yesnoId = yesnoMap[label];
    } else {
      _Isflow_meter_yesnoId = null;
    }

    notifyListeners();
  }

  void setFromDate(DateTime date) {
    _fromDate = date;
    notifyListeners();
  }

  void setToDate(DateTime date) {
    _toDate = date;
    notifyListeners();
  }

  Future<void> insertOrUpdateGroundWaterPumpHouse({
    required int id,
    required int stateId,
    required int rpwssId,
    required int outVillageId,
    required int assetId,
    required int assetTypeId,
    required String assetType,
    required int habitationId,
    required int typeOfPumpId,
    required int feedingTypeId,
    required double dischargeOfPump,
    required String dischargeUnit,
    required double headPump,
    required String headPumpUnit,
    required int isFlowMeterInstalled,
    required int createdBy,
    required String createdIp,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _njmWsoRepo.insertOrUpdateGroundWaterPumpHouse(
        id,
        stateId,
        rpwssId,
        outVillageId,
        assetId,
        assetTypeId,
        assetType,
        habitationId,
        typeOfPumpId,
        feedingTypeId,
        dischargeOfPump,
        dischargeUnit,
        headPump,
        headPumpUnit,
        isFlowMeterInstalled,
        createdBy,
        createdIp,
      );

      if (response.status == true) {
        _groundWaterResponse = response;
      } else {
        _groundWaterResponse = null;
        debugPrint("Insert/Update Failed: ${response.message}");
      }
    } catch (e) {
      debugPrint("Insert/Update Error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> insertPumpRegularEntry({
    required int id,
    required int stateId,
    required int tubeBoreWellId,
    required int isManualStartStop,
    required String pumpStartDateTime,
    required String pumpStopDateTime,
    required String flowMeterReading,
    required double flowMeterStart,
    required double flowMeterStop,
    required int createdBy,
    required String createdIp,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _njmWsoRepo.insertPumpRegularEntry(
        id,
        stateId,
        tubeBoreWellId,
        isManualStartStop,
        pumpStartDateTime,
        pumpStopDateTime,
        flowMeterReading,
        flowMeterStart,
        flowMeterStop,
        createdBy,
        createdIp,
      );

      if (response.status == true) {
        _groundWaterResponse = response;
      } else {
        _groundWaterResponse = null;
        errorMsg = _groundWaterResponse!.message;
        debugPrint("Insert/Update Failed: ${response.message}");
      }
    } catch (e) {
      debugPrint("Insert/Update Error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchHabitationAssetsID(
    int stateID,
    int habitationId,
    int userId,
  ) async {
    _isLoading = true;
    notifyListeners();

    try {
      var rawResponse = await _njmWsoRepo.fetchHabitationAssetsID(
        stateID,
        habitationId,
        userId,
      );
      if (rawResponse.status == true) {
        _habitationAssetResponse = rawResponse;
      } else {
        errorMsg = rawResponse.msg;
      }
    } catch (e, stackTrace) {
      GlobalExceptionHandler.handleException(
        e as Exception,
        stackTrace: stackTrace,
      );
      _habitationAssetResponse = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getGroundWaterSourceList(
    int userId,
    int stateId,
    int rpwssId,
    int habitationId,
    int assetId,
    int assetTypeId,
  ) async {
    _isLoading = true;
    notifyListeners();

    try {
      var rawResponse = await _njmWsoRepo.getGroundWaterSourceList(
        userId,
        stateId,
        rpwssId,
        habitationId,
        assetId,
        assetTypeId,
      );
      if (rawResponse.status == true) {
        _gwTubeBoreWellPumpHouseList = rawResponse;
      } else {
        errorMsg = rawResponse.msg;
      }
    } catch (e, stackTrace) {
      GlobalExceptionHandler.handleException(
        e as Exception,
        stackTrace: stackTrace,
      );
      _gwTubeBoreWellPumpHouseList = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setSelectedHabitationId(int? value) {
    selectedHabitationId = value;
    notifyListeners();
  }
}
