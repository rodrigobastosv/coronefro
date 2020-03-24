import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coronefro/model/diario.dart';

import './bloc.dart';

class DiarioAdmissaoListBloc
    extends Bloc<DiarioAdmissaoListEvent, DiarioAdmissaoListState> {
  DiarioAdmissaoListBloc({this.firestore});

  final Firestore firestore;

  @override
  DiarioAdmissaoListState get initialState => InitialDiarioAdmissaoListState();

  @override
  Stream<DiarioAdmissaoListState> mapEventToState(
    DiarioAdmissaoListEvent event,
  ) async* {
    if (event is CarregaDiarios) {
      yield LoadingDiarios();
      try {
        final admissao = event.admissao;
        print(admissao);
        final diariosAdmissaoRef =
            firestore.collection('diarios').document(admissao.id);
        final admissoesCollectionRef =
            diariosAdmissaoRef.collection('diariosAdmissoes');
        final querySnapshot = await admissoesCollectionRef.getDocuments();
        final documents = querySnapshot.documents;
        print('ccccc');
        final diarios = List.generate(
            documents.length, (i) => Diario.fromJson(documents[i].data));
        print(diarios);
        yield DiariosCarregadosComSucesso(diarios);
      } catch (e) {
        print(e);
      }
    }
  }
}
