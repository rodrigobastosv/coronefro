import 'package:coronefro/model/paciente.dart';
import 'package:coronefro/pages/admissao/form/admissao_form_page.dart';
import 'package:coronefro/pages/admissao/list/bloc/admissoes_paciente_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'bloc/bloc.dart';

class AdmissoesPacientePage extends StatelessWidget {
  AdmissoesPacientePage(this.paciente);

  final _dateFormat = DateFormat("dd-MM-yyyy");
  final Paciente paciente;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admissões do Paciente: ${paciente.registro}'),
      ),
      body: BlocBuilder<AdmissoesPacienteBloc, AdmissoesPacienteState>(
        builder: (_, state) {
          if (state is AdmissoesCarregadasComSucesso) {
            final admissoes = state.admissoes;
            return ListView.builder(
              itemBuilder: (_, i) => ListTile(
                title: Text(
                    'Data de admissão: ${_dateFormat.format(admissoes[i].dataInternamentoHC)}'),
                subtitle: Text(
                    'Data Inicio Nefro: ${_dateFormat.format(admissoes[i].dataInicioNefro)}'),
              ),
              itemCount: admissoes.length,
            );
          } else if (state is LoadingAdmissoes) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return SizedBox.shrink();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => AdmissaoFormPage(paciente),
            ),
          );
          context.bloc<AdmissoesPacienteBloc>().add(CarregaAdmissoes());
        },
      ),
    );
  }
}
