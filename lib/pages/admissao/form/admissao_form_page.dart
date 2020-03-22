import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coronefro/model/admissao.dart';
import 'package:coronefro/model/opcao.dart';
import 'package:coronefro/model/paciente.dart';
import 'package:coronefro/pages/admissao/form/bloc/admissao_form_bloc.dart';
import 'package:coronefro/pages/admissao/form/bloc/admissao_form_event.dart';
import 'package:coronefro/widget/combobox.dart';
import 'package:coronefro/widget/multiple_combobox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'bloc/bloc.dart';

class AdmissaoFormPage extends StatefulWidget {
  AdmissaoFormPage(this.paciente);

  final Paciente paciente;

  @override
  _AdmissaoFormPageState createState() => _AdmissaoFormPageState();
}

class _AdmissaoFormPageState extends State<AdmissaoFormPage> {
  GlobalKey<FormState> _formKey;
  final _dateFormat = DateFormat("dd-MM-yyyy");
  TextEditingController dataInternamentoHCController;
  TextEditingController dataInicioNefroController;
  TextEditingController dataColetaPuController;

  DateTime _dataInternamentoHC;
  DateTime _dataInicioNefro;
  DateTime _dataColetaPu;
  List<String> _queixas;
  int _diasAtePrimeirosSintomas;
  double _creatininaAdmissao;
  double _cruzesPta;
  double _cruzesHb;
  double _leuco;
  double _erit;
  double _rpc;
  double _rac;
  String _chegouEmIot;
  List<String> _medicacoes;
  String _puColetadoAntesInclusao;
  String _emUsoSvdColetaPu;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    dataInternamentoHCController = TextEditingController();
    dataInicioNefroController = TextEditingController();
    dataColetaPuController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    dataInternamentoHCController.dispose();
    dataInicioNefroController.dispose();
    dataColetaPuController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AdmissaoFormBloc>(
      create: (_) => AdmissaoFormBloc(
        firestore: Firestore.instance,
        paciente: widget.paciente,
      ),
      child: Scaffold(
        body: Builder(
          builder: (_) => BlocConsumer<AdmissaoFormBloc, AdmissaoFormState>(
            listener: (_, state) {
              if (state is AdmissaoSalva) {
                Get.snackbar('Admissão salva!', '');
                Navigator.of(_).pop();
              }
            },
            builder: (_, state) {
              if (state is InitialAdmissaoFormState) {
                return Scaffold(
                  appBar: AppBar(
                    title: Text('Cadastro de Admissão'),
                    centerTitle: true,
                    actions: <Widget>[
                      IconButton(
                        icon: Icon(Icons.save),
                        onPressed: () {
                          final form = _formKey.currentState;
                          print(form);
                          if (form.validate()) {
                            form.save();
                            final admissao = Admissao(
                              chegouEmIot: _chegouEmIot,
                              creatininaAdmissao: _creatininaAdmissao,
                              cruzesHb: _cruzesHb,
                              cruzesPta: _cruzesPta,
                              dataColetaPu: _dataColetaPu,
                              dataInicioNefro: _dataInicioNefro,
                              dataInternamentoHC: _dataInternamentoHC,
                              diasAtePrimeirosSintomas:
                                  _diasAtePrimeirosSintomas,
                              emUsoSvdColetaPu: _emUsoSvdColetaPu,
                              erit: _erit,
                              leuco: _leuco,
                              medicacoes: _medicacoes,
                              puColetadoAntesInclusao: _puColetadoAntesInclusao,
                              queixas: _queixas,
                              rac: _rac,
                              rpc: _rpc,
                            );
                            _
                                .bloc<AdmissaoFormBloc>()
                                .add(SaveAdmissao(admissao));
                          }
                        },
                      )
                    ],
                  ),
                  body: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              onTap: () {
                                DatePicker.showDateTimePicker(
                                  context,
                                  showTitleActions: true,
                                  onConfirm: (date) {
                                    setState(() {
                                      _dataInternamentoHC = date;
                                      dataInternamentoHCController.text =
                                          _dateFormat.format(date);
                                    });
                                  },
                                  currentTime: DateTime.now(),
                                  locale: LocaleType.pt,
                                );
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Data do internamento no HC',
                                labelText: 'Data do internamento no HC',
                              ),
                              controller: dataInternamentoHCController,
                              validator: (data) =>
                                  data.isEmpty ? 'Campo Obrigatório' : null,
                            ),
                            SizedBox(height: 8),
                            TextFormField(
                              onTap: () {
                                DatePicker.showDateTimePicker(
                                  context,
                                  showTitleActions: true,
                                  onConfirm: (date) {
                                    setState(() {
                                      _dataInicioNefro = date;
                                      dataInicioNefroController.text =
                                          _dateFormat.format(date);
                                    });
                                  },
                                  currentTime: DateTime.now(),
                                  locale: LocaleType.pt,
                                );
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText:
                                    'Data do inicio do acompanhamento com Nefro',
                                labelText:
                                    'Data do inicio do acompanhamento com Nefro',
                              ),
                              controller: dataInicioNefroController,
                              validator: (data) =>
                                  data.isEmpty ? 'Campo Obrigatório' : null,
                            ),
                            SizedBox(height: 8),
                            MultipleCombobox<Opcao>(
                              labelText: 'Queixas do paciente',
                              onValuesSelected: (queixas) => _queixas =
                                  queixas.map((c) => c.value).toList(),
                              initialValues: _queixas,
                              values: [
                                Opcao('Febre'),
                                Opcao('Dispneia'),
                                Opcao('Tosse'),
                                Opcao('Sintomas VAS'),
                                Opcao('Mialgia'),
                              ],
                            ),
                            SizedBox(height: 8),
                            TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText:
                                    'Dias até surgirem sintomas após admissão?',
                              ),
                              keyboardType: TextInputType.number,
                              initialValue:
                                  _diasAtePrimeirosSintomas?.toString() ?? null,
                              validator: (valueText) {
                                int diasAtePrimeirosSintomas =
                                    int.tryParse(valueText);
                                if (diasAtePrimeirosSintomas == null) {
                                  return 'Valor inválido';
                                }
                                return valueText.isEmpty
                                    ? 'Campo Obrigatório'
                                    : null;
                              },
                              onSaved: (diasAtePrimeirosSintomas) =>
                                  _diasAtePrimeirosSintomas =
                                      int.parse(diasAtePrimeirosSintomas),
                            ),
                            SizedBox(height: 8),
                            TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Creatinina da Admissão',
                              ),
                              keyboardType: TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              initialValue:
                                  _creatininaAdmissao?.toString() ?? null,
                              validator: (valueText) {
                                double creatininaAdmissao =
                                    double.tryParse(valueText);
                                if (creatininaAdmissao == null) {
                                  return 'Valor inválido';
                                }
                                return valueText.isEmpty
                                    ? 'Campo Obrigatório'
                                    : null;
                              },
                              onSaved: (creatininaAdmissao) =>
                                  _creatininaAdmissao =
                                      double.parse(creatininaAdmissao),
                            ),
                            SizedBox(height: 8),
                            Combobox<Opcao>(
                              labelText: 'Paciente chegou em IOT?',
                              onValueSelected: (chegouEmIot) =>
                                  _chegouEmIot = chegouEmIot.value,
                              initialValue: _chegouEmIot != null
                                  ? Opcao(_chegouEmIot)
                                  : null,
                              values: [
                                Opcao('SIM'),
                                Opcao('NÂO'),
                              ],
                            ),
                            SizedBox(height: 8),
                            MultipleCombobox<Opcao>(
                              labelText: 'Medicações utilizadas',
                              onValuesSelected: (medicacoes) => _medicacoes =
                                  medicacoes.map((c) => c.value).toList(),
                              initialValues: _medicacoes,
                              values: [
                                Opcao('IECA'),
                                Opcao('BRA'),
                                Opcao('CTC'),
                                Opcao('ATB'),
                                Opcao('FSM'),
                                Opcao('HCQ'),
                                Opcao('CLOROQ'),
                                Opcao('AZITRO'),
                              ],
                            ),
                            SizedBox(height: 8),
                            Combobox<Opcao>(
                              labelText: 'PU foi coletado antes da inclusão?',
                              onValueSelected: (puColetadoAntesInclusao) =>
                                  _puColetadoAntesInclusao =
                                      puColetadoAntesInclusao.value,
                              initialValue: _puColetadoAntesInclusao != null
                                  ? Opcao(_puColetadoAntesInclusao)
                                  : null,
                              values: [
                                Opcao('SIM'),
                                Opcao('NÂO'),
                              ],
                            ),
                            SizedBox(height: 8),
                            TextFormField(
                              onTap: () {
                                DatePicker.showDateTimePicker(
                                  context,
                                  showTitleActions: true,
                                  onConfirm: (date) {
                                    setState(() {
                                      _dataColetaPu = date;
                                      dataColetaPuController.text =
                                          _dateFormat.format(date);
                                    });
                                  },
                                  currentTime: DateTime.now(),
                                  locale: LocaleType.pt,
                                );
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Data da coleta do PU',
                                labelText: 'Data da coleta do PU',
                              ),
                              controller: dataColetaPuController,
                            ),
                            SizedBox(height: 8),
                            TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Cruzes PTA',
                              ),
                              keyboardType: TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              initialValue: _cruzesPta?.toString() ?? null,
                              validator: (valueText) {
                                return double.tryParse(valueText) == null
                                    ? 'Valor inválido'
                                    : null;
                              },
                              onSaved: (cruzesPta) =>
                                  _cruzesPta = double.parse(cruzesPta),
                            ),
                            SizedBox(height: 8),
                            TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Cruzes HB',
                              ),
                              keyboardType: TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              initialValue: _cruzesHb?.toString() ?? null,
                              validator: (valueText) {
                                return double.tryParse(valueText) == null
                                    ? 'Valor inválido'
                                    : null;
                              },
                              onSaved: (cruzesHb) =>
                                  _cruzesHb = double.parse(cruzesHb),
                            ),
                            SizedBox(height: 8),
                            TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Leuco',
                              ),
                              keyboardType: TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              initialValue: _leuco?.toString() ?? null,
                              validator: (valueText) {
                                return double.tryParse(valueText) == null
                                    ? 'Valor inválido'
                                    : null;
                              },
                              onSaved: (leuco) => _leuco = double.parse(leuco),
                            ),
                            SizedBox(height: 8),
                            TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Erit',
                              ),
                              keyboardType: TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              initialValue: _erit?.toString() ?? null,
                              validator: (valueText) {
                                return double.tryParse(valueText) == null
                                    ? 'Valor inválido'
                                    : null;
                              },
                              onSaved: (erit) => _erit = double.parse(erit),
                            ),
                            SizedBox(height: 8),
                            TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'RPC',
                              ),
                              keyboardType: TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              initialValue: _rpc?.toString() ?? null,
                              validator: (valueText) {
                                return double.tryParse(valueText) == null
                                    ? 'Valor inválido'
                                    : null;
                              },
                              onSaved: (rpc) => _rpc = double.parse(rpc),
                            ),
                            SizedBox(height: 8),
                            TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'RPC',
                              ),
                              keyboardType: TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              initialValue: _rac?.toString() ?? null,
                              validator: (valueText) {
                                return double.tryParse(valueText) == null
                                    ? 'Valor inválido'
                                    : null;
                              },
                              onSaved: (rac) => _rac = double.parse(rac),
                            ),
                            SizedBox(height: 8),
                            Combobox<Opcao>(
                              labelText:
                                  'Paciente em uso de SVD quando coletou PU?',
                              onValueSelected: (emUsoSvdColetaPu) =>
                                  _emUsoSvdColetaPu = emUsoSvdColetaPu.value,
                              initialValue: _emUsoSvdColetaPu != null
                                  ? Opcao(_emUsoSvdColetaPu)
                                  : null,
                              values: [
                                Opcao('SIM'),
                                Opcao('NÂO'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              } else if (state is LoadingSave) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }
}
