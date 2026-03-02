class NjmFtkLoginResponse {
  final bool status;
  final String message;
  final String loginId;
  final String token;
  final String mobileNumber;
  final int otp;
  final int regId;

  NjmFtkLoginResponse({
    required this.status,
    required this.message,
    required this.loginId,
    required this.token,
    required this.mobileNumber,
    required this.otp,
    required this.regId,
  });

  factory NjmFtkLoginResponse.fromJson(Map<String, dynamic> json) {
    return NjmFtkLoginResponse(
      status: json['Status'] ?? false,
      message: json['Message'] ?? '',
      loginId: json['LoginId'] ?? '',
      token: json['Token'] ?? '',
      mobileNumber: json['MobileNumber'] ?? '',
      otp: json['OTP'] ?? 0,
      regId: json['RegId'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Status': status,
      'Message': message,
      'LoginId': loginId,
      'Token': token,
      'MobileNumber': mobileNumber,
      'OTP': otp,
      'RegId': regId,
    };
  }
}