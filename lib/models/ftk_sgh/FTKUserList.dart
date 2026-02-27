class Ftkuserlist {
  final int? userId;
  final bool status;
  final String? message;
  final String? token;
  final List<SJLRegistration> registrationList;

  Ftkuserlist({
    this.userId,
    required this.status,
    this.message,
    this.token,
    required this.registrationList,
  });

  factory Ftkuserlist.fromJson(Map<String, dynamic> json) {
    return Ftkuserlist(
      userId: json['UserId'],
      status: json['Status'] ?? false,
      message: json['msg'],
      token: json['Token'],
      registrationList: json['SJLRegistrationlist'] != null
          ? List<SJLRegistration>.from(
              json['SJLRegistrationlist'].map(
                (x) => SJLRegistration.fromJson(x),
              ),
            )
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'UserId': userId,
      'Status': status,
      'msg': message,
      'Token': token,
      'SJLRegistrationlist': registrationList.map((e) => e.toJson()).toList(),
    };
  }
}

/// 🔹 Individual Registration Model
class SJLRegistration {
  final int? registrationId;
  final int? userId;
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
  final String? address;
  final String? stateName;
  final String? districtName;
  final String? blockName;
  final String? panchayatName;
  final String? villageName;
  final String? levelTraining;

  SJLRegistration({
    this.registrationId,
    this.userId,
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
    this.stateName,
    this.districtName,
    this.blockName,
    this.panchayatName,
    this.villageName,
    this.levelTraining,
  });

  factory SJLRegistration.fromJson(Map<String, dynamic> json) {
    return SJLRegistration(
      registrationId: json['RegistrationId'],
      userId: json['UserId'],
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
      address: json['Address'],
      stateName: json['StateName'],
      districtName: json['DistrictName'],
      blockName: json['BlockName'],
      panchayatName: json['PanchayatName'],
      villageName: json['VillageName'],
      levelTraining: json['LevelTraining'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'RegistrationId': registrationId,
      'UserId': userId,
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
      'StateName': stateName,
      'DistrictName': districtName,
      'BlockName': blockName,
      'PanchayatName': panchayatName,
      'VillageName': villageName,
      'LevelTraining': levelTraining,
    };
  }
}
