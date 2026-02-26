import 'dart:convert';

/// 🔹 Root Model
class PanchayatLoginResponse {
  final bool status;
  final String message;
  final PanchayatResult? result;

  PanchayatLoginResponse({
    required this.status,
    required this.message,
    this.result,
  });

  factory PanchayatLoginResponse.fromJson(Map<String, dynamic> json) {
    return PanchayatLoginResponse(
      status: json['Status'] ?? false,
      message: json['Message'] ?? '',
      result: json['Result'] != null
          ? PanchayatResult.fromJson(json['Result'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'Status': status,
    'Message': message,
    'Result': result?.toJson(),
  };
}

/// 🔹 Result Model
class PanchayatResult {
  final LoginResult? loginResult;
  final List<Village> villages;

  PanchayatResult({
    this.loginResult,
    required this.villages,
  });

  factory PanchayatResult.fromJson(Map<String, dynamic> json) {
    return PanchayatResult(
      loginResult: json['LoginResult'] != null
          ? LoginResult.fromJson(json['LoginResult'])
          : null,
      villages: json['JJM_Villages'] != null
          ? List<Village>.from(
          json['JJM_Villages'].map((x) => Village.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
    'LoginResult': loginResult?.toJson(),
    'JJM_Villages':
    villages.map((e) => e.toJson()).toList(),
  };
}

/// 🔹 Login Result Model
class LoginResult {
  final String? stateId;
  final String? stateName;
  final String? districtId;
  final String? districtName;
  final String? blockId;
  final String? blockName;
  final String? panchayatId;
  final String? panchayatName;

  LoginResult({
    this.stateId,
    this.stateName,
    this.districtId,
    this.districtName,
    this.blockId,
    this.blockName,
    this.panchayatId,
    this.panchayatName,
  });

  factory LoginResult.fromJson(Map<String, dynamic> json) {
    return LoginResult(
      stateId: json['StateId'],
      stateName: json['StateName'],
      districtId: json['DistrictId'],
      districtName: json['DistrictName'],
      blockId: json['BlockId'],
      blockName: json['BlockName'],
      panchayatId: json['PanchayatId'],
      panchayatName: json['PanchayatName'],
    );
  }

  Map<String, dynamic> toJson() => {
    'StateId': stateId,
    'StateName': stateName,
    'DistrictId': districtId,
    'DistrictName': districtName,
    'BlockId': blockId,
    'BlockName': blockName,
    'PanchayatId': panchayatId,
    'PanchayatName': panchayatName,
  };
}

/// 🔹 Village Model
class Village {
  final int? villageId;
  final String? villageName;

  Village({
    this.villageId,
    this.villageName,
  });

  factory Village.fromJson(Map<String, dynamic> json) {
    return Village(
      villageId: json['JJM_VillageId'],
      villageName: json['JJM_VillageName'],
    );
  }

  Map<String, dynamic> toJson() => {
    'JJM_VillageId': villageId,
    'JJM_VillageName': villageName,
  };
}