class PanchayatLoginResponse {
  final bool status;
  final int? userId;
  final String? message;
  final String? token;
  final PanchayatResult? result;

  PanchayatLoginResponse({
    required this.status,
    this.userId,
    this.message,
    this.token,
    this.result,
  });

  factory PanchayatLoginResponse.fromJson(Map<String, dynamic> json) {
    return PanchayatLoginResponse(
      status: json['Status'] ?? false,
      userId: json['UserId'],
      message: json['Message'],
      token: json['Token'],
      result: json['Result'] != null
          ? PanchayatResult.fromJson(json['Result'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Status': status,
      'UserId': userId,
      'Message': message,
      'Token': token,
      'Result': result?.toJson(),
    };
  }
}

class PanchayatResult {
  final LoginResult? loginResult;
  final List<JJMVillage> villages;

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
          ? List<JJMVillage>.from(
          json['JJM_Villages']
              .map((x) => JJMVillage.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'LoginResult': loginResult?.toJson(),
      'JJM_Villages': villages.map((e) => e.toJson()).toList(),
    };
  }
}

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

  Map<String, dynamic> toJson() {
    return {
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
}

class JJMVillage {
  final int? villageId;
  final String? villageName;

  JJMVillage({
    this.villageId,
    this.villageName,
  });

  factory JJMVillage.fromJson(Map<String, dynamic> json) {
    return JJMVillage(
      villageId: json['JJM_VillageId'],
      villageName: json['JJM_VillageName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'JJM_VillageId': villageId,
      'JJM_VillageName': villageName,
    };
  }
}