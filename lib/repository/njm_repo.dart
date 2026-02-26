import 'dart:convert';

import '../models/njm_wso/NJMRegistrationResponse.dart';
import '../models/njm_wso/NJMUserList.dart';
import '../service/base_api_service.dart';
import '../utils/global_exception_handler.dart';

class NjmRepo {
  final BaseApiService _apiService = BaseApiService();

  Future<Njmregistrationresponse> registerNJMWSO(
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
        'PanchayatLogin',
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
        apiType: ApiType.egramswaraj,
      );

      return Njmregistrationresponse.fromJson(response);
    } catch (e, stackTrace) {
      GlobalExceptionHandler.handleException(
        e as Exception,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<Njmuserlist> fetchNJMUser(
    int userTypeId,
    int userId,
    int stateId,
  ) async {
    try {
      final response = await _apiService.get(
        '/apimaster/getblock?UsertypeId=$userTypeId&UserId=$userId&StateId=$stateId',
      );

      return Njmuserlist.fromJson(response);
    } catch (e, stackTrace) {
      GlobalExceptionHandler.handleException(
        e as Exception,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}
