import 'package:equatable/equatable.dart';

abstract class PacienteFormState extends Equatable {
  const PacienteFormState();
}

class InitialPacienteFormState extends PacienteFormState {
  @override
  List<Object> get props => [];
}

class FormIniciadoComSucesso extends PacienteFormState {
  @override
  List<Object> get props => [];
}

class PacienteSalvo extends PacienteFormState {
  @override
  List<Object> get props => [];
}
