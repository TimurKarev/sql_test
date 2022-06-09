import 'package:flutter/material.dart';
import 'package:sql_test/src/domain/model/available_emojis.dart';
import 'package:sql_test/src/presentation/constants/ui_constant.dart';
import 'package:sql_test/src/presentation/ui_kit/emoji.dart';

class EmojiPicker extends StatelessWidget {
  final Function(EmojisModel emoji) onTap;

  const EmojiPicker({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).hoverColor,
      child: Padding(
        padding: const EdgeInsets.all(UiConstant.pickerPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: EmojisModel.values
              .map(
                (emoji) => InkWell(
                  onTap: () => onTap(emoji),
                  child: Emoji(
                    emoji: emoji.unicode,
                    size: UiConstant.pickerEmojiSize,
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
