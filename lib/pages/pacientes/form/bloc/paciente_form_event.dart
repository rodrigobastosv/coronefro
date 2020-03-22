import 'package:coronefro/model/paciente.dart';
import 'package:equatable/equatable.dart';

abstract class PacienteFormEvent extends Equatable {
  const PacienteFormEvent();
}

class SavePaciente extends PacienteFormEvent {
  SavePaciente(this.paciente);

  final Paciente paciente;

  @override
  List<Object> get props => [paciente];
}
