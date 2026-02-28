  class VwscListResponse {
  final int? userId;
  final bool status;
  final String? message;
  final String? token;
  final List<VwscItem> vwscList;

  VwscListResponse({
    this.userId,
    required this.status,
    this.message,
    this.token,
    required this.vwscList,
  });

  factory VwscListResponse.fromJson(Map<String, dynamic> json) {
    return VwscListResponse(
      userId: json['UserId'],
      status: json['Status'] ?? false,
      message: json['msg'],
      token: json['Token'],
      vwscList: json['SJLVWSC_PS_UGlist'] != null
          ? List<VwscItem>.from(
          json['SJLVWSC_PS_UGlist']
              .map((x) => VwscItem.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'UserId': userId,
      'Status': status,
      'msg': message,
      'Token': token,
      'SJLVWSC_PS_UGlist':
      vwscList.map((e) => e.toJson()).toList(),
    };
  }
}

/// 🔹 Individual VWSC / Pani Samiti Item
class VwscItem {
  final String? villageName;
  final String? officialEmail;
  final String? levels;
  final String? officeAddress;
  final int? countMembers;

  VwscItem({
    this.villageName,
    this.officialEmail,
    this.levels,
    this.officeAddress,
    this.countMembers,
  });

  factory VwscItem.fromJson(Map<String, dynamic> json) {
    return VwscItem(
      villageName: json['VillageName'],
      officialEmail: json['OfficialEmail'],
      levels: json['Levels'],
      officeAddress: json['OfficeAddress'],
      countMembers: json['CountMembers'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'VillageName': villageName,
      'OfficialEmail': officialEmail,
      'Levels': levels,
      'OfficeAddress': officeAddress,
      'CountMembers': countMembers,
    };
  }
}