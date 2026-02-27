class VwscMembersResponse {
  final int? userId;
  final bool status;
  final String? message;
  final String? token;
  final List<VwscMember> members;

  VwscMembersResponse({
    this.userId,
    required this.status,
    this.message,
    this.token,
    required this.members,
  });

  factory VwscMembersResponse.fromJson(Map<String, dynamic> json) {
    return VwscMembersResponse(
      userId: json['UserId'],
      status: json['Status'] ?? false,
      message: json['msg'],
      token: json['Token'],
      members: json['SJLVWSCMemberslist'] != null
          ? List<VwscMember>.from(
          json['SJLVWSCMemberslist']
              .map((x) => VwscMember.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'UserId': userId,
      'Status': status,
      'msg': message,
      'Token': token,
      'SJLVWSCMemberslist':
      members.map((e) => e.toJson()).toList(),
    };
  }
}

/// 🔹 Individual VWSC Member Model
class VwscMember {
  final String? name;
  final String? designation;
  final String? functionalDesignation;
  final String? gender;
  final String? age;
  final String? caste;
  final String? mobile;
  final String? email;
  final String? startDate;
  final String? toDate;
  final String? villageName;

  VwscMember({
    this.name,
    this.designation,
    this.functionalDesignation,
    this.gender,
    this.age,
    this.caste,
    this.mobile,
    this.email,
    this.startDate,
    this.toDate,
    this.villageName,
  });

  factory VwscMember.fromJson(Map<String, dynamic> json) {
    return VwscMember(
      name: json['Name'],
      designation: json['Designation'],
      functionalDesignation: json['FunctionalDesignation'],
      gender: json['Gender'],
      age: json['Age'],
      caste: json['Caste'],
      mobile: json['Mobile']?.toString(),
      email: json['Email'],
      startDate: json['StartDate'],
      toDate: json['ToDate'],
      villageName: json['VillageName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Designation': designation,
      'FunctionalDesignation': functionalDesignation,
      'Gender': gender,
      'Age': age,
      'Caste': caste,
      'Mobile': mobile,
      'Email': email,
      'StartDate': startDate,
      'ToDate': toDate,
      'VillageName': villageName,
    };
  }
}