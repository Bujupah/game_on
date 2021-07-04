import 'package:flutter/material.dart';

import 'package:dart_mongo_lite/dart_mongo_lite.dart';
import 'package:game_on/src/utils/strings.dart';
import 'package:get/get.dart';

import '../services/mail_service.dart';
import '../models/user_model.dart';
import '../utils/globals.dart';

class UserService {
  static Collection usersCollection = database['users'];


  static UserModel _currentUser;
  static UserModel get currentUser => UserService._currentUser;

  static final _admin = UserModel(
    fullname: 'Khalil Mejdi', 
    email: 'khalil.mejdi97@gmail.com', 
    username: 'bujupah', 
    password: 'MzIxYXpl', 
    role: 'SuperAdmin',
  );

  static Future<void> login(String username, String password) async {
    password = StringsUtil.toB64(password);
    try {
      await UserService._findUserByUsername(username);
      await UserService._findUserByUsernameAndPassword(username, password);
      Get.offNamed('/');
    } catch (e) {
      if (!Get.isSnackbarOpen) Get.rawSnackbar(
        messageText: Text(e.toString() ?? 'Failed to authenticate', style: TextStyle(color: Colors.white)),
        snackPosition: SnackPosition.BOTTOM,
        snackStyle: SnackStyle.FLOATING,
        backgroundColor: Colors.orange[900],
        borderRadius: 4,
        maxWidth: 400,
      );
    }
  }

  static Future<void> logout() async {
    UserService._currentUser = null;
    Get.offNamed('/login');
  }

  static Future<void> addCachier(UserModel user) async {
    try {
      // usersCollection.insert(user.toMap());
      throw 'Not implemented yet!';
    } catch (e) {
      if (!Get.isSnackbarOpen) Get.rawSnackbar(
        icon: Icon(Icons.error),
        messageText: Text(e.toString() ?? 'Failed to add user', style: TextStyle(color: Colors.white)),
        snackPosition: SnackPosition.BOTTOM,
        snackStyle: SnackStyle.FLOATING,
        backgroundColor: Colors.orange[900],
        borderRadius: 4,
        maxWidth: 400,
      );
    }
  }

  static Future<void> getAuth() async {
    await UserService._sendMailInfo(MailType.Reset);
  }
  
  static Future<void> getReport() async {
    await UserService._sendMailInfo(MailType.Report);
  }

  static Future<void> _sendMailInfo(MailType mailType) async {
    try {
      await MailService.sendMail(mailType);
      if (!Get.isSnackbarOpen) Get.rawSnackbar(
        messageText: Text('Please check your mail inbox', style: TextStyle(color: Colors.white)),
        snackPosition: SnackPosition.BOTTOM,
        snackStyle: SnackStyle.FLOATING,
        backgroundColor: Colors.orange[900],
        borderRadius: 4,
        maxWidth: 400,
      );
    } catch (e) {
      if (!Get.isSnackbarOpen) Get.rawSnackbar(
        messageText: Text(e.toString() ?? 'Failed to send mail', style: TextStyle(color: Colors.white)),
        snackPosition: SnackPosition.BOTTOM,
        snackStyle: SnackStyle.FLOATING,
        backgroundColor: Colors.orange[900],
        borderRadius: 4,
        maxWidth: 400,
      );
    }
  }

  static Future<void> _findUserByUsername(String username) async {
    final _users = usersCollection
      .findAs((source) => UserModel.fromMap(source))
      ..add(_admin);
    
    _users.singleWhere(
      (user) => user.username == username, 
      orElse: () => throw 'Incorrect username',
    );
  }

  static Future<void> _findUserByUsernameAndPassword(String username, String password) async {
    final _users = usersCollection
      .findAs((source) => UserModel.fromMap(source))
      ..add(_admin);
    
    _users.singleWhere(
      (user) => user.username == username, 
      orElse: () => throw 'Incorrect username',
    );

    UserService._currentUser = _users.singleWhere(
      (user) => user.username == username && user.password == password, 
      orElse: () => throw 'Incorrect password',
    );
  }
}