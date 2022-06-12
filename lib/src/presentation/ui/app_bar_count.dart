import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sql_test/src/presentation/bloc/app_bloc.dart';
import 'package:sql_test/src/presentation/constants/ui_constant.dart';

///AppBar with emoji counter
///strong dependency to AppBloc
class AppBarCount extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => const Size(
        double.infinity,
        UiConstant.appBarCountHeight,
      );

  const AppBarCount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: BlocBuilder<AppBloc, AppState>(
        builder: (_, state) {
          if (state is LoadedState) {
            return Center(
              child: Text(
                'Emojis number: ${state.emojiNum.toString()}',
              ),
            );
          }

          return AppBar();
        },
      ),
    );
  }
}
