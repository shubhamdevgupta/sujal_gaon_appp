class UpdateNjmFtkPassword {
  final bool status;
  final int? userId;
  final int? id;
  final String? message;
  final String? loginId;

  UpdateNjmFtkPassword({
    required this.status,
    this.userId,
    this.id,
    this.message,
    this.loginId,
  });

  factory UpdateNjmFtkPassword.fromJson(Map<String, dynamic> json) {
    return UpdateNjmFtkPassword(
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
