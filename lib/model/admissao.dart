import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Admissao {
  String id;
  DateTime dataInternamentoHC;
  DateTime dataInicioNefro;
  DateTime dataColetaPu;
  List<String> queixas;
  int diasAtePrimeirosSintomas;
  double creatininaAdmissao;
  double cruzesPta;
  double cruzesHb;
  double leuco;
  double erit;
  double rpc;
  double rac;
  String chegouEmIot;
  List<String> medicacoes;
  String puColetadoAntesInclusao;
  String emUsoSvdColetaPu;

  Admissao({
    this.id,
    @required this.dataInternamentoHC,
    @required this.dataInicioNefro,
    @required this.dataColetaPu,
    @required this.queixas,
    @required this.diasAtePrimeirosSintomas,
    @required this.creatininaAdmissao,
    @required this.cruzesPta,
    @required this.cruzesHb,
    @required this.leuco,
    @required this.erit,
    @required this.rpc,
    @required this.rac,
    @required this.chegouEmIot,
    @required this.medicacoes,
    @required this.puColetadoAntesInclusao,
    @required this.emUsoSvdColetaPu,
  });

  @override
  String toString() {
    return 'Admissao{' +
        ' id: $id,' +
        ' dataInternamentoHC: $dataInternamentoHC,' +
        ' dataInicioNefro: $dataInicioNefro,' +
        ' dataColetaPu: $dataColetaPu,' +
        ' queixas: $queixas,' +
        ' diasAtePrimeirosSintomas: $diasAtePrimeirosSintomas,' +
        ' creatininaAdmissao: $creatininaAdmissao,' +
        ' cruzesPta: $cruzesPta,' +
        ' cruzesHb: $cruzesHb,' +
        ' leuco: $leuco,' +
        ' erit: $erit,' +
        ' rpc: $rpc,' +
        ' rac: $rac,' +
        ' chegouEmIot: $chegouEmIot,' +
        ' medicacoes: $medicacoes,' +
        ' puColetadoAntesInclusao: $puColetadoAntesInclusao,' +
        ' emUsoSvdColetaPu: $emUsoSvdColetaPu,' +
        '}';
  }

  Admissao copyWith({
    String id,
    DateTime dataInternamentoHC,
    DateTime dataInicioNefro,
    DateTime dataColetaPu,
    List<String> queixas,
    int diasAtePrimeirosSintomas,
    double creatininaAdmissao,
    double cruzesPta,
    double cruzesHb,
    double leuco,
    double erit,
    double rpc,
    double rac,
    String chegouEmIot,
    List<String> medicacoes,
    String puColetadoAntesInclusao,
    String emUsoSvdColetaPu,
  }) {
    return Admissao(
      id: id ?? this.id,
      dataInternamentoHC: dataInternamentoHC ?? this.dataInternamentoHC,
      dataInicioNefro: dataInicioNefro ?? this.dataInicioNefro,
      dataColetaPu: dataColetaPu ?? this.dataColetaPu,
      queixas: queixas ?? this.queixas,
      diasAtePrimeirosSintomas:
          diasAtePrimeirosSintomas ?? this.diasAtePrimeirosSintomas,
      creatininaAdmissao: creatininaAdmissao ?? this.creatininaAdmissao,
      cruzesPta: cruzesPta ?? this.cruzesPta,
      cruzesHb: cruzesHb ?? this.cruzesHb,
      leuco: leuco ?? this.leuco,
      erit: erit ?? this.erit,
      rpc: rpc ?? this.rpc,
      rac: rac ?? this.rac,
      chegouEmIot: chegouEmIot ?? this.chegouEmIot,
      medicacoes: medicacoes ?? this.medicacoes,
      puColetadoAntesInclusao:
          puColetadoAntesInclusao ?? this.puColetadoAntesInclusao,
      emUsoSvdColetaPu: emUsoSvdColetaPu ?? this.emUsoSvdColetaPu,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'dataInternamentoHC': this.dataInternamentoHC,
      'dataInicioNefro': this.dataInicioNefro,
      'dataColetaPu': this.dataColetaPu,
      'queixas': this.queixas,
      'diasAtePrimeirosSintomas': this.diasAtePrimeirosSintomas,
      'creatininaAdmissao': this.creatininaAdmissao,
      'cruzesPta': this.cruzesPta,
      'cruzesHb': this.cruzesHb,
      'leuco': this.leuco,
      'erit': this.erit,
      'rpc': this.rpc,
      'rac': this.rac,
      'chegouEmIot': this.chegouEmIot,
      'medicacoes': this.medicacoes,
      'puColetadoAntesInclusao': this.puColetadoAntesInclusao,
      'emUsoSvdColetaPu': this.emUsoSvdColetaPu,
    };
  }

  factory Admissao.fromJson(Map<String, dynamic> json) {
    return Admissao(
      id: json['id'] as String,
      dataInternamentoHC: json['dataInternamentoHC'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              (json['dataInternamentoHC'] as Timestamp).millisecondsSinceEpoch)
          : null,
      dataInicioNefro: json['dataInicioNefro'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              (json['dataInicioNefro'] as Timestamp).millisecondsSinceEpoch)
          : null,
      dataColetaPu: json['dataColetaPu'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              (json['dataColetaPu'] as Timestamp).millisecondsSinceEpoch)
          : null,
      queixas:
          (json['queixas'] as List<dynamic>).map((c) => c.toString()).toList(),
      diasAtePrimeirosSintomas: json['diasAtePrimeirosSintomas'] as int,
      creatininaAdmissao: json['creatininaAdmissao'] as double,
      cruzesPta: json['cruzesPta'] as double,
      cruzesHb: json['cruzesHb'] as double,
      leuco: json['leuco'] as double,
      erit: json['erit'] as double,
      rpc: json['rpc'] as double,
      rac: json['rac'] as double,
      chegouEmIot: json['chegouEmIot'] as String,
      medicacoes: (json['medicacoes'] as List<dynamic>)
          .map((c) => c.toString())
          .toList(),
      puColetadoAntesInclusao: json['puColetadoAntesInclusao'] as String,
      emUsoSvdColetaPu: json['emUsoSvdColetaPu'] as String,
    );
  }
}
