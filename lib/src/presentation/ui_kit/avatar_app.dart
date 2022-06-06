import 'package:flutter/material.dart';

class AvatarApp extends StatelessWidget {
  final String? text;

  const AvatarApp({
    Key? key,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 24.0,
      child: Text(
        _getLetter(),
      ),
    );
  }

  String _getLetter() {
    if (text == null) {
      return ' ';
    }

    if (text!.isEmpty || text! == '') {
      return ' ';
    }

    return text![0];
  }
}
