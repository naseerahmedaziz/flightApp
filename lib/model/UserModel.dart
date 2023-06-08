import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final String? userId;
  final String? firstName;
  final String? lastName;
  final String? phoneNo;
  String flightIata;
  String from;
  String to;
  String dep;
  String arr;

  UserModel({
    this.userId,
    this.firstName,
    this.lastName,
    this.phoneNo,
    required this.flightIata,
    required this.from,
    required this.to,
    required this.dep,
    required this.arr,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userId: json["userId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        phoneNo: json["phoneNo"],
        flightIata: json["flightIata"],
        from: json["from"],
        to: json["to"],
        dep: json["dep"],
        arr: json["arr"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "phoneNo": phoneNo,
        "flightIata": flightIata,
        "from": from,
        "to": to,
        "dep": dep,
        "arr": arr,
      };
}
