import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sql_test/src/presentation/bloc/app_bloc.dart';
import 'package:sql_test/src/presentation/ui/app_bar_emoji_piker.dart';
import 'package:sql_test/src/presentation/ui/tweet_list_screen.dart';
import 'package:sql_test/src/repository/sql/sql_tweet_repository.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppBloc(RepositoryProvider.of<SqlTweetRepository>(context)),
      child: const Scaffold(
        body: SafeArea(
          child: TweetListScreen(),
        ),
        bottomNavigationBar: AppBarEmojiPicker(),
      ),
    );
  }
}
