// To parse this JSON data, do
//
//     final habitaionmodel = habitaionmodelFromJson(jsonString);

import 'dart:convert';

Habitaionmodel habitaionmodelFromJson(String str) => Habitaionmodel.fromJson(json.decode(str));

String habitaionmodelToJson(Habitaionmodel data) => json.encode(data.toJson());

class Habitaionmodel {
  bool status;
  String message;
  List<HabitationList> habitationList;

  Habitaionmodel({
    required this.status,
    required this.message,
    required this.habitationList,
  });

  factory Habitaionmodel.fromJson(Map<String, dynamic> json) => Habitaionmodel(
    status: json["Status"],
    message: json["Message"],
    habitationList: List<HabitationList>.from(json["HabitationList"].map((x) => HabitationList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "HabitationList": List<dynamic>.from(habitationList.map((x) => x.toJson())),
  };
}

class HabitationList {
  int habitationId;
  String habitationName;

  HabitationList({
    required this.habitationId,
    required this.habitationName,
  });

  factory HabitationList.fromJson(Map<String, dynamic> json) => HabitationList(
    habitationId: json["HabitationId"],
    habitationName: json["HabitationName"],
  );

  Map<String, dynamic> toJson() => {
    "HabitationId": habitationId,
    "HabitationName": habitationName,
  };
}
