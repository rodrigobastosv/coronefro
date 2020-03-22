import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import './bloc.dart';

class PacienteFormBloc extends Bloc<PacienteFormEvent, PacienteFormState> {
  PacienteFormBloc({this.firestore});

  final Firestore firestore;

  @override
  PacienteFormState get initialState => InitialPacienteFormState();

  @override
  Stream<PacienteFormState> mapEventToState(PacienteFormEvent event) async* {
    if (event is SavePaciente) {
      try {
        final uuid = Uuid();
        final paciente = event.paciente.id == null
            ? event.paciente.copyWith(id: uuid.v1())
            : event.paciente;

        await firestore
            .collection('pacientes')
            .document(paciente.id)
            .setData(paciente.toJson());
        yield PacienteSalvo();
      } on Exception catch (e) {
        print(e);
      }
    }
  }
}
