class WsoSSGDashboardResponse {
  bool? status;
  String? msg;
  String? token;
  int? userId;
  int? userTypeId;
  String? firstName;
  String? lastName;
  int? mobileNumber;
  String? designation;
  String? email;
  int? stateId;
  int? districtid;
  int? blockId;
  int? panchayatId;
  int? villageId;
  int? districtLgdcode;
  int? blockLgdcode;
  int? panchayatLgdcode;
  int? villageLgdcode;
  String? address;
  String? gender;
  String? stateName;
  String? districtName;
  String? blockName;
  String? panchayatName;
  String? villageName;
  String? leveltarining;
  String? leveltariningId;
  int? isEnable;
  String? validatedFrom;
  String? validatedTo;

  List<HabitationList>? habitationList;

  WsoSSGDashboardResponse({
    this.status,
    this.msg,
    this.token,
    this.userId,
    this.userTypeId,
    this.firstName,
    this.lastName,
    this.mobileNumber,
    this.designation,
    this.email,
    this.stateId,
    this.districtid,
    this.blockId,
    this.panchayatId,
    this.villageId,
    this.districtLgdcode,
    this.blockLgdcode,
    this.panchayatLgdcode,
    this.villageLgdcode,
    this.address,
    this.gender,
    this.stateName,
    this.districtName,
    this.blockName,
    this.panchayatName,
    this.villageName,
    this.leveltarining,
    this.leveltariningId,
    this.isEnable,
    this.validatedFrom,
    this.validatedTo,
    this.habitationList,
  });

  WsoSSGDashboardResponse.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    msg = json['msg'];
    token = json['Token'];
    userId = json['UserId'];
    userTypeId = json['UserTypeId'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    mobileNumber = json['MobileNumber'];
    designation = json['Designation'];
    email = json['Email'];
    stateId = json['StateId'];
    districtid = json['Districtid'];
    blockId = json['BlockId'];
    panchayatId = json['PanchayatId'];
    villageId = json['VillageId'];
    districtLgdcode = json['District_lgdcode'];
    blockLgdcode = json['Block_lgdcode'];
    panchayatLgdcode = json['Panchayat_lgdcode'];
    villageLgdcode = json['Village_lgdcode'];
    address = json['Address'];
    gender = json['Gender'];
    stateName = json['StateName'];
    districtName = json['DistrictName'];
    blockName = json['BlockName'];
    panchayatName = json['PanchayatName'];
    villageName = json['VillageName'];
    leveltarining = json['Leveltarining'];
    leveltariningId = json['LeveltariningId'];
    isEnable = json['IsEnable'];
    validatedFrom = json['Validated_from'];
    validatedTo = json['Validated_to'];

    if (json['SJL_HabitationNJMP_FTK_list'] != null) {
      habitationList = <HabitationList>[];
      json['SJL_HabitationNJMP_FTK_list'].forEach((v) {
        habitationList!.add(HabitationList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['Status'] = status;
    data['msg'] = msg;
    data['Token'] = token;
    data['UserId'] = userId;
    data['UserTypeId'] = userTypeId;
    data['FirstName'] = firstName;
    data['LastName'] = lastName;
    data['MobileNumber'] = mobileNumber;
    data['Designation'] = designation;
    data['Email'] = email;
    data['StateId'] = stateId;
    data['Districtid'] = districtid;
    data['BlockId'] = blockId;
    data['PanchayatId'] = panchayatId;
    data['VillageId'] = villageId;
    data['District_lgdcode'] = districtLgdcode;
    data['Block_lgdcode'] = blockLgdcode;
    data['Panchayat_lgdcode'] = panchayatLgdcode;
    data['Village_lgdcode'] = villageLgdcode;
    data['Address'] = address;
    data['Gender'] = gender;
    data['StateName'] = stateName;
    data['DistrictName'] = districtName;
    data['BlockName'] = blockName;
    data['PanchayatName'] = panchayatName;
    data['VillageName'] = villageName;
    data['Leveltarining'] = leveltarining;
    data['LeveltariningId'] = leveltariningId;
    data['IsEnable'] = isEnable;
    data['Validated_from'] = validatedFrom;
    data['Validated_to'] = validatedTo;

    if (habitationList != null) {
      data['SJL_HabitationNJMP_FTK_list'] =
          habitationList!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}
class HabitationList {
  int? habitationId;
  String? habitationName;

  HabitationList({this.habitationId, this.habitationName});

  HabitationList.fromJson(Map<String, dynamic> json) {
    habitationId = json['HabitationId'];
    habitationName = json['HabitationName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['HabitationId'] = habitationId;
    data['HabitationName'] = habitationName;
    return data;
  }
}