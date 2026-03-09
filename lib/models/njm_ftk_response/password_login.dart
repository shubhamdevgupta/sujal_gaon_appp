class PasswordLoginResponse {
  bool? status;
  int? userId;
  String? message;
  int? isPwdUpdated;

  PasswordLoginResponse({
    this.status,
    this.userId,
    this.message,
    this.isPwdUpdated,
  });

  PasswordLoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    userId = json['UserId'];
    message = json['Message'];
    isPwdUpdated = json['Is_pwd_update'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['Status'] = status;
    data['UserId'] = userId;
    data['Message'] = message;
    data['Is_pwd_update'] = isPwdUpdated;
    return data;
  }
}