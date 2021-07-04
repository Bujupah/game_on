import 'package:intl/intl.dart';

class TimeUtils {

  static final DateFormat _normalDateFormat = DateFormat('yyyy/MM/dd HH:MM:ss');
  static final DateFormat _dateFormat = DateFormat('HH:MM:ss | EEEE dd MMMM yyyy');
  static final DateFormat _onlyDateFormat = DateFormat('yyyy_MM_dd');

  static String get now => _normalDateFormat.format(DateTime.now());
  static String get dateOnly => _onlyDateFormat.format(DateTime.now());

  static int get nowEpoc => DateTime.now().millisecondsSinceEpoch;
  static int get startEpoc => DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0, 0, 1).millisecondsSinceEpoch;
  static int get endEpoc => DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 23, 59, 59, 59).millisecondsSinceEpoch;
  
  static String format(DateTime value) => _dateFormat.format(value);   
  static String normalFormat(DateTime value) => _normalDateFormat.format(value);   

}