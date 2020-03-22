import 'package:equatable/equatable.dart';

abstract class AdmissoesPacienteEvent extends Equatable {
  const AdmissoesPacienteEvent();
}

class CarregaAdmissoes extends AdmissoesPacienteEvent {
  @override
  List<Object> get props => [];
}
