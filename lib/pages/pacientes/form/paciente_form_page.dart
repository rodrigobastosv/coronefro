import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coronefro/model/opcao.dart';
import 'package:coronefro/model/paciente.dart';
import 'package:coronefro/pages/pacientes/form/bloc/bloc.dart';
import 'package:coronefro/widget/combobox.dart';
import 'package:coronefro/widget/multiple_combobox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PacienteFormPage extends StatefulWidget {
  PacienteFormPage({this.paciente});

  final Paciente paciente;

  @override
  _PacienteFormPageState createState() => _PacienteFormPageState();
}

class _PacienteFormPageState extends State<PacienteFormPage> {
  GlobalKey<FormState> _formKey;
  String _id;
  String _registro;
  String _sexo;
  String _etnia;
  int _idade;
  double _creatininaBasal;
  List<String> _comorbidades;
  String _jaFaziaStr;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    if (widget.paciente != null) {
      final paciente = widget.paciente;
      _id = paciente.id;
      _registro = paciente.registro;
      _sexo = paciente.sexo;
      _etnia = paciente.etnia;
      _idade = paciente.idade;
      _creatininaBasal = paciente.creatininaBasal;
      _comorbidades = paciente.comorbidades;
      _jaFaziaStr = paciente.jaFaziaTsr;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PacienteFormBloc(
        firestore: Firestore.instance,
      ),
      child: Builder(
        builder: (_) => Scaffold(
          appBar: AppBar(
            title: Text('Cadastro de Paciente'),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.save),
                onPressed: () {
                  final form = _formKey.currentState;
                  if (form.validate()) {
                    form.save();
                    final paciente = Paciente(
                      id: _id,
                      registro: _registro,
                      sexo: _sexo,
                      etnia: _etnia,
                      idade: _idade,
                      creatininaBasal: _creatininaBasal,
                      comorbidades: _comorbidades,
                      jaFaziaTsr: _jaFaziaStr,
                    );
                    _.bloc<PacienteFormBloc>().add(SavePaciente(paciente));
                  }
                },
              )
            ],
          ),
          body: SingleChildScrollView(
            child: BlocListener<PacienteFormBloc, PacienteFormState>(
              listener: (_, state) {
                if (state is PacienteSalvo) {
                  Navigator.of(context).pop();
                }
              },
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Registro',
                        ),
                        initialValue: _registro,
                        validator: (registro) =>
                            registro.isEmpty ? 'Campo Obrigatório' : null,
                        onSaved: (registro) => _registro = registro,
                      ),
                      SizedBox(height: 8),
                      Combobox<Opcao>(
                        labelText: 'Sexo',
                        onValueSelected: (sexo) => _sexo = sexo.value,
                        initialValue: _sexo != null ? Opcao(_sexo) : null,
                        values: [
                          Opcao('Masculino'),
                          Opcao('Feminino'),
                        ],
                      ),
                      SizedBox(height: 8),
                      Combobox<Opcao>(
                        labelText: 'Etnia',
                        onValueSelected: (etnia) => _etnia = etnia.value,
                        initialValue: _etnia != null ? Opcao(_etnia) : null,
                        values: [
                          Opcao('Branco'),
                          Opcao('Negro'),
                          Opcao('Pardo'),
                          Opcao('Asiático'),
                        ],
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Idade',
                        ),
                        initialValue: _idade?.toString() ?? null,
                        keyboardType: TextInputType.number,
                        validator: (idadeText) {
                          int idade = int.tryParse(idadeText);
                          if (idade == null) {
                            return 'Idade inválida';
                          }
                          return idadeText.isEmpty ? 'Campo Obrigatório' : null;
                        },
                        onSaved: (idade) => _idade = int.parse(idade),
                      ),
                      SizedBox(height: 8),
                      MultipleCombobox<Opcao>(
                        labelText: 'Comorbidades',
                        onValuesSelected: (comorbidades) => _comorbidades =
                            comorbidades.map((c) => c.value).toList(),
                        initialValues: _comorbidades,
                        values: [
                          Opcao('HAS'),
                          Opcao('DM'),
                          Opcao('NEO ATIVA'),
                          Opcao('NEO PRÉVIA'),
                          Opcao('DPOC'),
                          Opcao('DRC'),
                          Opcao('CIRROSE'),
                          Opcao('ALCOLISTA'),
                          Opcao('TABAGISTA'),
                          Opcao('AVE PRÉVIO'),
                          Opcao('IAM PRÉVIO'),
                          Opcao('DCA ATEROSCLEROTICA'),
                        ],
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Creatinina Basal',
                        ),
                        keyboardType: TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        initialValue: _creatininaBasal?.toString() ?? null,
                        validator: (valueText) {
                          double creatininaBasal = double.tryParse(valueText);
                          if (creatininaBasal == null) {
                            return 'Valor inválido';
                          }
                          return valueText.isEmpty ? 'Campo Obrigatório' : null;
                        },
                        onSaved: (creatininaBasal) =>
                            _creatininaBasal = double.parse(creatininaBasal),
                      ),
                      SizedBox(height: 8),
                      Combobox<Opcao>(
                        labelText: 'Já fazia TSR?',
                        onValueSelected: (jaFaziaStr) =>
                            _jaFaziaStr = jaFaziaStr.value,
                        initialValue:
                            _jaFaziaStr != null ? Opcao(_jaFaziaStr) : null,
                        values: [
                          Opcao('NÃO'),
                          Opcao('HD'),
                          Opcao('PD'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
