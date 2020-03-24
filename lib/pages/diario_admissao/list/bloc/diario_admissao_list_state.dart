import 'package:coronefro/model/diario.dart';
import 'package:equatable/equatable.dart';

abstract class DiarioAdmissaoListState extends Equatable {
  const DiarioAdmissaoListState();
}

class InitialDiarioAdmissaoListState extends DiarioAdmissaoListState {
  @override
  List<Object> get props => [];
}

class LoadingDiarios extends DiarioAdmissaoListState {
  @override
  List<Object> get props => [];
}

class DiariosCarregadosComSucesso extends DiarioAdmissaoListState {
  DiariosCarregadosComSucesso(this.diarios);

  final List<Diario> diarios;

  @override
  List<Object> get props => [diarios];
}
