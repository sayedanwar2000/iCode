// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? message;
  int? status;
  Resource? resource;

  UserModel({
    this.message,
    this.status,
    this.resource,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    message: json["message"],
    status: json["status"],
    resource: json["resource"] == null ? null : Resource.fromJson(json["resource"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "resource": resource?.toJson(),
  };
}

class Resource {
  int? id;
  String? username;
  String? password;
  String? name;
  int? userRole;
  String? imageUrl;
  String? pacsUsername;
  String? risUserId;
  int? institutionId;
  bool? isActive;
  dynamic createCriticalResult;
  DateTime? created;
  dynamic modified;
  int? createdBy;
  dynamic modifiedBy;
  String? deviceToken;
  String? token;
  List<Contact>? contacts;

  Resource({
    this.id,
    this.username,
    this.password,
    this.name,
    this.userRole,
    this.imageUrl,
    this.pacsUsername,
    this.risUserId,
    this.institutionId,
    this.isActive,
    this.createCriticalResult,
    this.created,
    this.modified,
    this.createdBy,
    this.modifiedBy,
    this.deviceToken,
    this.token,
    this.contacts,
  });

  factory Resource.fromJson(Map<String, dynamic> json) => Resource(
    id: json["id"],
    username: json["username"],
    password: json["password"],
    name: json["name"],
    userRole: json["userRole"],
    imageUrl: json["imageURL"],
    pacsUsername: json["pacsUsername"],
    risUserId: json["risUserID"],
    institutionId: json["institutionID"],
    isActive: json["isActive"],
    createCriticalResult: json["createCriticalResult"],
    created: json["created"] == null ? null : DateTime.parse(json["created"]),
    modified: json["modified"],
    createdBy: json["createdBy"],
    modifiedBy: json["modifiedBy"],
    deviceToken: json["deviceToken"],
    token: json["token"],
    contacts: json["contacts"] == null ? [] : List<Contact>.from(json["contacts"]!.map((x) => Contact.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "password": password,
    "name": name,
    "userRole": userRole,
    "imageURL": imageUrl,
    "pacsUsername": pacsUsername,
    "risUserID": risUserId,
    "institutionID": institutionId,
    "isActive": isActive,
    "createCriticalResult": createCriticalResult,
    "created": created?.toIso8601String(),
    "modified": modified,
    "createdBy": createdBy,
    "modifiedBy": modifiedBy,
    "deviceToken": deviceToken,
    "token": token,
    "contacts": contacts == null ? [] : List<dynamic>.from(contacts!.map((x) => x.toJson())),
  };
}

class Contact {
  int? id;
  int? userId;
  int? type;
  String? value;
  bool? isDefault;
  bool? isNew;
  dynamic userName;

  Contact({
    this.id,
    this.userId,
    this.type,
    this.value,
    this.isDefault,
    this.isNew,
    this.userName,
  });

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
    id: json["id"],
    userId: json["userID"],
    type: json["type"],
    value: json["value"],
    isDefault: json["isDefault"],
    isNew: json["isNew"],
    userName: json["userName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userID": userId,
    "type": type,
    "value": value,
    "isDefault": isDefault,
    "isNew": isNew,
    "userName": userName,
  };
}
