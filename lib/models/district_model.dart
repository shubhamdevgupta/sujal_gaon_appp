// To parse this JSON data, do
//
//     final districtmodel = districtmodelFromJson(jsonString);

import 'dart:convert';

Districtmodel districtmodelFromJson(String str) => Districtmodel.fromJson(json.decode(str));

String districtmodelToJson(Districtmodel data) => json.encode(data.toJson());

class Districtmodel {
  bool status;
  String message;
  List<DistrictList> districtList;

  Districtmodel({
    required this.status,
    required this.message,
    required this.districtList,
  });

  factory Districtmodel.fromJson(Map<String, dynamic> json) => Districtmodel(
    status: json["Status"],
    message: json["Message"],
    districtList: List<DistrictList>.from(json["DistrictList"].map((x) => DistrictList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "DistrictList": List<dynamic>.from(districtList.map((x) => x.toJson())),
  };
}

class DistrictList {
  int districtId;
  String districtname;

  DistrictList({
    required this.districtId,
    required this.districtname,
  });

  factory DistrictList.fromJson(Map<String, dynamic> json) => DistrictList(
    districtId: json["DistrictId"],
    districtname: json["districtname"],
  );

  Map<String, dynamic> toJson() => {
    "DistrictId": districtId,
    "districtname": districtname,
  };
}
