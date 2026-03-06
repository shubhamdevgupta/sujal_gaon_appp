class NjmFtkLoginResponse {
  final bool? status;
  final String? message;
  final String? loginId;
  final String? mobileNumber;
  final String? name;
  final String? email;
  final int? regId;
  final int? userId;
  final int? isPwdUpdate;
  final int? otp;

  NjmFtkLoginResponse({
    this.status,
    this.message,
    this.loginId,
    this.mobileNumber,
    this.name,
    this.email,
    this.regId,
    this.userId,
    this.isPwdUpdate,
    this.otp,
  });

  factory NjmFtkLoginResponse.fromJson(Map<String, dynamic> json) {
    return NjmFtkLoginResponse(
      status: json['Status'],
      message: json['Message'],
      loginId: json['LoginId'],
      mobileNumber: json['MobileNumber'],
      name: json['Name'],
      email: json['Email'],
      regId: json['RegId'],
      userId: json['UserId'],
      isPwdUpdate: json['Is_pwd_update'],
      otp: json['OTP'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Status': status,
      'Message': message,
      'LoginId': loginId,
      'MobileNumber': mobileNumber,
      'Name': name,
      'Email': email,
      'RegId': regId,
      'UserId': userId,
      'Is_pwd_update': isPwdUpdate,
      'OTP': otp,
    };
  }
}