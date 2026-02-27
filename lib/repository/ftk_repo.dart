import 'dart:convert';
import 'package:jal_sanchalan/models/ftk_sgh/FTKUserList.dart';
import 'package:jal_sanchalan/models/ftk_sgh/FtkRegistrationResponse.dart';

import '../service/base_api_service.dart';
import '../utils/global_exception_handler.dart';

class FtkRepo {
  final BaseApiService _apiService = BaseApiService();

  Future<Ftkregistrationresponse> registerNJMWSO(
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

      return Ftkregistrationresponse.fromJson(response);
    } catch (e, stackTrace) {
      GlobalExceptionHandler.handleException(
        e as Exception,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<Ftkuserlist> fetchNJMUser(
    int userTypeId,
    int userId,
    int stateId,
  ) async {
    try {
      final response = await _apiService.get(
        '/apimaster/getblock?UsertypeId=$userTypeId&UserId=$userId&StateId=$stateId',
      );

      return Ftkuserlist.fromJson(response);
    } catch (e, stackTrace) {
      GlobalExceptionHandler.handleException(
        e as Exception,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}
