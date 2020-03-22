import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coronefro/model/paciente.dart';
import 'package:uuid/uuid.dart';

import './bloc.dart';

class AdmissaoFormBloc extends Bloc<AdmissaoFormEvent, AdmissaoFormState> {
  AdmissaoFormBloc({this.firestore, this.paciente});

  final Firestore firestore;
  final Paciente paciente;

  @override
  AdmissaoFormState get initialState => InitialAdmissaoFormState();

  @override
  Stream<AdmissaoFormState> mapEventToState(AdmissaoFormEvent event) async* {
    if (event is SaveAdmissao) {
      yield LoadingSave();

      try {
        final uuid = Uuid();
        final admissao = event.admissao.id == null
            ? event.admissao.copyWith(id: uuid.v1())
            : event.admissao;

        await firestore
            .collection('admissoes')
            .document(paciente.id)
            .collection('admissoesPaciente')
            .document(admissao.id)
            .setData(admissao.toJson());
        yield AdmissaoSalva();
      } on Exception catch (e) {
        print(e);
      }
    }
  }
}
