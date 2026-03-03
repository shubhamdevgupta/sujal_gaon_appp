import 'package:flutter/cupertino.dart';
import 'package:jal_sanchalan/repository/njm_wso/njm_wso_repo.dart';
import 'package:jal_sanchalan/repository/vwsc/vwsc_repo.dart';

import '../../models/ftk_sgh/NjmFtkRegistrationResponse.dart';
import '../../models/njm_wso/njm_wso_groundwatersource_response.dart';
import '../../models/vwsc/njm_ftk_memberList.dart';
import '../../utils/device_utils.dart';

class NjmWsoProvider extends ChangeNotifier {
  final NjmWsoRepo _njmWsoRepo = NjmWsoRepo();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<NjmFtKMember> njmFtkUsers = [];

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController appointAuthConroller = TextEditingController();

  Njmftkregistrationresponse? _njmftkregistrationresponse;
  Njmftkregistrationresponse? get njmFtkRegistrationResponse => _njmftkregistrationresponse;



  String? pumpType;
  String? locationType;
  String? flowMeterInstalled;

  final dischargeController = TextEditingController();
  final headController = TextEditingController();
  final startTimeController = TextEditingController();
  final stopTimeController = TextEditingController();

  final flowStartController = TextEditingController();
  final flowStopController = TextEditingController();

  final pumpingHoursController = TextEditingController();
  final volumeController = TextEditingController();


  final Map<String, int> typesofpumpMap = {
    "Submersible": 1,
    "Horizontal": 2,
    "vertical": 3,
  };

  String? _selectedtypesofpump;
  int? _selectedtypesofpumpId;

  String? get selectedtypesofpump => _selectedtypesofpump;
  int? get selectedtypesofpumpId => _selectedtypesofpumpId;

  void setSelectedtypesofpump(String? label) {
    _selectedtypesofpump = label;

    if (label != null) {
      _selectedtypesofpumpId = typesofpumpMap[label];
    } else {
      _selectedtypesofpumpId = null;
    }

    notifyListeners();
  }


  final Map<String, int> yesnoMap = {
    "yes": 1,
    "no": 2,
  };

  String? _Isflow_meter_yesno;
  int? _Isflow_meter_yesnoId;

  String? get Isflow_meter_yesno => _Isflow_meter_yesno;
  int? get Isflow_meter_yesnoId => _Isflow_meter_yesnoId;

  void setIsflowmeteryesno(String? label) {
    _Isflow_meter_yesno = label;

    if (label != null) {
      _Isflow_meter_yesnoId = yesnoMap[label];
    } else {
      _Isflow_meter_yesnoId = null;
    }

    notifyListeners();
  }

  DateTime? _fromDate;
  DateTime? _toDate;

  DateTime? get fromDate => _fromDate;
  DateTime? get toDate => _toDate;

  void setFromDate(DateTime date) {
    _fromDate = date;
    notifyListeners();
  }

  void setToDate(DateTime date) {
    _toDate = date;
    notifyListeners();
  }
  String? _deviceId;
  String? get deviceId => _deviceId;





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

  GroundWaterPumpResponse? _groundWaterResponse;
  GroundWaterPumpResponse? get groundWaterResponse => _groundWaterResponse;
  Future<void> fetchDeviceId() async {
    _deviceId = await DeviceInfoUtil.getUniqueDeviceId();
    debugPrint('Device ID: $_deviceId');
    notifyListeners();
  }

  void clearData() {
    _isLoading = false;
    _njmftkregistrationresponse = null;
    _fromDate=null;
    _toDate=null;

    nameController.clear();
    phoneController.clear();
    emailController.clear();
    addressController.clear();
    notifyListeners();
  }

}
