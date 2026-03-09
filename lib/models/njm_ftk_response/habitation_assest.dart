class HabitationAssetResponse {
  int? userId;
  bool? status;
  String? msg;
  String? token;
  ServiceArea? serviceArea;
  List<FlowPath>? flowPathList;
  List<Asset>? assetList;

  HabitationAssetResponse({
    this.userId,
    this.status,
    this.msg,
    this.token,
    this.serviceArea,
    this.flowPathList,
    this.assetList,
  });

  HabitationAssetResponse.fromJson(Map<String, dynamic> json) {
    userId = json['UserId'];
    status = json['Status'];
    msg = json['msg'];
    token = json['Token'];

    serviceArea = json['SJLhabitation_servicearea'] != null
        ? ServiceArea.fromJson(json['SJLhabitation_servicearea'])
        : null;

    if (json['SJLFlowPathlist'] != null) {
      flowPathList = <FlowPath>[];
      json['SJLFlowPathlist'].forEach((v) {
        flowPathList!.add(FlowPath.fromJson(v));
      });
    }

    if (json['SJLAll_AssetList'] != null) {
      assetList = <Asset>[];
      json['SJLAll_AssetList'].forEach((v) {
        assetList!.add(Asset.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['UserId'] = userId;
    data['Status'] = status;
    data['msg'] = msg;
    data['Token'] = token;

    if (serviceArea != null) {
      data['SJLhabitation_servicearea'] = serviceArea!.toJson();
    }

    if (flowPathList != null) {
      data['SJLFlowPathlist'] =
          flowPathList!.map((v) => v.toJson()).toList();
    }

    if (assetList != null) {
      data['SJLAll_AssetList'] =
          assetList!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}
class ServiceArea {
  String? habitationServicearea;

  ServiceArea({this.habitationServicearea});

  ServiceArea.fromJson(Map<String, dynamic> json) {
    habitationServicearea = json['habitation_servicearea'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['habitation_servicearea'] = habitationServicearea;
    return data;
  }
}
class FlowPath {
  String? flowPath;

  FlowPath({this.flowPath});

  FlowPath.fromJson(Map<String, dynamic> json) {
    flowPath = json['FlowPath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['FlowPath'] = flowPath;
    return data;
  }
}
class Asset {
  int? stateId;
  int? assetId;
  String? assetType;
  String? assetTypeId;
  String? assetDetails;

  Asset({
    this.stateId,
    this.assetId,
    this.assetType,
    this.assetTypeId,
    this.assetDetails,
  });

  Asset.fromJson(Map<String, dynamic> json) {
    stateId = json['stateid'];
    assetId = json['assetid'];
    assetType = json['assettype'];
    assetTypeId = json['assettypeid'];
    assetDetails = json['assetdetails'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['stateid'] = stateId;
    data['assetid'] = assetId;
    data['assettype'] = assetType;
    data['assettypeid'] = assetTypeId;
    data['assetdetails'] = assetDetails;

    return data;
  }
}