// To parse this JSON data, do
//
//     final policy = policyFromJson(jsonString);

import 'dart:convert';

Policy policyFromJson(String str) => Policy.fromJson(json.decode(str));

String policyToJson(Policy data) => json.encode(data.toJson());

class Policy {
  Policy({
    required this.newPolicy,
    required this.newTerms,
    required this.newEmailaddress,
    required this.newWebaddress,
    required this.newName,
    required this.newCompanyinfoid,
    this.newLogo,
    this.newLogoid,
    this.newLogoUrl,
  });

  String newPolicy;
  String newTerms;
  String newEmailaddress;
  String newWebaddress;
  String newName;
  String newCompanyinfoid;
  dynamic newLogo;
  dynamic newLogoid;
  dynamic newLogoUrl;

  factory Policy.fromJson(Map<String, dynamic> json) => Policy(
        newPolicy: json["newPolicy"],
        newTerms: json["newTerms"],
        newEmailaddress: json["newEmailaddress"],
        newWebaddress: json["newWebaddress"],
        newName: json["newName"],
        newCompanyinfoid: json["newCompanyinfoid"],
        newLogo: json["newLogo"],
        newLogoid: json["newLogoid"],
        newLogoUrl: json["newLogoUrl"],
      );

  Map<String, dynamic> toJson() => {
        "newPolicy": newPolicy,
        "newTerms": newTerms,
        "newEmailaddress": newEmailaddress,
        "newWebaddress": newWebaddress,
        "newName": newName,
        "newCompanyinfoid": newCompanyinfoid,
        "newLogo": newLogo,
        "newLogoid": newLogoid,
        "newLogoUrl": newLogoUrl,
      };
}
