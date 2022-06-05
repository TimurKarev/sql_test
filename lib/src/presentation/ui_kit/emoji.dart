import 'package:flutter/material.dart';

class Emoji extends StatelessWidget {
  final String emoji;
  const Emoji({Key? key, required this.emoji}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Text(
          emoji,
          style: const TextStyle(fontSize: 30.0),
        ),
      ),
    );
  }
}
