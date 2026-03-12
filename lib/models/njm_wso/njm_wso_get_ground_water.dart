class GwTubeBoreWellPumpHouseResponse {
  final int userId;
  final bool status;
  final String msg;
  final String token;
  final List<GwTubeBoreWellPumpHouse> pumpHouseList;

  GwTubeBoreWellPumpHouseResponse({
    required this.userId,
    required this.status,
    required this.msg,
    required this.token,
    required this.pumpHouseList,
  });

  factory GwTubeBoreWellPumpHouseResponse.fromJson(Map<String, dynamic> json) {
    return GwTubeBoreWellPumpHouseResponse(
      userId: json['UserId'] ?? 0,
      status: json['Status'] ?? false,
      msg: json['msg'] ?? '',
      token: json['Token'] ?? '',
      pumpHouseList: (json['GW_Tube_BoreWell_Pumphouse_list'] as List?)
          ?.map((e) => GwTubeBoreWellPumpHouse.fromJson(e))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "UserId": userId,
      "Status": status,
      "msg": msg,
      "Token": token,
      "GW_Tube_BoreWell_Pumphouse_list":
      pumpHouseList.map((e) => e.toJson()).toList(),
    };
  }
}
class GwTubeBoreWellPumpHouse {
  final int tubeBoreWellId;
  final int stateId;
  final int rpwssId;
  final int outVillageId;
  final int assetId;
  final int assetTypeId;
  final String assetType;
  final int habitationId;
  final int typeOfPumpId;
  final String typeOfPump;
  final int feedingTypeId;
  final double dischargeOfPump;
  final String dischargeUnit;
  final double headPump;
  final String headPumpUnit;
  final int isFlowMeterInstalled;

  GwTubeBoreWellPumpHouse({
    required this.tubeBoreWellId,
    required this.stateId,
    required this.rpwssId,
    required this.outVillageId,
    required this.assetId,
    required this.assetTypeId,
    required this.assetType,
    required this.habitationId,
    required this.typeOfPumpId,
    required this.typeOfPump,
    required this.feedingTypeId,
    required this.dischargeOfPump,
    required this.dischargeUnit,
    required this.headPump,
    required this.headPumpUnit,
    required this.isFlowMeterInstalled,
  });

  factory GwTubeBoreWellPumpHouse.fromJson(Map<String, dynamic> json) {
    return GwTubeBoreWellPumpHouse(
      tubeBoreWellId: json['TubeBoreWellId'] ?? 0,
      stateId: json['StateId'] ?? 0,
      rpwssId: json['RPWSSId'] ?? 0,
      outVillageId: json['OutVillageId'] ?? 0,
      assetId: json['AssetId'] ?? 0,
      assetTypeId: json['AssetTypeId'] ?? 0,
      assetType: json['AssetType'] ?? '',
      habitationId: json['HabitationId'] ?? 0,
      typeOfPumpId: json['TypeofPumpId'] ?? 0,
      typeOfPump: json['TypeofPump'] ?? '',
      feedingTypeId: json['FeedingTypeId'] ?? 0,
      dischargeOfPump: (json['DischargeofPump'] ?? 0).toDouble(),
      dischargeUnit: json['DischargeUnit'] ?? '',
      headPump: (json['HeadPump'] ?? 0).toDouble(),
      headPumpUnit: json['HeadPumpUnit'] ?? '',
      isFlowMeterInstalled: json['IsFlowMeterInstalled'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "TubeBoreWellId": tubeBoreWellId,
      "StateId": stateId,
      "RPWSSId": rpwssId,
      "OutVillageId": outVillageId,
      "AssetId": assetId,
      "AssetTypeId": assetTypeId,
      "AssetType": assetType,
      "HabitationId": habitationId,
      "TypeofPumpId": typeOfPumpId,
      "TypeofPump": typeOfPump,
      "FeedingTypeId": feedingTypeId,
      "DischargeofPump": dischargeOfPump,
      "DischargeUnit": dischargeUnit,
      "HeadPump": headPump,
      "HeadPumpUnit": headPumpUnit,
      "IsFlowMeterInstalled": isFlowMeterInstalled,
    };
  }
}