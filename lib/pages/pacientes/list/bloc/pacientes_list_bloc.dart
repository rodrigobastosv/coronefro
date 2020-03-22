import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coronefro/model/paciente.dart';

import 'bloc.dart';

class PacientesListBloc extends Bloc<PacientesListEvent, PacientesListState> {
  PacientesListBloc({this.firestore});

  final Firestore firestore;

  @override
  PacientesListState get initialState => InitialPacientesListState();

  @override
  Stream<PacientesListState> mapEventToState(PacientesListEvent event) async* {
    if (event is CarregaPacientes) {
      try {
        final pacientesRef = firestore.collection('pacientes');
        final pacientesDocs = await pacientesRef.getDocuments();
        final docsSnapshots = pacientesDocs.documents;
        final pacientes = List.generate(docsSnapshots.length,
            (i) => Paciente.fromJson(docsSnapshots[i].data));
        yield PacientesCarregadosComSucesso(pacientes);
      } catch (e) {
        print(e);
      }
    }
  }
}
