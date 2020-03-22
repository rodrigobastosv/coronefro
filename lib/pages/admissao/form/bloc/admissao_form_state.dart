import 'package:equatable/equatable.dart';

abstract class AdmissaoFormState extends Equatable {
  const AdmissaoFormState();
}

class InitialAdmissaoFormState extends AdmissaoFormState {
  @override
  List<Object> get props => [];
}

class AdmissaoSalva extends AdmissaoFormState {
  @override
  List<Object> get props => [];
}

class LoadingSave extends AdmissaoFormState {
  @override
  List<Object> get props => [];
}
