import 'package:coronefro/model/diario.dart';
import 'package:equatable/equatable.dart';

abstract class DiarioAdmissaoFormEvent extends Equatable {
  const DiarioAdmissaoFormEvent();
}

class SaveDiario extends DiarioAdmissaoFormEvent {
  SaveDiario(this.diario);

  final Diario diario;

  @override
  List<Object> get props => [diario];
}
