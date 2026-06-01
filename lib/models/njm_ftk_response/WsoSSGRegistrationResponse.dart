class Wsossgregistrationresponse {
  final int? userId;
  final bool status;
  final String? message;
  final String? token;
  final int? id;

  Wsossgregistrationresponse({
    this.userId,
    required this.status,
    this.message,
    this.token,
    this.id,
  });

  factory Wsossgregistrationresponse.fromJson(Map<String, dynamic> json) {
    return Wsossgregistrationresponse(
      userId: json['UserId'],
      status: json['Status'] ?? false,
      message: json['msg'],
      token: json['Token'],
      id: json['Id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'UserId': userId,
      'Status': status,
      'msg': message,
      'Token': token,
      'Id': id,
    };
  }
}