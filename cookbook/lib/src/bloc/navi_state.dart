import 'package:sealed_unions/factories/nullet_factory.dart';
import 'package:sealed_unions/implementations/union_0_impl.dart';
import 'package:sealed_unions/union_0.dart';

class NaviState extends Union0Impl<_NaviSelected> {
  static final _factory = const Nullet<_NaviSelected>();

  NaviState._(Union0<_NaviSelected> union) : super(union);

  factory NaviState.selected(String title) =>
      NaviState._(_factory.first(_NaviSelected(title)));
}

class _NaviSelected {
  final String title;

  _NaviSelected(this.title);
}
