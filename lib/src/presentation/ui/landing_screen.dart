import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sql_test/src/domain/constants/available_emojis.dart';
import 'package:sql_test/src/presentation/bloc/app_bloc.dart';
import 'package:sql_test/src/presentation/ui_kit/tweet.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => AppBloc(),
        child: BlocBuilder<AppBloc, AppState>(builder: (context, state) {
          return ListView.builder(
            itemCount: state.tweetList.length,
            itemBuilder: (_, index) {
              final model = state.tweetList[index];
              return Tweet(
                name: model.name,
                address: model.address,
                body: model.body,
                emojis: model.emojis.map((emoji) => emoji.unicode).toList(),
              );
            },
          );
        }),
      ),
    );
  }
}
