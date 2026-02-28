class NjmFtkMemberlist {
  final int? userId;
  final bool status;
  final String? message;
  final String? token;
  final List<NjmFtKMember> registrationList;

  NjmFtkMemberlist({
    this.userId,
    required this.status,
    this.message,
    this.token,
    required this.registrationList,
  });

  factory NjmFtkMemberlist.fromJson(Map<String, dynamic> json) {
    return NjmFtkMemberlist(
      userId: json['UserId'],
      status: json['Status'] ?? false,
      message: json['msg'],
      token: json['Token'],
      registrationList: json['SJLRegistrationlist'] != null
          ? List<NjmFtKMember>.from(
          json['SJLRegistrationlist']
              .map((x) => NjmFtKMember.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'UserId': userId,
      'Status': status,
      'msg': message,
      'Token': token,
      'SJLRegistrationlist':
      registrationList.map((e) => e.toJson()).toList(),
    };
  }
}

/// 🔹 Individual Registration Model
class NjmFtKMember {
  final int? regId;
  final int? userTypeId;
  final String? firstName;
  final String? lastName;
  final String? mobileNumber; // keep as String
  final String? designation;
  final String? email;
  final int? stateId;
  final int? districtId;
  final int? blockId;
  final int? panchayatId;
  final int? villageId;
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

  NjmFtKMember({
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
  });

  factory NjmFtKMember.fromJson(Map<String, dynamic> json) {
    return NjmFtKMember(
      regId: json['RegId'],
      userTypeId: json['UserTypeId'],
      firstName: json['FirstName'],
      lastName: json['LastName'],
      mobileNumber: json['MobileNumber']?.toString(),
      designation: json['Designation'],
      email: json['Email'],
      stateId: json['StateId'],
      districtId: json['Districtid'],
      blockId: json['BlockId'],
      panchayatId: json['PanchayatId'],
      villageId: json['VillageId'],
      address: json['Address'],
      gender: json['Gender'],
      stateName: json['StateName'],
      districtName: json['DistrictName'],
      blockName: json['BlockName'],
      panchayatName: json['PanchayatName'],
      villageName: json['VillageName'],
      levelTraining: json['Leveltarining'],
      levelTrainingId: json['LeveltariningId']?.toString(),
      isEnable: json['IsEnable'],
      validatedFrom: json['Validated_from'],
      validatedTo: json['Validated_to'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
    };
  }
}