import 'package:bloc/bloc.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cookbook/src/model/bcard_data.dart';
import 'package:flutter/cupertino.dart';

abstract class BCardEvent {}

class LaunchEvent extends BCardEvent {
  final BCardData data;

  LaunchEvent(this.data);
}

class BCardBloc extends Bloc<BCardEvent, BCardData> {
  @override
  BCardData get initialState => BCardData.list.first;

  @override
  Stream<BCardData> mapEventToState(BCardEvent event) async* {
    if (event is LaunchEvent) {
      yield event.data;
    }
  }
}
