// To parse this JSON data, do
//
//     final empJobs = empJobsFromJson(jsonString);

import 'dart:convert';

List<EmpJobs> empJobsFromJson(String str) =>
    List<EmpJobs>.from(json.decode(str).map((x) => EmpJobs.fromJson(x)));

String empJobsToJson(List<EmpJobs> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EmpJobs {
  EmpJobs({
    required this.newJoblocationValue,
    required this.newAssignedfrom,
    required this.newEmployeelocationid,
    required this.newEmployeeValue,
    required this.newAssignedto,
    required this.statuscode,
    required this.newJobLocation,
  });

  String newJoblocationValue;
  DateTime newAssignedfrom;
  String newEmployeelocationid;
  String newEmployeeValue;
  DateTime newAssignedto;
  int statuscode;
  NewJobLocation newJobLocation;

  factory EmpJobs.fromJson(Map<String, dynamic> json) => EmpJobs(
        newJoblocationValue: json["newJoblocationValue"],
        newAssignedfrom: DateTime.parse(json["newAssignedfrom"]),
        newEmployeelocationid: json["newEmployeelocationid"],
        newEmployeeValue: json["newEmployeeValue"],
        newAssignedto: DateTime.parse(json["newAssignedto"]),
        statuscode: json["statuscode"],
        newJobLocation: NewJobLocation.fromJson(json["newJobLocation"]),
      );

  Map<String, dynamic> toJson() => {
        "newJoblocationValue": newJoblocationValue,
        "newAssignedfrom": newAssignedfrom.toIso8601String(),
        "newEmployeelocationid": newEmployeelocationid,
        "newEmployeeValue": newEmployeeValue,
        "newAssignedto": newAssignedto.toIso8601String(),
        "statuscode": statuscode,
        "newJobLocation": newJobLocation.toJson(),
      };
}

class NewJobLocation {
  NewJobLocation({
    required this.newAddress,
    required this.newLatitude,
    required this.newCountry,
    required this.newLocationid,
    required this.newState,
    required this.newLongitude,
    required this.newCity,
    required this.newLocationname,
    required this.statuscode,
    required this.newZipcode,
    required this.newRadius,
  });

  String newAddress;
  String newLatitude;
  String newCountry;
  String newLocationid;
  String newState;
  String newLongitude;
  String newCity;
  String newLocationname;
  int statuscode;
  String newZipcode;
  String newRadius;

  factory NewJobLocation.fromJson(Map<String, dynamic> json) => NewJobLocation(
        newAddress: json["newAddress"],
        newLatitude: json["newLatitude"],
        newCountry: json["newCountry"],
        newLocationid: json["newLocationid"],
        newState: json["newState"],
        newLongitude: json["newLongitude"],
        newCity: json["newCity"],
        newLocationname: json["newLocationname"],
        statuscode: json["statuscode"],
        newZipcode: json["newZipcode"],
        newRadius: json["newRadius"],
      );

  Map<String, dynamic> toJson() => {
        "newAddress": newAddress,
        "newLatitude": newLatitude,
        "newCountry": newCountry,
        "newLocationid": newLocationid,
        "newState": newState,
        "newLongitude": newLongitude,
        "newCity": newCity,
        "newLocationname": newLocationname,
        "statuscode": statuscode,
        "newZipcode": newZipcode,
        "newRadius": newRadius,
      };
}
