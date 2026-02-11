// lib/models/base_response.dart

class BaseResponseModel<T> {
  final int status;
  final String message;
  final List<T> result;

  BaseResponseModel({
    required this.status,
    required this.message,
    required this.result,
  });

  factory BaseResponseModel.fromJson(
      Map<String, dynamic> json,
      T Function(Map<String, dynamic>) fromJsonT,
      ) {

    // -------- STATUS HANDLE --------
    int parsedStatus = 0;

    final statusValue = json['Status'];

    if (statusValue is bool) {
      parsedStatus = statusValue ? 1 : 0;
    } else if (statusValue is int) {
      parsedStatus = statusValue;
    } else if (statusValue is String) {
      parsedStatus = statusValue == "1" ? 1 : 0;
    }

    // -------- LIST HANDLE (ALL MASTER KEYS) --------
    final listData =
        json['Result'] ??

            json['Result'] ??
            json['Statelist'] ??
            json['DistrictList'] ??
            json['Blocklist'] ??
            json['Grampanchayatlist'] ??
            json['Villagelist'] ??
            json['HabitationList'];

            [];

    return BaseResponseModel<T>(
      status: parsedStatus,
      message: json['Message']?.toString() ?? '',
      result: listData is List
          ? List<T>.from(
        listData.map((e) => fromJsonT(e)),
      )
          : [],
    );
  }



  Map<String, dynamic> toJson(
      Map<String, dynamic> Function(T) toJsonT,
      ) {
    return {
      'Status': status,
      'Message': message,
      'Result': result.map((e) => toJsonT(e)).toList(),
    };
  }

  @override
  String toString() =>
      'BaseResponse(status: $status, message: $message, resultCount: ${result.length})';
}
