import 'package:flutter/material.dart';

class Tweet extends StatelessWidget {
  final String name;
  final String address;
  final String body;
  final List<String> emojis;

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
      child: Row(
        children: [
          CircleAvatar(),
          Column(
            children: [
              Row(
                children: [
                  Text(name),
                  Text(address),
                ],
              ),
              Text(body),
              Row(
                children: emojis
                    .map(
                      (emoji) => Text(emoji),
                    )
                    .toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
