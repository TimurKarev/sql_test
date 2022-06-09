import 'package:flutter/material.dart';
import 'package:sql_test/src/presentation/constants/ui_constant.dart';

class Emoji extends StatelessWidget {
  final String emoji;
  final double size;

  const Emoji({
    Key? key,
    required this.emoji,
    this.size = UiConstant.tweetEmojiSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      emoji,
      style: TextStyle(
        fontSize: size,
      ),
    );
  }
}
