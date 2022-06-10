import 'package:flutter/material.dart';
import 'package:sql_test/src/domain/model/available_emojis.dart';
import 'package:sql_test/src/presentation/constants/ui_constant.dart';
import 'package:sql_test/src/presentation/ui_kit/avatar_app.dart';
import 'package:sql_test/src/presentation/ui_kit/emoji.dart';

class Tweet extends StatelessWidget {
  final String name;
  final String address;
  final String body;
  final List<EmojisModel> emojis;
  final bool isActive;

  const Tweet({
    Key? key,
    required this.name,
    required this.address,
    required this.body,
    required this.emojis,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isActive ? UiConstant.activeCardElevation : UiConstant.defaultCardElevation,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: isActive ? Theme.of(context).primaryColor : Theme.of(context).backgroundColor,
          width: UiConstant.cardBorderThickness,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(UiConstant.cardBorderRadius),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(UiConstant.cardPadding),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              children: [
                AvatarApp(
                  text: name,
                ),
                const SizedBox(
                  width: UiConstant.cardAvatarRightPadding,
                ),
                Column(
                  children: [
                    Text(
                      name,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      address,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: UiConstant.cardTextPadding),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  body,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
            if (emojis.isNotEmpty)
              Divider(
                thickness: UiConstant.cardDividerThickness,
                color: Theme.of(context).backgroundColor,
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: emojis
                  .map(
                    (emoji) => Padding(
                      padding: const EdgeInsets.only(right: UiConstant.cardEmojiPadding),
                      child: Emoji(
                        emoji: emoji.unicode,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
