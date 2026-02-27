class Njmregistrationresponse {
  final int? userId;
  final bool status;
  final String? message;
  final String? token;
  final int? id;

  Njmregistrationresponse({
    this.userId,
    required this.status,
    this.message,
    this.token,
    this.id,
  });

  factory Njmregistrationresponse.fromJson(Map<String, dynamic> json) {
    return Njmregistrationresponse(
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