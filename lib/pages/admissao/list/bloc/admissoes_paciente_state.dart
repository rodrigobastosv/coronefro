import 'package:coronefro/model/admissao.dart';
import 'package:equatable/equatable.dart';

abstract class AdmissoesPacienteState extends Equatable {
  const AdmissoesPacienteState();
}

class InitialAdmissoesPacienteState extends AdmissoesPacienteState {
  @override
  List<Object> get props => [];
}

class AdmissoesCarregadasComSucesso extends AdmissoesPacienteState {
  AdmissoesCarregadasComSucesso(this.admissoes);

  final List<Admissao> admissoes;

  @override
  List<Object> get props => [admissoes];
}

class LoadingAdmissoes extends AdmissoesPacienteState {
  @override
  List<Object> get props => [];
}
