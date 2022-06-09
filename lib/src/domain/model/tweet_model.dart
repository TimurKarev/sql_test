import 'package:equatable/equatable.dart';
import 'package:sql_test/src/domain/model/available_emojis.dart';

class TweetModel extends Equatable {
  final int id;
  final String name;
  final String address;
  final String body;
  final Set<EmojisModel> emojis;

  @override
  List<Object?> get props => [
        id,
        name,
        address,
        body,
        emojis,
      ];

  const TweetModel({
    required this.id,
    required this.name,
    required this.address,
    required this.body,
    required this.emojis,
  });
}
