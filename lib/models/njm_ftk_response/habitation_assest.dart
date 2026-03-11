class HabitationAssetResponse {
  final int? userId;
  final bool? status;
  final String? msg;
  final String? token;
  final SjlHabitationServiceArea? sjlHabitationServiceArea;
  final List<SjlFlowPath>? sjlFlowPathList;
  final List<SjlAllAsset>? sjlAllAssetList;

  HabitationAssetResponse({
    this.userId,
    this.status,
    this.msg,
    this.token,
    this.sjlHabitationServiceArea,
    this.sjlFlowPathList,
    this.sjlAllAssetList,
  });

  factory HabitationAssetResponse.fromJson(Map<String, dynamic> json) {
    return HabitationAssetResponse(
      userId: json['UserId'],
      status: json['Status'],
      msg: json['msg'],
      token: json['Token'],
      sjlHabitationServiceArea: json['SJLhabitation_servicearea'] != null
          ? SjlHabitationServiceArea.fromJson(json['SJLhabitation_servicearea'])
          : null,
      sjlFlowPathList: json['SJLFlowPathlist'] != null
          ? (json['SJLFlowPathlist'] as List)
                .map((e) => SjlFlowPath.fromJson(e))
                .toList()
          : [],
      sjlAllAssetList: json['SJLAll_AssetList'] != null
          ? (json['SJLAll_AssetList'] as List)
                .map((e) => SjlAllAsset.fromJson(e))
                .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "UserId": userId,
      "Status": status,
      "msg": msg,
      "Token": token,
      "SJLhabitation_servicearea": sjlHabitationServiceArea?.toJson(),
      "SJLFlowPathlist": sjlFlowPathList?.map((e) => e.toJson()).toList(),
      "SJLAll_AssetList": sjlAllAssetList?.map((e) => e.toJson()).toList(),
    };
  }
}

class SjlHabitationServiceArea {
  final String? habitationServicearea;

  SjlHabitationServiceArea({this.habitationServicearea});

  factory SjlHabitationServiceArea.fromJson(Map<String, dynamic> json) {
    return SjlHabitationServiceArea(
      habitationServicearea: json['habitation_servicearea'],
    );
  }

  Map<String, dynamic> toJson() {
    return {"habitation_servicearea": habitationServicearea};
  }
}

class SjlFlowPath {
  final String? flowPath;

  SjlFlowPath({this.flowPath});

  factory SjlFlowPath.fromJson(Map<String, dynamic> json) {
    return SjlFlowPath(flowPath: json['FlowPath']);
  }

  Map<String, dynamic> toJson() {
    return {"FlowPath": flowPath};
  }
}

class SjlAllAsset {
  final int? stateId;
  final int? rpwssId;
  final int? outVillageId;
  final int? assetId;
  final String? assetType;
  final int? assetTypeId;
  final String? assetDetails;

  SjlAllAsset({
    this.stateId,
    this.rpwssId,
    this.outVillageId,
    this.assetId,
    this.assetType,
    this.assetTypeId,
    this.assetDetails,
  });

  factory SjlAllAsset.fromJson(Map<String, dynamic> json) {
    return SjlAllAsset(
      stateId: json['stateid'],
      rpwssId: json['RPWSSId'],
      outVillageId: json['OutVillageId'],
      assetId: json['assetid'],
      assetType: json['assettype'],
      assetTypeId: json['assettypeid'],
      assetDetails: json['assetdetails'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "stateid": stateId,
      "RPWSSId": rpwssId,
      "OutVillageId": outVillageId,
      "assetid": assetId,
      "assettype": assetType,
      "assettypeid": assetTypeId,
      "assetdetails": assetDetails,
    };
  }
}
