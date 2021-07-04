import 'dart:io';

import 'package:dart_mongo_lite/dart_mongo_lite.dart';
import 'package:get/get.dart';

import '../services/mail_service.dart';
import '../utils/date.dart';
import '../utils/globals.dart';
import '../models/game_model.dart';

class GameService {
  static Collection gamesCollection = database['games'];

  static Future<List<GameModel>> getAll() async {
    await Future.delayed(1.seconds);

    final result = gamesCollection.findAs<GameModel>((source) => GameModel.fromMap(source), filter: {});
    return result
      ..sort((a, b) => a.createdAtAsDate.isAfter(b.createdAtAsDate) ? 0 : 1);
  }

  static Future<void> save(GameModel game) async {
    if (game == null) return;
    gamesCollection.insert(game.toMap());
  }

  static Future<void> delete(String id) async {
    gamesCollection.delete({'_id': id});
  }

  static Future<void> getReport() async {
    var csv = 'id,post,price,date\n';
    final result = gamesCollection.findAs<GameModel>((source) => GameModel.fromMap(source), filter: {});
    csv += result.map((e) => e.toString()).join('\n');
    
    final filePath = 'reports/report_' + TimeUtils.dateOnly + '.csv';
    final file = File(filePath);
    file.createSync(recursive: true);
    file.writeAsStringSync(csv);
  }

  static Future<void> sendReport() async {
    await getReport();
    await MailService.sendMail(MailType.Report);
  }
}
