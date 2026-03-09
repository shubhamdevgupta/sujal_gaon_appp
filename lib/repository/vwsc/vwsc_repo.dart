import 'dart:convert';
import '../../models/njm_ftk_response/NjmFtkRegistrationResponse.dart';
import '../../models/vwsc/njm_ftk_memberList.dart';
import '../../service/base_api_service.dart';
import '../../utils/global_exception_handler.dart';

class VwscRepo {
  final BaseApiService _apiService = BaseApiService();


  Future<Njmftkregistrationresponse> registerNjmFTK(
      int regId,
      int userTypeId,
      int stateId,
      int districtId,
      int blockId,
      int panchayatId,
      int villageId,
      String firstName,
      String lastName,
      int mobileNumber,
      String designation,
      String email,
      String gender,
      String address,
      int levelTrainingId,
      String ipAddress,
      int createdBy,
      String validatedFrom,
      String validatedTo,
      String habitationIds,
      ) async {
    try {
      final response = await _apiService.post(
        'SJLInsertRegistration',
        body: jsonEncode({
          "RegId": regId,
          "UserTypeId": userTypeId,
          "StateId": stateId,
          "Districtid": districtId,
          "BlockId": blockId,
          "PanchayatId": panchayatId,
          "VillageId": villageId,
          "FirstName": firstName,
          "LastName": lastName,
          "MobileNumber": mobileNumber,
          "Designation": designation,
          "Email": email,
          "Gender": gender,
          "Address": address,
          "LeveltariningId": levelTrainingId,
          "IPAddress": ipAddress,
          "CreatedBy": createdBy,
          "Validated_from": validatedFrom,
          "Validated_to": validatedTo,
          "HabitationIds": habitationIds,
        }),
      );

      return Njmftkregistrationresponse.fromJson(response);
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
      int regId,
      ) async {
    try {
      final response = await _apiService.get(
        'SJL_GetRegistration_list?UsertypeId=$userTypeId&UserId=$userId&StateId=$stateId&RedId=$regId',
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
