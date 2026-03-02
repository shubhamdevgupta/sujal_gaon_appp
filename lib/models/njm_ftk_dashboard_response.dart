class NjmFtkDashboardResponse {
  final bool? status;
  final String? msg;
  final String? token;

  final int? regId;
  final int? userTypeId;
  final String? firstName;
  final String? lastName;
  final int? mobileNumber;
  final String? designation;
  final String? email;

  final int? stateId;
  final int? districtId;
  final int? blockId;
  final int? panchayatId;
  final int? villageId;

  final int? districtLgdCode;
  final int? blockLgdCode;
  final int? panchayatLgdCode;
  final int? villageLgdCode;

  final String? address;
  final String? gender;

  final String? stateName;
  final String? districtName;
  final String? blockName;
  final String? panchayatName;
  final String? villageName;

  final String? levelTraining;
  final String? levelTrainingId;

  final int? isEnable;

  final String? validatedFrom;
  final String? validatedTo;

  final String? habitationIds;
  final String? habitationNames;

  NjmFtkDashboardResponse({
    this.status,
    this.msg,
    this.token,
    this.regId,
    this.userTypeId,
    this.firstName,
    this.lastName,
    this.mobileNumber,
    this.designation,
    this.email,
    this.stateId,
    this.districtId,
    this.blockId,
    this.panchayatId,
    this.villageId,
    this.districtLgdCode,
    this.blockLgdCode,
    this.panchayatLgdCode,
    this.villageLgdCode,
    this.address,
    this.gender,
    this.stateName,
    this.districtName,
    this.blockName,
    this.panchayatName,
    this.villageName,
    this.levelTraining,
    this.levelTrainingId,
    this.isEnable,
    this.validatedFrom,
    this.validatedTo,
    this.habitationIds,
    this.habitationNames,
  });

  factory NjmFtkDashboardResponse.fromJson(Map<String, dynamic> json) {
    return NjmFtkDashboardResponse(
      status: json['Status'],
      msg: json['msg'],
      token: json['Token'],
      regId: json['RegId'],
      userTypeId: json['UserTypeId'],
      firstName: json['FirstName'],
      lastName: json['LastName'],
      mobileNumber: json['MobileNumber'],
      designation: json['Designation'],
      email: json['Email'],
      stateId: json['StateId'],
      districtId: json['Districtid'],
      blockId: json['BlockId'],
      panchayatId: json['PanchayatId'],
      villageId: json['VillageId'],
      districtLgdCode: json['District_lgdcode'],
      blockLgdCode: json['Block_lgdcode'],
      panchayatLgdCode: json['Panchayat_lgdcode'],
      villageLgdCode: json['Village_lgdcode'],
      address: json['Address'],
      gender: json['Gender'],
      stateName: json['StateName'],
      districtName: json['DistrictName'],
      blockName: json['BlockName'],
      panchayatName: json['PanchayatName'],
      villageName: json['VillageName'],
      levelTraining: json['Leveltarining'],
      levelTrainingId: json['LeveltariningId'],
      isEnable: json['IsEnable'],
      validatedFrom: json['Validated_from'],
      validatedTo: json['Validated_to'],
      habitationIds: json['HabitationIds'],
      habitationNames: json['HabitationNames'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Status': status,
      'msg': msg,
      'Token': token,
      'RegId': regId,
      'UserTypeId': userTypeId,
      'FirstName': firstName,
      'LastName': lastName,
      'MobileNumber': mobileNumber,
      'Designation': designation,
      'Email': email,
      'StateId': stateId,
      'Districtid': districtId,
      'BlockId': blockId,
      'PanchayatId': panchayatId,
      'VillageId': villageId,
      'District_lgdcode': districtLgdCode,
      'Block_lgdcode': blockLgdCode,
      'Panchayat_lgdcode': panchayatLgdCode,
      'Village_lgdcode': villageLgdCode,
      'Address': address,
      'Gender': gender,
      'StateName': stateName,
      'DistrictName': districtName,
      'BlockName': blockName,
      'PanchayatName': panchayatName,
      'VillageName': villageName,
      'Leveltarining': levelTraining,
      'LeveltariningId': levelTrainingId,
      'IsEnable': isEnable,
      'Validated_from': validatedFrom,
      'Validated_to': validatedTo,
      'HabitationIds': habitationIds,
      'HabitationNames': habitationNames,
    };
  }
}