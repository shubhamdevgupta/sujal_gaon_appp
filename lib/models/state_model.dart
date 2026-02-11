// To parse this JSON data, do
//
//     final statemodel = statemodelFromJson(jsonString);

import 'dart:convert';

Statemodel statemodelFromJson(String str) => Statemodel.fromJson(json.decode(str));

String statemodelToJson(Statemodel data) => json.encode(data.toJson());

class Statemodel {
  bool status;
  String message;
  List<Statelist> statelist;

  Statemodel({
    required this.status,
    required this.message,
    required this.statelist,
  });

  factory Statemodel.fromJson(Map<String, dynamic> json) => Statemodel(
    status: json["Status"],
    message: json["Message"],
    statelist: List<Statelist>.from(json["Statelist"].map((x) => Statelist.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "Statelist": List<dynamic>.from(statelist.map((x) => x.toJson())),
  };
}

class Statelist {
  int stateid;
  String statename;

  Statelist({
    required this.stateid,
    required this.statename,
  });

  factory Statelist.fromJson(Map<String, dynamic> json) => Statelist(
    stateid: json["Stateid"],
    statename: json["Statename"],
  );

  Map<String, dynamic> toJson() => {
    "Stateid": stateid,
    "Statename": statename,
  };
}
