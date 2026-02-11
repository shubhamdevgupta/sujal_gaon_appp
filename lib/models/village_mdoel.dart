// To parse this JSON data, do
//
//     final villagemodel = villagemodelFromJson(jsonString);

import 'dart:convert';

Villagemodel villagemodelFromJson(String str) => Villagemodel.fromJson(json.decode(str));

String villagemodelToJson(Villagemodel data) => json.encode(data.toJson());

class Villagemodel {
  bool status;
  String message;
  List<Villagelist> villagelist;

  Villagemodel({
    required this.status,
    required this.message,
    required this.villagelist,
  });

  factory Villagemodel.fromJson(Map<String, dynamic> json) => Villagemodel(
    status: json["Status"],
    message: json["Message"],
    villagelist: List<Villagelist>.from(json["Villagelist"].map((x) => Villagelist.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "Villagelist": List<dynamic>.from(villagelist.map((x) => x.toJson())),
  };
}

class Villagelist {
  int villageId;
  String villageName;

  Villagelist({
    required this.villageId,
    required this.villageName,
  });

  factory Villagelist.fromJson(Map<String, dynamic> json) => Villagelist(
    villageId: json["VillageId"],
    villageName: json["VillageName"],
  );

  Map<String, dynamic> toJson() => {
    "VillageId": villageId,
    "VillageName": villageName,
  };
}
