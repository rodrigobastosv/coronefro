import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coronefro/model/diario.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../model/admissao.dart';
import '../../../model/opcao.dart';
import '../../../widget/combobox.dart';
import '../../../widget/multiple_combobox.dart';
import 'bloc/bloc.dart';

class DiarioAdmissaoFormPage extends StatefulWidget {
  DiarioAdmissaoFormPage(this.admissao);

  final Admissao admissao;

  @override
  _DiarioAdmissaoFormPageState createState() => _DiarioAdmissaoFormPageState();
}

class _DiarioAdmissaoFormPageState extends State<DiarioAdmissaoFormPage> {
  final _dateFormat = DateFormat("dd-MM-yyyy");
  TextEditingController dataController;

  GlobalKey<FormState> _formKey;
  DateTime _data;
  double _paSistolica;
  double _paDiastolica;
  double _ckdEpi;
  double _hb;
  double _leuco;
  double _linfo;
  double _creatinina;
  double _ureia;
  double _potassio;
  double _ph;
  double _bic;
  double _pco2;
  double _tgo;
  double _tgp;
  double _albumina;
  double _lactato;
  double _pcr;
  double _vhs;
  double _scoreSofa;
  double _cruzesPta;
  double _cruzesHb;
  double _erit;
  double _rpc;
  double _rac;
  double _tempo;
  double _fluxo;
  double _uf;
  String _emUsoDva;
  String _vazaoNoradrenalina;
  String _vazaoVaropressina;
  String _vazaoDobutamina;
  String _vazaoTridil;
  String _pacienteUrinando;
  String _pacienteSuporteO2;
  String _lraKdigo;
  String _usoSvd;
  String _hdHoje;
  String _qualHd;
  String _tolerouDialise;
  String _naoRealizouHd;
  List<String> _medicacoes;

