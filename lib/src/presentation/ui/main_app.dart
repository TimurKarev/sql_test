import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sql_test/src/presentation/ui/landing_screen.dart';
import 'package:sql_test/src/repository/sql/sql_tweet_api.dart';

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RepositoryProvider(
        create: (context) => SqlTweetApi(),
        child: const LandingScreen(),
      ),
    );
  }
}
