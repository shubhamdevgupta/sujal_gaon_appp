class UpdateWsoSSGPassword {
  final bool status;
  final int? userId;
  final int? id;
  final String? message;
  final String? loginId;

  UpdateWsoSSGPassword({
    required this.status,
    this.userId,
    this.id,
    this.message,
    this.loginId,
  });

  factory UpdateWsoSSGPassword.fromJson(Map<String, dynamic> json) {
    return UpdateWsoSSGPassword(
      status: json['Status'] ?? false,
      userId: json['UserId'],
      id: json['Id'],
      message: json['Message'],
      loginId: json['LoginId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Status': status,
      'UserId': userId,
      'Id': id,
      'Message': message,
      'LoginId': loginId,
    };
  }
}
