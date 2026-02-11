// To parse this JSON data, do
//
//     final gPmodel = gPmodelFromJson(jsonString);

import 'dart:convert';

GPmodel gPmodelFromJson(String str) => GPmodel.fromJson(json.decode(str));

String gPmodelToJson(GPmodel data) => json.encode(data.toJson());

class GPmodel {
  bool status;
  String message;
  List<Grampanchayatlist> grampanchayatlist;

  GPmodel({
    required this.status,
    required this.message,
    required this.grampanchayatlist,
  });

  factory GPmodel.fromJson(Map<String, dynamic> json) => GPmodel(
    status: json["Status"],
    message: json["Message"],
    grampanchayatlist: List<Grampanchayatlist>.from(json["Grampanchayatlist"].map((x) => Grampanchayatlist.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "Grampanchayatlist": List<dynamic>.from(grampanchayatlist.map((x) => x.toJson())),
  };
}

class Grampanchayatlist {
  String grampanchayatName;
  int panchayatId;

  Grampanchayatlist({
    required this.grampanchayatName,
    required this.panchayatId,
  });

  factory Grampanchayatlist.fromJson(Map<String, dynamic> json) => Grampanchayatlist(
    grampanchayatName: json["GrampanchayatName"],
    panchayatId: json["PanchayatId"],
  );

  Map<String, dynamic> toJson() => {
    "GrampanchayatName": grampanchayatName,
    "PanchayatId": panchayatId,
  };
}
