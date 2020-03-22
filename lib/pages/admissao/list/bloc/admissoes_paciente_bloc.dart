import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coronefro/model/admissao.dart';
import 'package:coronefro/model/paciente.dart';

import './bloc.dart';

class AdmissoesPacienteBloc
    extends Bloc<AdmissoesPacienteEvent, AdmissoesPacienteState> {
  AdmissoesPacienteBloc({this.firestore, this.paciente});

  final Firestore firestore;
  final Paciente paciente;

  @override
  AdmissoesPacienteState get initialState => InitialAdmissoesPacienteState();

  @override
  Stream<AdmissoesPacienteState> mapEventToState(
      AdmissoesPacienteEvent event) async* {
    if (event is CarregaAdmissoes) {
      yield LoadingAdmissoes();
      try {
        final admissoesPacienteRef =
            firestore.collection('admissoes').document(paciente.id);
        final admissoesCollectionRef =
            admissoesPacienteRef.collection('admissoesPaciente');
        final querySnapshot = await admissoesCollectionRef.getDocuments();
        final documents = querySnapshot.documents;
        final admissoes = List.generate(
            documents.length, (i) => Admissao.fromJson(documents[i].data));
        yield AdmissoesCarregadasComSucesso(admissoes);
      } catch (e) {
        print(e);
      }
    }
  }
}
