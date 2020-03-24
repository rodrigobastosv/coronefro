import 'package:equatable/equatable.dart';

import '../../../../model/admissao.dart';

abstract class DiarioAdmissaoListEvent extends Equatable {
  const DiarioAdmissaoListEvent();
}

class CarregaDiarios extends DiarioAdmissaoListEvent {
  CarregaDiarios(this.admissao);

  final Admissao admissao;

  @override
  List<Object> get props => [admissao];
}
