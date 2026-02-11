// To parse this JSON data, do
//
//     final blockmodel = blockmodelFromJson(jsonString);

import 'dart:convert';

Blockmodel blockmodelFromJson(String str) => Blockmodel.fromJson(json.decode(str));

String blockmodelToJson(Blockmodel data) => json.encode(data.toJson());

class Blockmodel {
  bool status;
  String message;
  List<Blocklist> blocklist;

  Blockmodel({
    required this.status,
    required this.message,
    required this.blocklist,
  });

  factory Blockmodel.fromJson(Map<String, dynamic> json) => Blockmodel(
    status: json["Status"],
    message: json["Message"],
    blocklist: List<Blocklist>.from(json["Blocklist"].map((x) => Blocklist.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "Blocklist": List<dynamic>.from(blocklist.map((x) => x.toJson())),
  };
}

class Blocklist {
  String blockName;
  int blockid;

  Blocklist({
    required this.blockName,
    required this.blockid,
  });

  factory Blocklist.fromJson(Map<String, dynamic> json) => Blocklist(
    blockName: json["BlockName"],
    blockid: json["blockid"],
  );

  Map<String, dynamic> toJson() => {
    "BlockName": blockName,
    "blockid": blockid,
  };
}