  @override
  void initState() {
    dataController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    dataController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DiarioAdmissaoFormBloc>(
      create: (_) => DiarioAdmissaoFormBloc(
        firestore: Firestore.instance,
        admissao: widget.admissao,
        diario: null,
      ),
      child: Scaffold(
        body: Builder(
          builder: (_) =>
              BlocConsumer<DiarioAdmissaoFormBloc, DiarioAdmissaoFormState>(
            listener: (_, state) {
              if (state is DiarioSalvo) {
                Get.snackbar('Admissão salva!', '');
                Navigator.of(_).pop();
              }
            },
            builder: (_, state) {
              if (state is InitialDiarioAdmissaoFormState) {
                return Scaffold(
                  appBar: AppBar(
                    title: Text('Cadastro de Diário'),
                    centerTitle: true,
                    actions: <Widget>[
                      IconButton(
                        icon: Icon(Icons.save),
                        onPressed: () {
                          final form = _formKey.currentState;
                          print(form);
                          if (form.validate()) {
                            form.save();
                            final diario = Diario(
                              albumina: _albumina,
                              bic: _bic,
                              ckdEpi: _ckdEpi,
                              creatinina: _creatinina,
                              cruzesHb: _cruzesHb,
                              cruzesPta: _cruzesPta,
                              data: _data,
                              emUsoDva: _emUsoDva,
                              erit: _erit,
                              fluxo: _fluxo,
                              hb: _hb,
                              hdHoje: _hdHoje,
                              lactato: _lactato,
                              leuco: _leuco,
                              linfo: _linfo,
                              lraKdigo: _lraKdigo,
                              medicacoes: _medicacoes,
                              naoRealizouHd: _naoRealizouHd,
                              pacienteSuporteO2: _pacienteSuporteO2,
                              pacienteUrinando: _pacienteUrinando,
                              paDiastolica: _paDiastolica,
                              paSistolica: _paSistolica,
                              pco2: _pco2,
                              pcr: _pcr,
                              ph: _ph,
                              potassio: _potassio,
                              qualHd: _qualHd,
                              rac: _rac,
                              rpc: _rpc,
                              scoreSofa: _scoreSofa,
                              tempo: _tempo,
                              tgo: _tgo,
                              tgp: _tgp,
                              tolerouDialise: _tolerouDialise,
                              uf: _uf,
                              ureia: _ureia,
                              usoSvd: _usoSvd,
                              vazaoDobutamina: _vazaoDobutamina,
                              vazaoNoradrenalina: _vazaoNoradrenalina,
                              vazaoTridil: _vazaoTridil,
                              vazaoVaropressina: _vazaoVaropressina,
                              vhs: _vhs,
                            );
                            _
                                .bloc<DiarioAdmissaoFormBloc>()
                                .add(SaveDiario(diario));
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
                                      _data = date;
                                      dataController.text =
                                          _dateFormat.format(date);
                                    });
                                  },
                                  currentTime: DateTime.now(),
                                  locale: LocaleType.pt,
                                );
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Data',
                                labelText: 'Data',
                              ),
                              controller: dataController,
                              validator: (data) =>
                                  data.isEmpty ? 'Campo Obrigatório' : null,
                            ),
                            SizedBox(height: 8),
                            TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'PA Sistólica',
                              ),
                              keyboardType: TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              initialValue: _paSistolica?.toString() ?? null,
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
                              onSaved: (paSistolica) =>
                                  _paSistolica = double.parse(paSistolica),
                            ),
                            SizedBox(height: 8),
                            TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'PA Diastólica',
                              ),
                              keyboardType: TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              initialValue: _paDiastolica?.toString() ?? null,
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
                              onSaved: (paDiastolica) =>
                                  _paDiastolica = double.parse(paDiastolica),
                            ),
                            SizedBox(height: 8),
                            Combobox<Opcao>(
                              labelText: 'Paciente em uso de DVA?',
                              onValueSelected: (emUsoDva) =>
                                  _emUsoDva = emUsoDva.value,
                              initialValue:
                                  _emUsoDva != null ? Opcao(_emUsoDva) : null,
                              values: [
                                Opcao('SIM'),
                                Opcao('NÂO'),
                              ],
                            ),
                            SizedBox(height: 8),
                            Combobox<Opcao>(
                              labelText: 'Vazão Noradrenalina',
                              onValueSelected: (vazaoNoradrenalina) =>
                                  _vazaoNoradrenalina =
                                      vazaoNoradrenalina.value,
                              initialValue: _vazaoNoradrenalina != null
                                  ? Opcao(_vazaoNoradrenalina)
                                  : null,
                              values: [
                                Opcao('Zero'),
                                Opcao('Até 10ML/H'),
                                Opcao('10-20ML/H'),
                                Opcao('> 20ML/H'),
                              ],
                            ),
                            SizedBox(height: 8),
                            Combobox<Opcao>(
                              labelText: 'Vazão Varopressina',
                              onValueSelected: (vazaoVaropressina) =>
                                  _vazaoVaropressina = vazaoVaropressina.value,
                              initialValue: _vazaoVaropressina != null
                                  ? Opcao(_vazaoVaropressina)
                                  : null,
                              values: [
                                Opcao('Zero'),
                                Opcao('Até 10ML/H'),
                                Opcao('10-20ML/H'),
                                Opcao('> 20ML/H'),
                              ],
                            ),
                            SizedBox(height: 8),
                            Combobox<Opcao>(
                              labelText: 'Vazão Dobutamina',
                              onValueSelected: (vazaoDobutamina) =>
                                  _vazaoDobutamina = vazaoDobutamina.value,
                              initialValue: _vazaoDobutamina != null
                                  ? Opcao(_vazaoDobutamina)
                                  : null,
                              values: [
                                Opcao('Zero'),
                                Opcao('Até 10ML/H'),
                                Opcao('10-20ML/H'),
                                Opcao('> 20ML/H'),
                              ],
                            ),
                            SizedBox(height: 8),
                            Combobox<Opcao>(
                              labelText: 'Vazão Tridil',
                              onValueSelected: (vazaoTridil) =>
                                  _vazaoTridil = vazaoTridil.value,
                              initialValue: _vazaoTridil != null
                                  ? Opcao(_vazaoTridil)
                                  : null,
                              values: [
                                Opcao('Zero'),
                                Opcao('Até 10ML/H'),
                                Opcao('10-20ML/H'),
                                Opcao('> 20ML/H'),
                              ],
                            ),
                            SizedBox(height: 8),
                            Combobox<Opcao>(
                              labelText: 'Paciente Urinando',
                              onValueSelected: (pacienteUrinando) =>
                                  _pacienteUrinando = pacienteUrinando.value,
                              initialValue: _pacienteUrinando != null
                                  ? Opcao(_pacienteUrinando)
                                  : null,
                              values: [
                                Opcao('> 500ML'),
                                Opcao('< 500ML'),
                                Opcao('Anúrico'),
                              ],
                            ),
                            SizedBox(height: 8),
                            Combobox<Opcao>(
                              labelText: 'Paciente com suporte de O2',
                              onValueSelected: (pacienteSuporteO2) =>
                                  _pacienteSuporteO2 = pacienteSuporteO2.value,
                              initialValue: _pacienteSuporteO2 != null
                                  ? Opcao(_pacienteSuporteO2)
                                  : null,
                              values: [
                                Opcao('Não'),
                                Opcao('Suporte NI'),
                                Opcao('IOT'),
                              ],
                            ),
                            SizedBox(height: 8),
                            Combobox<Opcao>(
                              labelText: 'LRA KDIGO',
                              onValueSelected: (lraKdigo) =>
                                  _lraKdigo = lraKdigo.value,
                              initialValue:
                                  _lraKdigo != null ? Opcao(_lraKdigo) : null,
                              values: [
                                Opcao('1'),
                                Opcao('2'),
                                Opcao('3'),
                              ],
                            ),
                            SizedBox(height: 8),
                            TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'CKD EPI',
                              ),
                              keyboardType: TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              initialValue: _ckdEpi?.toString() ?? null,
                              validator: (valueText) {
                                double ckdEpi = double.tryParse(valueText);
                                if (ckdEpi == null) {
                                  return 'Valor inválido';
                                }
                                return valueText.isEmpty
                                    ? 'Campo Obrigatório'
                                    : null;
                              },
                              onSaved: (ckdEpi) =>
                                  _ckdEpi = double.parse(ckdEpi),
                            ),
                            SizedBox(height: 8),
                            TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'HB',
                              ),
                              keyboardType: TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              initialValue: _hb?.toString() ?? null,
                              validator: (valueText) {
                                double hb = double.tryParse(valueText);
                                if (hb == null) {
                                  return 'Valor inválido';
                                }
                                return valueText.isEmpty
                                    ? 'Campo Obrigatório'
                                    : null;
                              },
                              onSaved: (hb) => _hb = double.parse(hb),
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
                                double leuco = double.tryParse(valueText);
                                if (leuco == null) {
                                  return 'Valor inválido';
                                }
                                return valueText.isEmpty
                                    ? 'Campo Obrigatório'
                                    : null;
                              },
                              onSaved: (leuco) => _leuco = double.parse(leuco),
                            ),
                            SizedBox(height: 8),
                            TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Linfo',
                              ),
                              keyboardType: TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              initialValue: _linfo?.toString() ?? null,
                              validator: (valueText) {
                                double linfo = double.tryParse(valueText);
                                if (linfo == null) {
                                  return 'Valor inválido';
                                }
                                return valueText.isEmpty
                                    ? 'Campo Obrigatório'
                                    : null;
                              },
                              onSaved: (linfo) => _linfo = double.parse(linfo),
                            ),
                            SizedBox(height: 8),
                            TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Creatinina',
                              ),
                              keyboardType: TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              initialValue: _creatinina?.toString() ?? null,
                              validator: (valueText) {
                                double creatinina = double.tryParse(valueText);
                                if (creatinina == null) {
                                  return 'Valor inválido';
                                }
                                return valueText.isEmpty
                                    ? 'Campo Obrigatório'
                                    : null;
                              },
                              onSaved: (creatinina) =>
                                  _creatinina = double.parse(creatinina),
                            ),
                            SizedBox(height: 8),
                            TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Ureia',
                              ),
                              keyboardType: TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              initialValue: _ureia?.toString() ?? null,
                              validator: (valueText) {
                                double ureia = double.tryParse(valueText);
                                if (ureia == null) {
                                  return 'Valor inválido';
                                }
                                return valueText.isEmpty
                                    ? 'Campo Obrigatório'
                                    : null;
                              },
                              onSaved: (ureia) => _ureia = double.parse(ureia),
                            ),
                            SizedBox(height: 8),
                            TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Potássio',
                              ),
                              keyboardType: TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              initialValue: _potassio?.toString() ?? null,
                              validator: (valueText) {
                                double potassio = double.tryParse(valueText);
                                if (potassio == null) {
                                  return 'Valor inválido';
                                }
                                return valueText.isEmpty
                                    ? 'Campo Obrigatório'
                                    : null;
                              },
                              onSaved: (potassio) =>
                                  _potassio = double.parse(potassio),
                            ),
                            SizedBox(height: 8),
                            TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'PH',
                              ),
                              keyboardType: TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              initialValue: _ph?.toString() ?? null,
                              validator: (valueText) {
                                double ph = double.tryParse(valueText);
                                if (ph == null) {
                                  return 'Valor inválido';
                                }
                                return valueText.isEmpty
                                    ? 'Campo Obrigatório'
                                    : null;
                              },
                              onSaved: (ph) => _ph = double.parse(ph),
                            ),
                            SizedBox(height: 8),
                            TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'BIC',
                              ),
                              keyboardType: TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              initialValue: _bic?.toString() ?? null,
                              validator: (valueText) {
                                double bic = double.tryParse(valueText);
                                if (bic == null) {
                                  return 'Valor inválido';
                                }
                                return valueText.isEmpty
                                    ? 'Campo Obrigatório'
                                    : null;
                              },
                              onSaved: (bic) => _bic = double.parse(bic),
                            ),
                            SizedBox(height: 8),
                            TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'PCO2',
                              ),
                              keyboardType: TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              initialValue: _pco2?.toString() ?? null,
                              validator: (valueText) {
                                double pco2 = double.tryParse(valueText);
                                if (pco2 == null) {
                                  return 'Valor inválido';
                                }
                                return valueText.isEmpty
                                    ? 'Campo Obrigatório'
                                    : null;
                              },
                              onSaved: (pco2) => _pco2 = double.parse(pco2),
                            ),
                            SizedBox(height: 8),
                            TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'TGO',
                              ),
                              keyboardType: TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              initialValue: _tgo?.toString() ?? null,
                              validator: (valueText) {
                                double tgo = double.tryParse(valueText);
                                if (tgo == null) {
                                  return 'Valor inválido';
                                }
                                return valueText.isEmpty
                                    ? 'Campo Obrigatório'
                                    : null;
                              },
                              onSaved: (tgo) => _tgo = double.parse(tgo),
                            ),
                            SizedBox(height: 8),
                            TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'TGP',
                              ),
                              keyboardType: TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              initialValue: _tgp?.toString() ?? null,
                              validator: (valueText) {
                                double tgp = double.tryParse(valueText);
                                if (tgp == null) {
                                  return 'Valor inválido';
                                }
                                return valueText.isEmpty
                                    ? 'Campo Obrigatório'
                                    : null;
                              },
                              onSaved: (tgp) => _tgp = double.parse(tgp),
                            ),
                            SizedBox(height: 8),
                            TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Albumina',
                              ),
                              keyboardType: TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              initialValue: _albumina?.toString() ?? null,
                              validator: (valueText) {
                                double albumina = double.tryParse(valueText);
                                if (albumina == null) {
                                  return 'Valor inválido';
                                }
                                return valueText.isEmpty
                                    ? 'Campo Obrigatório'
                                    : null;
                              },
                              onSaved: (albumina) =>
                                  _albumina = double.parse(albumina),
                            ),
                            SizedBox(height: 8),
                            TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Lactato',
                              ),
                              keyboardType: TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              initialValue: _lactato?.toString() ?? null,
                              validator: (valueText) {
                                double lactato = double.tryParse(valueText);
                                if (lactato == null) {
                                  return 'Valor inválido';
                                }
                                return valueText.isEmpty
                                    ? 'Campo Obrigatório'
                                    : null;
                              },
                              onSaved: (lactato) =>
                                  _lactato = double.parse(lactato),
                            ),
                            SizedBox(height: 8),
                            TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'PCR',
                              ),
                              keyboardType: TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              initialValue: _pcr?.toString() ?? null,
                              validator: (valueText) {
                                double pcr = double.tryParse(valueText);
                                if (pcr == null) {
                                  return 'Valor inválido';
                                }
                                return valueText.isEmpty
                                    ? 'Campo Obrigatório'
                                    : null;
                              },
                              onSaved: (pcr) => _pcr = double.parse(pcr),
                            ),
                            SizedBox(height: 8),
                            TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'VHS',
                              ),
                              keyboardType: TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              initialValue: _vhs?.toString() ?? null,
                              validator: (valueText) {
                                double vhs = double.tryParse(valueText);
                                if (vhs == null) {
                                  return 'Valor inválido';
                                }
                                return valueText.isEmpty
                                    ? 'Campo Obrigatório'
                                    : null;
                              },
                              onSaved: (vhs) => _vhs = double.parse(vhs),
                            ),
                            SizedBox(height: 8),
                            TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Score de Sofa',
                              ),
                              keyboardType: TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              initialValue: _scoreSofa?.toString() ?? null,
                              validator: (valueText) {
                                double scoreSofa = double.tryParse(valueText);
                                if (scoreSofa == null) {
                                  return 'Valor inválido';
                                }
                                return valueText.isEmpty
                                    ? 'Campo Obrigatório'
                                    : null;
                              },
                              onSaved: (scoreSofa) =>
                                  _scoreSofa = double.parse(scoreSofa),
                            ),
                            SizedBox(height: 8),
                            Combobox<Opcao>(
                              labelText: 'Paciente em uso de SVD',
                              onValueSelected: (usoSvd) =>
                                  _usoSvd = usoSvd.value,
                              initialValue:
                                  _usoSvd != null ? Opcao(_usoSvd) : null,
                              values: [
                                Opcao('Sim'),
                                Opcao('Não'),
                              ],
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
                                double cruzesPta = double.tryParse(valueText);
                                if (cruzesPta == null) {
                                  return 'Valor inválido';
                                }
                                return valueText.isEmpty
                                    ? 'Campo Obrigatório'
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
                                double cruzesHb = double.tryParse(valueText);
                                if (cruzesHb == null) {
                                  return 'Valor inválido';
                                }
                                return valueText.isEmpty
                                    ? 'Campo Obrigatório'
                                    : null;
                              },
                              onSaved: (cruzesHb) =>
                                  _cruzesHb = double.parse(cruzesHb),
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
                                double erit = double.tryParse(valueText);
                                if (erit == null) {
                                  return 'Valor inválido';
                                }
                                return valueText.isEmpty
                                    ? 'Campo Obrigatório'
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
                                double rpc = double.tryParse(valueText);
                                if (rpc == null) {
                                  return 'Valor inválido';
                                }
                                return valueText.isEmpty
                                    ? 'Campo Obrigatório'
                                    : null;
                              },
                              onSaved: (rpc) => _rpc = double.parse(rpc),
                            ),
                            SizedBox(height: 8),
                            TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'RAC',
                              ),
                              keyboardType: TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              initialValue: _rac?.toString() ?? null,
                              validator: (valueText) {
                                double rac = double.tryParse(valueText);
                                if (rac == null) {
                                  return 'Valor inválido';
                                }
                                return valueText.isEmpty
                                    ? 'Campo Obrigatório'
                                    : null;
                              },
                              onSaved: (rac) => _rac = double.parse(rac),
                            ),
                            SizedBox(height: 8),
                            MultipleCombobox<Opcao>(
                              labelText: 'Medicações do paciente',
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
                              labelText: 'Realizou HD hoje?',
                              onValueSelected: (hdHoje) =>
                                  _hdHoje = hdHoje.value,
                              initialValue:
                                  _hdHoje != null ? Opcao(_hdHoje) : null,
                              values: [
                                Opcao('Sim'),
                                Opcao('Não'),
                              ],
                            ),
                            SizedBox(height: 8),
                            Combobox<Opcao>(
                              labelText: 'Qual HD foi realizado?',
                              onValueSelected: (qualHd) =>
                                  _qualHd = qualHd.value,
                              initialValue:
                                  _qualHd != null ? Opcao(_qualHd) : null,
                              values: [
                                Opcao('HDC'),
                                Opcao('SLED'),
                                Opcao('UF I'),
                                Opcao('CRRT'),
                              ],
                            ),
                            SizedBox(height: 8),
                            TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Tempo',
                              ),
                              keyboardType: TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              initialValue: _tempo?.toString() ?? null,
                              validator: (valueText) {
                                double tempo = double.tryParse(valueText);
                                if (tempo == null) {
                                  return 'Valor inválido';
                                }
                                return valueText.isEmpty
                                    ? 'Campo Obrigatório'
                                    : null;
                              },
                              onSaved: (tempo) => _tempo = double.parse(tempo),
                            ),
                            SizedBox(height: 8),
                            TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Fluxo',
                              ),
                              keyboardType: TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              initialValue: _fluxo?.toString() ?? null,
                              validator: (valueText) {
                                double fluxo = double.tryParse(valueText);
                                if (fluxo == null) {
                                  return 'Valor inválido';
                                }
                                return valueText.isEmpty
                                    ? 'Campo Obrigatório'
                                    : null;
                              },
                              onSaved: (fluxo) => _fluxo = double.parse(fluxo),
                            ),
                            SizedBox(height: 8),
                            TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'UF',
                              ),
                              keyboardType: TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              initialValue: _uf?.toString() ?? null,
                              validator: (valueText) {
                                double uf = double.tryParse(valueText);
                                if (uf == null) {
                                  return 'Valor inválido';
                                }
                                return valueText.isEmpty
                                    ? 'Campo Obrigatório'
                                    : null;
                              },
                              onSaved: (uf) => _uf = double.parse(uf),
                            ),
                            SizedBox(height: 8),
                            Combobox<Opcao>(
                              labelText: 'Tolerou a diálise?',
                              onValueSelected: (tolerouDialise) =>
                                  _tolerouDialise = tolerouDialise.value,
                              initialValue: _tolerouDialise != null
                                  ? Opcao(_tolerouDialise)
                                  : null,
                              values: [
                                Opcao('Sim'),
                                Opcao('Redução Fluxo'),
                                Opcao('Redução UF'),
                                Opcao('Sessão Suspensa'),
                              ],
                            ),
                            SizedBox(height: 8),
                            Combobox<Opcao>(
                              labelText: 'Não realizou HD hoje?',
                              onValueSelected: (naoRealizouHd) =>
                                  _naoRealizouHd = naoRealizouHd.value,
                              initialValue: _naoRealizouHd != null
                                  ? Opcao(_naoRealizouHd)
                                  : null,
                              values: [
                                Opcao('Sem indicação'),
                                Opcao('Instab Hemod'),
                                Opcao('Limitação Suporte'),
                                Opcao('Melhora Clínica'),
                                Opcao('Óbito'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
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
