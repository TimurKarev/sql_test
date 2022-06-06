import 'package:flutter/material.dart';

class Emoji extends StatelessWidget {
  final String emoji;
  const Emoji({
    Key? key,
    required this.emoji,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      emoji,
      style: const TextStyle(
        fontSize: 20.0, //TODO: move to constant
      ),
    );
  }
}
