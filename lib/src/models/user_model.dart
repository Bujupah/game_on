import 'dart:convert';

import 'package:game_on/src/utils/strings.dart';

class UserModel {
  String _id;
  final String email;
  final String username;
  final String password;
  final String fullname;
  final String role;

  UserModel({this.email, this.username, this.password, this.fullname, this.role});

  String get id => _id;
  String get decodedPassword => StringsUtil.fromB64(this.password);
  String get myRole => role[0].toUpperCase() + role.substring(1);
  bool get isAdmin => role == 'SuperAdmin';

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'],
      username: map['username'],
      password: map['password'],
      fullname: map['fullname'],
      role: map['role'],
    ).._id = map['_id'];
  }

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'id': _id ?? this.hashCode.toString(),
      'email': email,
      'username': username,
      'password': password,
      'fullname': fullname,
      'role': role,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return '"$email","$username","$fullname","$role"';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserModel &&
      other.email == email &&
      other.username == username &&
      other.fullname == fullname &&
      other.role == role;
  }

  @override
  int get hashCode => email.hashCode ^ username.hashCode ^ fullname.hashCode ^ role.hashCode;
}