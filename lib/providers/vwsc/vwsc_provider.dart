import 'package:flutter/cupertino.dart';

import '../../models/njm_ftk_response/WsoSSGRegistrationResponse.dart';
import '../../models/vwsc/njm_ftk_memberList.dart';
import '../../repository/vwsc/vwsc_repo.dart';

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

  final Map<String, int> educationalMap = {
    "Below 8th": 1,
    "8th": 2,
    "10th": 3,
    "12th": 4,
    "Graduate and above": 5,
  };

  String? _selectedEducationLabel;
  String? get selectedEducational => _selectedEducationLabel;

  int? _selectedEducationalId;
  int? get selectedEducationId => _selectedEducationalId;

  void setEducational(String? label) {
    _selectedEducationLabel = label;

    if (label != null) {
      _selectedEducationalId = educationalMap[label];
    } else {
      _selectedEducationalId = null;
    }
    notifyListeners();
  }


  final Map<String, int> skillingMap = {
    "Plumbing": 1,
    "Electrical": 2,
    "Multi-Tasking": 3,
    "Any other skill,Please enter": 4,
  };

  String? _selectedSkillingLabel;
  String? get selectedSkilling => _selectedSkillingLabel;

  int? _selectedSkillingId;
  int? get selectedSkillId => _selectedSkillingId;


  void setSkill(String? label) {
    _selectedSkillingLabel = label;

    if (label != null) {
      _selectedSkillingId = skillingMap[label];
    } else {
      _selectedSkillingId = null;
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
