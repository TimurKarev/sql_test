import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sql_test/src/domain/constants/available_emojis.dart';
import 'package:sql_test/src/initial_data/initial_data.dart';
import 'package:sql_test/src/presentation/model/tweet_model.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppState.fromFake(InitialData.data)) {
    // on<AppEvent>((event, emit);
  }
}
