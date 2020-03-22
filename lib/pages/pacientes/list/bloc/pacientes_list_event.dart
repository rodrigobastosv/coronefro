import 'package:equatable/equatable.dart';

abstract class PacientesListEvent extends Equatable {
  const PacientesListEvent();
}

class CarregaPacientes extends PacientesListEvent {
  @override
  List<Object> get props => [];
}
