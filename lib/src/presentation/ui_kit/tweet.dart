import 'package:flutter/material.dart';
import 'package:sql_test/src/domain/model/available_emojis.dart';
import 'package:sql_test/src/presentation/ui_kit/avatar_app.dart';
import 'package:sql_test/src/presentation/ui_kit/emoji.dart';

//TODO: style tweet
class Tweet extends StatelessWidget {
  final String name;
  final String address;
  final String body;
  final List<EmojisModel> emojis;

  const Tweet({
    Key? key,
    required this.name,
    required this.address,
    required this.body,
    required this.emojis,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              children: [
                AvatarApp(
                  text: name,
                ),
                const SizedBox(
                  width: 14.0,
                ),
                Column(
                  children: [
                    Text(name),
                    Text(
                      address,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 8.0,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                body,
                style: const TextStyle(
                  fontSize: 14.0,
                ),
              ),
            ),
            if (emojis.isNotEmpty)
              const Divider(
                thickness: 2.0,
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: emojis
                  .map(
                    (emoji) => Emoji(
                      emoji: emoji.unicode,
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
