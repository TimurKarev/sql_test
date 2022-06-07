import 'package:flutter/material.dart';

class Emoji extends StatelessWidget {
  final String emoji;
  final double size;

  const Emoji({
    Key? key,
    required this.emoji,
    this.size = 20.0, //TODO: move to constant
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
