import 'package:sql_test/src/domain/constants/available_emojis.dart';

class TweetModel {
  final int id;
  final String name;
  final String address;
  final String body;
  final Set<AvailableEmojis> emojis;

//<editor-fold desc="Data Methods">

  const TweetModel({
    required this.id,
    required this.name,
    required this.address,
    required this.body,
    required this.emojis,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TweetModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          address == other.address &&
          body == other.body &&
          emojis == other.emojis);

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ address.hashCode ^ body.hashCode ^ emojis.hashCode;

  @override
  String toString() {
    return 'TweetModel{' +
        ' id: $id,' +
        ' name: $name,' +
        ' address: $address,' +
        ' body: $body,' +
        ' emojis: $emojis,' +
        '}';
  }

  TweetModel copyWith({
    int? id,
    String? name,
    String? address,
    String? body,
    Set<AvailableEmojis>? emojis,
  }) {
    return TweetModel(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      body: body ?? this.body,
      emojis: emojis ?? this.emojis,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'address': this.address,
      'body': this.body,
      'emojis': this.emojis,
    };
  }

  factory TweetModel.fromMap(Map<String, dynamic> map) {
    return TweetModel(
      id: map['id'] as int,
      name: map['name'] as String,
      address: map['address'] as String,
      body: map['body'] as String,
      emojis: map['emojis'] as Set<AvailableEmojis>,
    );
  }

//</editor-fold>
}
