import 'package:coronefro/model/admissao.dart';
import 'package:equatable/equatable.dart';

abstract class AdmissaoFormEvent extends Equatable {
  const AdmissaoFormEvent();
}

class SaveAdmissao extends AdmissaoFormEvent {
  SaveAdmissao(this.admissao);

  final Admissao admissao;

  @override
  List<Object> get props => [admissao];
}
