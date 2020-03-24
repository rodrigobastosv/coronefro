import 'package:coronefro/pages/diario_admissao/form/diario_admissao_form_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../model/admissao.dart';
import 'bloc/bloc.dart';

class DiarioAdmissaoListPage extends StatelessWidget {
  DiarioAdmissaoListPage(this.admissao);

  final _dateFormat = DateFormat("dd-MM-yyyy");
  final Admissao admissao;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diário da Admissao: ${admissao.id}'),
      ),
      body: BlocBuilder<DiarioAdmissaoListBloc, DiarioAdmissaoListState>(
        builder: (_, state) {
          if (state is DiariosCarregadosComSucesso) {
            final diarios = state.diarios;
            return ListView.builder(
              itemBuilder: (_, i) => ListTile(
                title: Text('Data: ${_dateFormat.format(diarios[i].data)}'),
              ),
              itemCount: diarios.length,
            );
          } else if (state is LoadingDiarios) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return SizedBox.shrink();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => DiarioAdmissaoFormPage(admissao),
            ),
          );
          context.bloc<DiarioAdmissaoListBloc>().add(CarregaDiarios(admissao));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
