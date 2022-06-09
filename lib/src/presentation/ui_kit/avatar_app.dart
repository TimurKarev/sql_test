import 'package:flutter/material.dart';
import 'package:sql_test/src/presentation/constants/ui_constant.dart';

class AvatarApp extends StatelessWidget {
  final String? text;

  const AvatarApp({
    Key? key,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Theme.of(context).backgroundColor,
      radius: UiConstant.avatarRadius,
      child: Text(
        _getLetter(),
        style: Theme.of(context).textTheme.headline5,
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
