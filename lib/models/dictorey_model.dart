// To parse this JSON data, do
//
//     final rpwssDirectorymodel = rpwssDirectorymodelFromJson(jsonString);

import 'dart:convert';

RpwssDirectorymodel rpwssDirectorymodelFromJson(String str) => RpwssDirectorymodel.fromJson(json.decode(str));

String rpwssDirectorymodelToJson(RpwssDirectorymodel data) => json.encode(data.toJson());

class RpwssDirectorymodel {
  bool status;
  String message;
  List<RpwssResultList> rpwssResultList;

  RpwssDirectorymodel({
    required this.status,
    required this.message,
    required this.rpwssResultList,
  });

  factory RpwssDirectorymodel.fromJson(Map<String, dynamic> json) => RpwssDirectorymodel(
    status: json["Status"],
    message: json["Message"],
    rpwssResultList: List<RpwssResultList>.from(json["RPWSS_Result_list"].map((x) => RpwssResultList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "RPWSS_Result_list": List<dynamic>.from(rpwssResultList.map((x) => x.toJson())),
  };
}

class RpwssResultList {
  StateName stateName;
  Districtname districtname;
  String blockName;
  String panchayatName;
  String villageName;
  String habitationName;
  String temporaryId;
  String serviceAreaId;
  String distributionNetwork;

  RpwssResultList({
    required this.stateName,
    required this.districtname,
    required this.blockName,
    required this.panchayatName,
    required this.villageName,
    required this.habitationName,
    required this.temporaryId,
    required this.serviceAreaId,
    required this.distributionNetwork,
  });

  factory RpwssResultList.fromJson(Map<String, dynamic> json) => RpwssResultList(
    stateName: stateNameValues.map[json["StateName"]]!,
    districtname: districtnameValues.map[json["Districtname"]]!,
    blockName: json["BlockName"],
    panchayatName: json["PanchayatName"],
    villageName: json["VillageName"],
    habitationName: json["HabitationName"],
    temporaryId: json["Temporary_ID"],
    serviceAreaId: json["Service_Area_ID"],
    distributionNetwork: json["Distribution_Network"],
  );

  Map<String, dynamic> toJson() => {
    "StateName": stateNameValues.reverse[stateName],
    "Districtname": districtnameValues.reverse[districtname],
    "BlockName": blockName,
    "PanchayatName": panchayatName,
    "VillageName": villageName,
    "HabitationName": habitationName,
    "Temporary_ID": temporaryId,
    "Service_Area_ID": serviceAreaId,
    "Distribution_Network": distributionNetwork,
  };
}

enum Districtname {
  ALLURI_SITHARAMA_RAJU,
  ANAKAPALLI,
  ANANTHAPURAMU,
  ANNAMAYYA,
  BAPATLA,
  CHITTOOR,
  DISTRICTNAME_ALLURI_SITHARAMA_RAJU,
  DISTRICTNAME_ANANTHAPURAMU,
  DISTRICTNAME_NANDYAL,
  DISTRICTNAME_PARVATHIPURAM_MANYAM,
  DISTRICTNAME_SRI_POTTI_SRIRAMULU_NELLORE,
  DR_B_R_AMBEDKAR_KONASEEMA,
  EAST_GODAVARI,
  ELURU,
  GUNTUR,
  KAKINADA,
  KRISHNA,
  KURNOOL,
  NANDYAL,
  NTR,
  PALNADU,
  PARVATHIPURAM_MANYAM,
  PRAKASAM,
  SRIKAKULAM,
  SRI_POTTI_SRIRAMULU_NELLORE,
  SRI_SATHYA_SAI,
  TIRUPATI,
  VISAKHAPATNAM,
  VIZIANAGARAM,
  WEST_GODAVARI,
  Y_S_R
}

final districtnameValues = EnumValues({
  "Alluri Sitharama Raju": Districtname.ALLURI_SITHARAMA_RAJU,
  "Anakapalli": Districtname.ANAKAPALLI,
  "Ananthapuramu": Districtname.ANANTHAPURAMU,
  "Annamayya": Districtname.ANNAMAYYA,
  "Bapatla": Districtname.BAPATLA,
  "Chittoor": Districtname.CHITTOOR,
  "ALLURI SITHARAMA RAJU": Districtname.DISTRICTNAME_ALLURI_SITHARAMA_RAJU,
  "ANANTHAPURAMU": Districtname.DISTRICTNAME_ANANTHAPURAMU,
  "NANDYAL": Districtname.DISTRICTNAME_NANDYAL,
  "PARVATHIPURAM MANYAM": Districtname.DISTRICTNAME_PARVATHIPURAM_MANYAM,
  "SRI POTTI SRIRAMULU NELLORE": Districtname.DISTRICTNAME_SRI_POTTI_SRIRAMULU_NELLORE,
  "Dr. B.R. Ambedkar Konaseema": Districtname.DR_B_R_AMBEDKAR_KONASEEMA,
  "East Godavari": Districtname.EAST_GODAVARI,
  "Eluru": Districtname.ELURU,
  "Guntur": Districtname.GUNTUR,
  "Kakinada": Districtname.KAKINADA,
  "Krishna": Districtname.KRISHNA,
  "Kurnool": Districtname.KURNOOL,
  "Nandyal": Districtname.NANDYAL,
  "Ntr": Districtname.NTR,
  "Palnadu": Districtname.PALNADU,
  "Parvathipuram Manyam": Districtname.PARVATHIPURAM_MANYAM,
  "Prakasam": Districtname.PRAKASAM,
  "Srikakulam": Districtname.SRIKAKULAM,
  "Sri Potti Sriramulu Nellore": Districtname.SRI_POTTI_SRIRAMULU_NELLORE,
  "Sri Sathya Sai": Districtname.SRI_SATHYA_SAI,
  "Tirupati": Districtname.TIRUPATI,
  "Visakhapatnam": Districtname.VISAKHAPATNAM,
  "Vizianagaram": Districtname.VIZIANAGARAM,
  "West Godavari": Districtname.WEST_GODAVARI,
  "Y.S.R.": Districtname.Y_S_R
});

enum StateName {
  ANDHRA_PRADESH
}

final stateNameValues = EnumValues({
  "Andhra Pradesh": StateName.ANDHRA_PRADESH
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
