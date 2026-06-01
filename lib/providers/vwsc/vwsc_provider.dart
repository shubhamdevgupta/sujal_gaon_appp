import 'package:flutter/cupertino.dart';
import 'package:jal_sanchalan/repository/vwsc/vwsc_repo.dart';

import '../../models/njm_ftk_response/WsoSSGRegistrationResponse.dart';
import '../../models/vwsc/njm_ftk_memberList.dart';

class VwscProvider extends ChangeNotifier {
  final VwscRepo _vwscRepo;
  VwscProvider(this._vwscRepo);

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<NjmFtKMember> njmFtkUsers = [];

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController appointAuthConroller = TextEditingController();

  Wsossgregistrationresponse? _wsossgregistrationresponse;

  Wsossgregistrationresponse? get wsoSSGRegistrationResponse =>
      _wsossgregistrationresponse;

  final Map<String, int> levelTranningMap = {
    "Not Trained": 1,
    "Nal Jal Mitra (PMKVY-JJM)": 2,
    "Trained under State Programme": 3,
  };

  String? _selectedLevelLabel;

  String? get selectedLevelLabel => _selectedLevelLabel;

  int? _selectedLevelId;

  int? get selectedLevelId => _selectedLevelId;

  void setSelectedLevel(String? label) {
    _selectedLevelLabel = label;

    if (label != null) {
      _selectedLevelId = levelTranningMap[label];
    } else {
      _selectedLevelId = null;
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

  Future<void> fetchNjmFtkUser(
    int userTypeId,
    int userId,
    int stateId,
    int regId,
  ) async {
    _isLoading = true;
    notifyListeners();

    try {
      final rawResponse = await _vwscRepo.fetchNjmFtkUser(
        userTypeId,
        userId,
        stateId,
        regId,
      );
      if (rawResponse.status == true) {
        njmFtkUsers = rawResponse.registrationList;
      } else {
        njmFtkUsers = [];
      }
    } catch (e) {
      debugPrint("Error fetching block: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> registerNjmFTK({
    required int regId,
    required int userTypeId,
    required int stateId,
    required int districtId,
    required int blockId,
    required int panchayatId,
    required int villageId,
    required String firstName,
    required String lastName,
    required int mobileNumber,
    required String designation,
    required String email,
    required String gender,
    required String address,
    required int levelTrainingId,
    required String ipAddress,
    required int createdBy,
    required String validatedFrom,
    required String validatedTo,
    required String habitationIds,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _vwscRepo.registerNjmFTK(
        regId,
        userTypeId,
        stateId,
        districtId,
        blockId,
        panchayatId,
        villageId,
        firstName,
        lastName,
        mobileNumber,
        designation,
        email,
        gender,
        address,
        levelTrainingId,
        ipAddress,
        createdBy,
        validatedFrom,
        validatedTo,
        habitationIds,
      );

      if (response.status == true) {
        _wsossgregistrationresponse = response;
      } else {
        _wsossgregistrationresponse = null;
        debugPrint("Registration Failed: ${response.message}");
      }
    } catch (e) {
      debugPrint("Registration Error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearData() {
    _isLoading = false;
    _wsossgregistrationresponse = null;
    _fromDate = null;
    _toDate = null;

    nameController.clear();
    phoneController.clear();
    emailController.clear();
    addressController.clear();
    notifyListeners();
  }
}
