class LoginResponseModel {
  final int? msgCode;
  final String? msg;
  final String? username;
  final int? userid;
  final int? stateCode;
  final String? stateNameEnglish;
  final int? zpcode;
  final String? zpname;
  final int? districtlgdcode;
  final String? districtlgdname;
  final int? bpcode;
  final String? bpname;
  final int? blocklgdcode;
  final String? blocklgdname;
  final int? gpcode;
  final String? gpname;
  final int? entityLevel;
  final List<VillageModel>? villagelist;
  final String? roletype;
  final String? roleId;

  LoginResponseModel({
    this.msgCode,
    this.msg,
    this.username,
    this.userid,
    this.stateCode,
    this.stateNameEnglish,
    this.zpcode,
    this.zpname,
    this.districtlgdcode,
    this.districtlgdname,
    this.bpcode,
    this.bpname,
    this.blocklgdcode,
    this.blocklgdname,
    this.gpcode,
    this.gpname,
    this.entityLevel,
    this.villagelist,
    this.roletype,
    this.roleId,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      msgCode: json['msg_code'],
      msg: json['msg'],
      username: json['username'],
      userid: json['userid'],
      stateCode: json['state_code'],
      stateNameEnglish: json['state_name_english'],
      zpcode: json['zpcode'],
      zpname: json['zpname'],
      districtlgdcode: json['districtlgdcode'],
      districtlgdname: json['districtlgdname'],
      bpcode: json['bpcode'],
      bpname: json['bpname'],
      blocklgdcode: json['blocklgdcode'],
      blocklgdname: json['blocklgdname'],
      gpcode: json['gpcode'],
      gpname: json['gpname'],
      entityLevel: json['entity_level'],
      villagelist: json['villagelist'] != null
          ? (json['villagelist'] as List)
          .map((v) => VillageModel.fromJson(v))
          .toList()
          : [],
      roletype: json['roletype'],
      roleId: json['role_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'msg_code': msgCode,
      'msg': msg,
      'username': username,
      'userid': userid,
      'state_code': stateCode,
      'state_name_english': stateNameEnglish,
      'zpcode': zpcode,
      'zpname': zpname,
      'districtlgdcode': districtlgdcode,
      'districtlgdname': districtlgdname,
      'bpcode': bpcode,
      'bpname': bpname,
      'blocklgdcode': blocklgdcode,
      'blocklgdname': blocklgdname,
      'gpcode': gpcode,
      'gpname': gpname,
      'entity_level': entityLevel,
      'villagelist': villagelist?.map((v) => v.toJson()).toList(),
      'roletype': roletype,
      'role_id': roleId,
    };
  }
}

class VillageModel {
  final int? sno;
  final int? villagelgdcode;
  final String? villagename;

  VillageModel({
    this.sno,
    this.villagelgdcode,
    this.villagename,
  });

  factory VillageModel.fromJson(Map<String, dynamic> json) {
    return VillageModel(
      sno: json['sno'],
      villagelgdcode: json['villagelgdcode'],
      villagename: json['villagename'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sno': sno,
      'villagelgdcode': villagelgdcode,
      'villagename': villagename,
    };
  }
}
