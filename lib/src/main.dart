import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sql_test/src/presentation/bloc/app_bloc_observer.dart';
import 'package:sql_test/src/presentation/ui/main_app.dart';

//TODO: add logging and bloc Observer
void main() {
  runZonedGuarded(
    () async {
      await BlocOverrides.runZoned(
        () async => runApp(
          const MainApp(),
        ),
        blocObserver: AppBlocObserver(),
      );
    },
    (error, stackTrace) => print('${error.toString()} \n ${stackTrace.toString()}'),
  );
}
