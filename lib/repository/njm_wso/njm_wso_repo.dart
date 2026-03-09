import 'dart:convert';
import '../../models/njm_ftk_response/NjmFtkRegistrationResponse.dart';
import '../../models/njm_wso/njm_wso_groundwatersource_response.dart';
import '../../models/vwsc/njm_ftk_memberList.dart';
import '../../service/base_api_service.dart';
import '../../utils/global_exception_handler.dart';

class NjmWsoRepo {
  final BaseApiService _apiService = BaseApiService();


  Future<GroundWaterPumpResponse> insertOrUpdateGroundWaterPumpHouse(
      int id,
      int stateId,
      int rpwssId,
      int outVillageId,
      int assetId,
      int assetTypeId,
      String assetType,
      int habitationId,
      int typeOfPumpId,
      int feedingTypeId,
      double dischargeOfPump,
      String dischargeUnit,
      double headPump,
      String headPumpUnit,
      int isFlowMeterInstalled,
      int createdBy,
      String createdIp,
      ) async {
    try {
      final response = await _apiService.post(
        'SJL/SJL_Insert_update_invnt_ground_water_tube_bore_well_Pumphouse',
        body: jsonEncode({
          "Id": id,
          "StateId": stateId,
          "RPWSSId": rpwssId,
          "OutVillageId": outVillageId,
          "AssetId": assetId,
          "AssetTypeId": assetTypeId,
          "AssetType": assetType,
          "HabitationId": habitationId,
          "TypeofPumpId": typeOfPumpId,
          "FeedingTypeId": feedingTypeId,
          "DischargeofPump": dischargeOfPump,
          "DischargeUnit": dischargeUnit,
          "HeadPump": headPump,
          "HeadPumpUnit": headPumpUnit,
          "IsFlowMeterInstalled": isFlowMeterInstalled,
          "CreatedBy": createdBy,
          "CreatedIp": createdIp,
        }),
      );

      return GroundWaterPumpResponse.fromJson(response);
    } catch (e, stackTrace) {
      GlobalExceptionHandler.handleException(
        e as Exception,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
  //using this api we can get list of  njm/wso and ftk/sgh both type of user

}
