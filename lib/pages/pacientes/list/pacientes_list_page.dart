import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coronefro/pages/admissao/list/admissoes_paciente_page.dart';
import 'package:coronefro/pages/admissao/list/bloc/admissoes_paciente_bloc.dart';
import 'package:coronefro/pages/admissao/list/bloc/bloc.dart';
import 'package:coronefro/pages/pacientes/form/paciente_form_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bloc.dart';

class PacientesListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Pacientes'),
        centerTitle: true,
      ),
      body: BlocBuilder<PacientesListBloc, PacientesListState>(
        builder: (_, state) {
          if (state is PacientesCarregadosComSucesso) {
            final pacientes = state.pacientes;
            if (pacientes.isNotEmpty) {
              return ListView.builder(
                itemBuilder: (_, i) => ListTile(
                  title: Text(pacientes[i].registro),
                  onTap: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => PacienteFormPage(paciente: pacientes[i]),
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.local_hospital, color: Colors.red),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => BlocProvider<AdmissoesPacienteBloc>(
                            create: (_) => AdmissoesPacienteBloc(
                              firestore: Firestore.instance,
                              paciente: pacientes[i],
                            )..add(CarregaAdmissoes()),
                            child: AdmissoesPacientePage(pacientes[i]),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                itemCount: pacientes.length,
              );
            } else {
              return Center(
                child: Text('Nenhum paciente foi cadastrado!'),
              );
            }
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => PacienteFormPage(),
            ),
          );
          context.bloc<PacientesListBloc>().add(CarregaPacientes());
        },
      ),
    );
  }
}
