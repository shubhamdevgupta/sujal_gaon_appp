class GroundWaterPumpResponse {
  final int? id;
  final bool status;
  final String? message;
  final String? token;

  GroundWaterPumpResponse({
    this.id,
    required this.status,
    this.message,
    this.token,
  });

  factory GroundWaterPumpResponse.fromJson(Map<String, dynamic> json) {
    return GroundWaterPumpResponse(
      id: json['Id'],
      status: json['Status'] ?? false,
      message: json['msg'],
      token: json['Token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Id": id,
      "Status": status,
      "msg": message,
      "Token": token,
    };
  }
}