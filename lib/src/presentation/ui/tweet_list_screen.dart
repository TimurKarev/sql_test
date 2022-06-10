import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sql_test/src/presentation/bloc/app_bloc.dart';
import 'package:sql_test/src/presentation/ui_kit/tweet.dart';

class TweetListScreen extends StatelessWidget {
  const TweetListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        if (state is LoadedState) {
          final tweetList = state.tweetList;

          return ListView.builder(
            itemCount: state.tweets.length,
            itemBuilder: (_, index) {
              final model = tweetList[index];

              return InkWell(
                onTap: () => context.read<AppBloc>().add(
                      TweetPressedEvent(
                        tweetId: model.id,
                      ),
                    ),
                child: Tweet(
                  name: model.name,
                  address: model.address,
                  body: model.body,
                  emojis: model.emojis.toList(),
                  isActive: model.id == state.tweetId,
                ),
              );
            },
          );
        } else if (state is ErrorState) {
          return Center(
            child: Text(
              'Fatal Error, please reload (((',
              style: Theme.of(context).textTheme.headline6,
            ),
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
