import 'package:coronefro/model/paciente.dart';
import 'package:equatable/equatable.dart';

abstract class PacientesListState extends Equatable {
  const PacientesListState();
}

class InitialPacientesListState extends PacientesListState {
  @override
  List<Object> get props => [];
}

class PacientesCarregadosComSucesso extends PacientesListState {
  PacientesCarregadosComSucesso(this.pacientes);

  final List<Paciente> pacientes;

  @override
  List<Object> get props => [pacientes];
}
