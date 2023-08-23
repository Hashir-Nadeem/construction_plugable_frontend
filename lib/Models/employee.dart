// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

employee employeeFromJson(String str) => employee.fromJson(json.decode(str));

String employeeToJson(employee data) => json.encode(data.toJson());

class employee {
  employee({
    required this.email,
    required this.uniqueId,
    required this.autoId,
    required this.newPassword,
    required this.active,
    required this.approved,
  });

  String email;
  String uniqueId;
  String autoId;
  String newPassword;
  bool active;
  bool approved;

  factory employee.fromJson(Map<String, dynamic> json) => employee(
        email: json["email"],
        uniqueId: json["uniqueId"],
        autoId: json["autoId"],
        newPassword: json["new_password"],
        active: json["active"],
        approved: json["approved"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "uniqueId": uniqueId,
        "autoId": autoId,
        "new_password": newPassword,
        "active": active,
        "approved": approved,
      };
}
