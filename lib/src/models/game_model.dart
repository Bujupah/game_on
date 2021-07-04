import 'dart:convert';

import 'package:game_on/src/utils/date.dart';
class GameModel {
  DateTime _createdAt;
  String _id;
  int _price;
  int _post;

  GameModel(int post, int price) {
    this._post = post;
    this._price = price; 
    this._createdAt = DateTime.now();
  }

  String get id => _id;
  String get post => 'GameRoom_$_post';
  String get price => '${_price ?? 0}';
  String get createdAt => TimeUtils.format(_createdAt);

  DateTime get createdAtAsDate => _createdAt;
  String get normalFormattedDate => TimeUtils.normalFormat(_createdAt);

  factory GameModel.fromMap(Map<String, dynamic> map) {
    return GameModel(null, null)
      .._id = map['_id']
      .._post = map['_post']
      .._price = map['_price']
      .._createdAt = DateTime.fromMillisecondsSinceEpoch(map['_createdAt']);
  }

  factory GameModel.fromJson(String source) => GameModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      '_id': _id ?? this.hashCode.toString(),
      '_post': _post,
      '_price': _price,
      '_createdAt': _createdAt.millisecondsSinceEpoch,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return '"$id","$post","$price","$normalFormattedDate"';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is GameModel &&
      other._post == _post &&
      other._price == _price &&
      other._createdAt == _createdAt;
  }

  @override
  int get hashCode => _post.hashCode ^ _price.hashCode ^ _createdAt.hashCode;
}
