import 'dart:io';

import 'package:game_on/src/services/user_service.dart';
import 'package:game_on/src/utils/config.dart';
import 'package:game_on/src/utils/date.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

enum MailType {
  Reset, Report
}

class MailMessage {
  String subject;
  String message;
  String attachment;
  MailMessage({this.subject = '', this.message = '', this.attachment});
}

class MailService {
  static Future<void> sendMail(MailType mailType) async {
    try {
      final smtpServer = gmail(Config.smtpEmail, Config.smtpPass);
      final msgContent = _getMailMessage(mailType);
      await send(msgContent, smtpServer);
    } catch(e) {
      throw 'Failed to send mail';
    }
  }


  static Message  _getMailMessage(MailType mailType) {
    final message = Message()
      ..from = Address(Config.smtpEmail, Config.appName)
      ..recipients.add(Address(UserService.currentUser.email));

    if (mailType == MailType.Reset) 
      message
        ..subject = 'Game On - Account - ${TimeUtils.now}'
        ..html = '''
          <h4><b>Authentication information:</b></h4>
          <h5><b>Username</b>: ${UserService.currentUser.username}</h5>
          <h5><b>Password</b>: ${UserService.currentUser.decodedPassword}</h5>
        ''';
    
    if (mailType == MailType.Report) {
      final filePath = 'reports/report_' + TimeUtils.dateOnly + '.csv';
      final file = File(filePath);
      message
      ..subject = 'Game On - Report - ${TimeUtils.now}'
      ..html = '''
        <h4>Report</h4>
      '''
      ..attachments = [FileAttachment(file)..location = Location.inline];
    }

    return message;
  }
}