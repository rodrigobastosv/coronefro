import 'package:equatable/equatable.dart';

abstract class DiarioAdmissaoFormState extends Equatable {
  const DiarioAdmissaoFormState();
}

class InitialDiarioAdmissaoFormState extends DiarioAdmissaoFormState {
  @override
  List<Object> get props => [];
}

class LoadingSaveDiario extends DiarioAdmissaoFormState {
  @override
  List<Object> get props => [];
}

class DiarioSalvo extends DiarioAdmissaoFormState {
  @override
  List<Object> get props => [];
}
