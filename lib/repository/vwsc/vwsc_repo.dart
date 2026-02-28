import 'dart:convert';
import '../../models/ftk_sgh/FtkRegistrationResponse.dart';
import '../../models/vwsc/njm_ftk_memberList.dart';
import '../../service/base_api_service.dart';
import '../../utils/global_exception_handler.dart';

class VwscRepo {
  final BaseApiService _apiService = BaseApiService();

  //using this api we can register njm/wso and ftk/sgh both type of user
  Future<Ftkregistrationresponse> registerNjmFTK(
      String username,
      int userId,
      String firstName,
      String lastName,
      int mobileNumber,
      String address,
      String designation,
      String email,
      String stateId,
      String districtId,
      String blockId,
      String panchayatId,
      String villageId,
      String levelTraining,
      String ipAddress,
      ) async {
    try {
      final response = await _apiService.post(
        'SJLInsertRegistration',
        body: jsonEncode({
          'UserTypeId': username,
          'UserId': userId,
          'FirstName': firstName,
          'LastName': lastName,
          'MobileNumber': mobileNumber,
          'Address': address,
          'Designation': designation,
          'Email': email,
          'StateId': stateId,
          'Districtid': districtId,
          'BlockId': blockId,
          'PanchayatId': panchayatId,
          'VillageId': villageId,
          'LevelTraining': levelTraining,
          'IPAddress': ipAddress,
        }),
      );

      return Ftkregistrationresponse.fromJson(response);
    } catch (e, stackTrace) {
      GlobalExceptionHandler.handleException(
        e as Exception,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
  //using this api we can get list of  njm/wso and ftk/sgh both type of user
  Future<NjmFtkMemberlist> fetchNjmFtkUser(
      int userTypeId,
      int userId,
      int stateId,
      ) async {
    try {
      final response = await _apiService.get(
        '/SJL_GetRegistration_list?UsertypeId=$userTypeId&UserId=$userId&StateId=$stateId',
      );

      return NjmFtkMemberlist.fromJson(response);
    } catch (e, stackTrace) {
      GlobalExceptionHandler.handleException(
        e as Exception,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}
