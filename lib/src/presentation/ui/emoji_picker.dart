import 'package:flutter/material.dart';
import 'package:sql_test/src/domain/constants/available_emojis.dart';
import 'package:sql_test/src/presentation/ui_kit/emoji.dart';

class EmojiPicker extends StatelessWidget {
  final Function(AvailableEmojis emoji) onTap;

  const EmojiPicker({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: AvailableEmojis.values
              .map(
                (emoji) => InkWell(
                  onTap: () => onTap(emoji),
                  child: Emoji(
                    emoji: emoji.unicode,
                    size: 30.0, //TODO: move to constant
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
