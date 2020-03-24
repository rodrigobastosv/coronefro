import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coronefro/model/diario.dart';
import 'package:uuid/uuid.dart';

import './bloc.dart';
import '../../../../model/admissao.dart';

class DiarioAdmissaoFormBloc
    extends Bloc<DiarioAdmissaoFormEvent, DiarioAdmissaoFormState> {
  DiarioAdmissaoFormBloc({this.firestore, this.admissao, this.diario});

  final Firestore firestore;
  final Admissao admissao;
  final Diario diario;

  @override
  DiarioAdmissaoFormState get initialState => InitialDiarioAdmissaoFormState();

  @override
  Stream<DiarioAdmissaoFormState> mapEventToState(
      DiarioAdmissaoFormEvent event) async* {
    if (event is SaveDiario) {
      yield LoadingSaveDiario();

      try {
        final uuid = Uuid();
        final diario = event.diario.id == null
            ? event.diario.copyWith(id: uuid.v1())
            : event.diario;

        await firestore
            .collection('diarios')
            .document(admissao.id)
            .collection('diariosAdmissoes')
            .document(diario.id)
            .setData(diario.toJson());
        yield DiarioSalvo();
      } on Exception catch (e) {
        print(e);
      }
    }
  }
}
