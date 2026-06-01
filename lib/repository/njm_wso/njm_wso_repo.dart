import 'dart:convert';

import '../../models/njm_ftk_response/habitation_assest.dart';
import '../../models/wso/wso_get_ground_water.dart';
import '../../models/wso/wso_groundwatersource_response.dart';
import '../../service/base_api_service.dart';
import '../../utils/global_exception_handler.dart';

class WsoRepo {
  final BaseApiService _apiService;

  WsoRepo(this._apiService);

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
  ) async
  {
    try {
      final response = await _apiService.post(
        'SJL_Insert_update_invnt_ground_water_tube_bore_well_Pumphouse',
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

  Future<GroundWaterPumpResponse> insertPumpRegularEntry(
    int id,
    int stateId,
    int tubeBoreWellId,
    int isManualStartStop,
    String pumpStartDateTime,
    String pumpStopDateTime,
    String flowMeterReading,
    double flowMeterStart,
    double flowMeterStop,
    int createdBy,
    String createdIp,
  ) async
  {
    try {
      final response = await _apiService.post(
        'SJL_Insert_update_invnt_ground_water_tube_bore_well_Pumphouse_regular_entry',
        body: jsonEncode({
          "Id": id,
          "TubeBoreWellId":tubeBoreWellId,
          "StateId": stateId,
          "IsManualStartStopEntry":isManualStartStop,
          "PumpStartDateTime":pumpStartDateTime,
          "PumpStopDateTime":pumpStartDateTime,
          "FlowMeterReadingUnit":flowMeterReading,
          "FlowMeterStart":flowMeterStart,
          "FlowMeterStop":flowMeterStop,
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

  Future<HabitationAssetResponse> fetchHabitationAssetsID(
    int stateID,
    int habitationId,
    int userId,
  ) async {
    try {
      final response = await _apiService.get(
        'SJL_get_habitation_asset_detail?stateid=$stateID&habitationid=$habitationId&userid=$userId',
      );

      return HabitationAssetResponse.fromJson(response);
    } catch (e, stackTrace) {
      GlobalExceptionHandler.handleException(
        e as Exception,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<GwTubeBoreWellPumpHouseResponse> getGroundWaterSourceList(
    int userId,
    int stateId,
    int rpwssId,
    int habitationId,
    int assetId,
    int assetTypeId
  ) async {
    try {
      final response = await _apiService.get(
        'SJL_Get_invnt_ground_water_tube_bore_well_Pumphouse?UserId=$userId&StateId=$stateId&RPWSSId=$rpwssId&HabitationId=$habitationId&AssetId=$assetId&AssetTypeId=$assetTypeId',
      );

      return GwTubeBoreWellPumpHouseResponse.fromJson(response);
    } catch (e, stackTrace) {
      GlobalExceptionHandler.handleException(
        e as Exception,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}
