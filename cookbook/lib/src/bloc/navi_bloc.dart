// abstract class BCardEvent {}

// class LaunchEvent extends BCardEvent {
//   final BCardData data;

//   LaunchEvent(this.data);
// }

// class BCardBloc extends Bloc<BCardEvent, BCardData> {
//   @override
//   BCardData get initialState => BCardData.list.first;

//   @override
//   Stream<BCardData> mapEventToState(BCardEvent event) async* {
//     if (event is LaunchEvent) {
//       yield event.data;
//     }
//   }
// }
import 'package:bloc/bloc.dart';

import 'package:cookbook/src/bloc/navi_state.dart';

class NaviBloc extends Bloc<NaviState, NaviState> {
  @override
  NaviState get initialState => NaviState.selected('title');

  @override
  Stream<NaviState> mapEventToState(NaviState event) async* {
    yield event.join((selected) => NaviState.selected(selected.title));
  }
}
