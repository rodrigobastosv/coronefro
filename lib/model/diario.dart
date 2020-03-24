import 'package:cloud_firestore/cloud_firestore.dart';

class Diario {
  String id;
  DateTime data;
  double paSistolica;
  double paDiastolica;
  double ckdEpi;
  double hb;
  double leuco;
  double linfo;
  double creatinina;
  double ureia;
  double potassio;
  double ph;
  double bic;
  double pco2;
  double tgo;
  double tgp;
  double albumina;
  double lactato;
  double pcr;
  double vhs;
  double scoreSofa;
  double cruzesPta;
  double cruzesHb;
  double erit;
  double rpc;
  double rac;
  double tempo;
  double fluxo;
  double uf;
  String emUsoDva;
  String vazaoNoradrenalina;
  String vazaoVaropressina;
  String vazaoDobutamina;
  String vazaoTridil;
  String pacienteUrinando;
  String pacienteSuporteO2;
  String lraKdigo;
  String usoSvd;
  String hdHoje;
  String qualHd;
  String tolerouDialise;
  String naoRealizouHd;
  List<String> medicacoes;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  Diario({
    this.id,
    this.data,
    this.paSistolica,
    this.paDiastolica,
    this.ckdEpi,
    this.hb,
    this.leuco,
    this.linfo,
    this.creatinina,
    this.ureia,
    this.potassio,
    this.ph,
    this.bic,
    this.pco2,
    this.tgo,
    this.tgp,
    this.albumina,
    this.lactato,
    this.pcr,
    this.vhs,
    this.scoreSofa,
    this.cruzesPta,
    this.cruzesHb,
    this.erit,
    this.rpc,
    this.rac,
    this.tempo,
    this.fluxo,
    this.uf,
    this.emUsoDva,
    this.vazaoNoradrenalina,
    this.vazaoVaropressina,
    this.vazaoDobutamina,
    this.vazaoTridil,
    this.pacienteUrinando,
    this.pacienteSuporteO2,
    this.lraKdigo,
    this.usoSvd,
    this.hdHoje,
    this.qualHd,
    this.tolerouDialise,
    this.naoRealizouHd,
    this.medicacoes,
  });

  @override
  String toString() {
    return 'Diario{' +
        ' data: $data,' +
        ' paSistolica: $paSistolica,' +
        ' paDiastolica: $paDiastolica,' +
        ' ckdEpi: $ckdEpi,' +
        ' hb: $hb,' +
        ' leuco: $leuco,' +
        ' linfo: $linfo,' +
        ' creatinina: $creatinina,' +
        ' ureia: $ureia,' +
        ' potassio: $potassio,' +
        ' ph: $ph,' +
        ' bic: $bic,' +
        ' pco2: $pco2,' +
        ' tgo: $tgo,' +
        ' tgp: $tgp,' +
        ' albumina: $albumina,' +
        ' lactato: $lactato,' +
        ' pcr: $pcr,' +
        ' vhs: $vhs,' +
        ' scoreSofa: $scoreSofa,' +
        ' cruzesPta: $cruzesPta,' +
        ' cruzesHb: $cruzesHb,' +
        ' erit: $erit,' +
        ' rpc: $rpc,' +
        ' rac: $rac,' +
        ' tempo: $tempo,' +
        ' fluxo: $fluxo,' +
        ' uf: $uf,' +
        ' emUsoDva: $emUsoDva,' +
        ' vazaoNoradrenalina: $vazaoNoradrenalina,' +
        ' vazaoVaropressina: $vazaoVaropressina,' +
        ' vazaoDobutamina: $vazaoDobutamina,' +
        ' vazaoTridil: $vazaoTridil,' +
        ' pacienteUrinando: $pacienteUrinando,' +
        ' pacienteSuporteO2: $pacienteSuporteO2,' +
        ' lraKdigo: $lraKdigo,' +
        ' usoSvd: $usoSvd,' +
        ' hdHoje: $hdHoje,' +
        ' qualHd: $qualHd,' +
        ' tolerouDialise: $tolerouDialise,' +
        ' naoRealizouHd: $naoRealizouHd,' +
        ' medicacoes: $medicacoes,' +
        '}';
  }

  Diario copyWith({
    String id,
    DateTime data,
    double paSistolica,
    double paDiastolica,
    double ckdEpi,
    double hb,
    double leuco,
    double linfo,
    double creatinina,
    double ureia,
    double potassio,
    double ph,
    double bic,
    double pco2,
    double tgo,
    double tgp,
    double albumina,
    double lactato,
    double pcr,
    double vhs,
    double scoreSofa,
    double cruzesPta,
    double cruzesHb,
    double erit,
    double rpc,
    double rac,
    double tempo,
    double fluxo,
    double uf,
    String emUsoDva,
    String vazaoNoradrenalina,
    String vazaoVaropressina,
    String vazaoDobutamina,
    String vazaoTridil,
    String pacienteUrinando,
    String pacienteSuporteO2,
    String lraKdigo,
    String usoSvd,
    String hdHoje,
    String qualHd,
    String tolerouDialise,
    String naoRealizouHd,
    List<String> medicacoes,
  }) {
    return Diario(
      id: id ?? this.id,
      data: data ?? this.data,
      paSistolica: paSistolica ?? this.paSistolica,
      paDiastolica: paDiastolica ?? this.paDiastolica,
      ckdEpi: ckdEpi ?? this.ckdEpi,
      hb: hb ?? this.hb,
      leuco: leuco ?? this.leuco,
      linfo: linfo ?? this.linfo,
      creatinina: creatinina ?? this.creatinina,
      ureia: ureia ?? this.ureia,
      potassio: potassio ?? this.potassio,
      ph: ph ?? this.ph,
      bic: bic ?? this.bic,
      pco2: pco2 ?? this.pco2,
      tgo: tgo ?? this.tgo,
      tgp: tgp ?? this.tgp,
      albumina: albumina ?? this.albumina,
      lactato: lactato ?? this.lactato,
      pcr: pcr ?? this.pcr,
      vhs: vhs ?? this.vhs,
      scoreSofa: scoreSofa ?? this.scoreSofa,
      cruzesPta: cruzesPta ?? this.cruzesPta,
      cruzesHb: cruzesHb ?? this.cruzesHb,
      erit: erit ?? this.erit,
      rpc: rpc ?? this.rpc,
      rac: rac ?? this.rac,
      tempo: tempo ?? this.tempo,
      fluxo: fluxo ?? this.fluxo,
      uf: uf ?? this.uf,
      emUsoDva: emUsoDva ?? this.emUsoDva,
      vazaoNoradrenalina: vazaoNoradrenalina ?? this.vazaoNoradrenalina,
      vazaoVaropressina: vazaoVaropressina ?? this.vazaoVaropressina,
      vazaoDobutamina: vazaoDobutamina ?? this.vazaoDobutamina,
      vazaoTridil: vazaoTridil ?? this.vazaoTridil,
      pacienteUrinando: pacienteUrinando ?? this.pacienteUrinando,
      pacienteSuporteO2: pacienteSuporteO2 ?? this.pacienteSuporteO2,
      lraKdigo: lraKdigo ?? this.lraKdigo,
      usoSvd: usoSvd ?? this.usoSvd,
      hdHoje: hdHoje ?? this.hdHoje,
      qualHd: qualHd ?? this.qualHd,
      tolerouDialise: tolerouDialise ?? this.tolerouDialise,
      naoRealizouHd: naoRealizouHd ?? this.naoRealizouHd,
      medicacoes: medicacoes ?? this.medicacoes,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'data': this.data,
      'paSistolica': this.paSistolica,
      'paDiastolica': this.paDiastolica,
      'ckdEpi': this.ckdEpi,
      'hb': this.hb,
      'leuco': this.leuco,
      'linfo': this.linfo,
      'creatinina': this.creatinina,
      'ureia': this.ureia,
      'potassio': this.potassio,
      'ph': this.ph,
      'bic': this.bic,
      'pco2': this.pco2,
      'tgo': this.tgo,
      'tgp': this.tgp,
      'albumina': this.albumina,
      'lactato': this.lactato,
      'pcr': this.pcr,
      'vhs': this.vhs,
      'scoreSofa': this.scoreSofa,
      'cruzesPta': this.cruzesPta,
      'cruzesHb': this.cruzesHb,
      'erit': this.erit,
      'rpc': this.rpc,
      'rac': this.rac,
      'tempo': this.tempo,
      'fluxo': this.fluxo,
      'uf': this.uf,
      'emUsoDva': this.emUsoDva,
      'vazaoNoradrenalina': this.vazaoNoradrenalina,
      'vazaoVaropressina': this.vazaoVaropressina,
      'vazaoDobutamina': this.vazaoDobutamina,
      'vazaoTridil': this.vazaoTridil,
      'pacienteUrinando': this.pacienteUrinando,
      'pacienteSuporteO2': this.pacienteSuporteO2,
      'lraKdigo': this.lraKdigo,
      'usoSvd': this.usoSvd,
      'hdHoje': this.hdHoje,
      'qualHd': this.qualHd,
      'tolerouDialise': this.tolerouDialise,
      'naoRealizouHd': this.naoRealizouHd,
      'medicacoes': this.medicacoes,
    };
  }

  factory Diario.fromJson(Map<String, dynamic> json) {
    return Diario(
      id: json['id'] as String,
      data: json['data'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              (json['data'] as Timestamp).millisecondsSinceEpoch)
          : null,
      paSistolica: json['paSistolica'] as double,
      paDiastolica: json['paDiastolica'] as double,
      ckdEpi: json['ckdEpi'] as double,
      hb: json['hb'] as double,
      leuco: json['leuco'] as double,
      linfo: json['linfo'] as double,
      creatinina: json['creatinina'] as double,
      ureia: json['ureia'] as double,
      potassio: json['potassio'] as double,
      ph: json['ph'] as double,
      bic: json['bic'] as double,
      pco2: json['pco2'] as double,
      tgo: json['tgo'] as double,
      tgp: json['tgp'] as double,
      albumina: json['albumina'] as double,
      lactato: json['lactato'] as double,
      pcr: json['pcr'] as double,
      vhs: json['vhs'] as double,
      scoreSofa: json['scoreSofa'] as double,
      cruzesPta: json['cruzesPta'] as double,
      cruzesHb: json['cruzesHb'] as double,
      erit: json['erit'] as double,
      rpc: json['rpc'] as double,
      rac: json['rac'] as double,
      tempo: json['tempo'] as double,
      fluxo: json['fluxo'] as double,
      uf: json['uf'] as double,
      emUsoDva: json['emUsoDva'] as String,
      vazaoNoradrenalina: json['vazaoNoradrenalina'] as String,
      vazaoVaropressina: json['vazaoVaropressina'] as String,
      vazaoDobutamina: json['vazaoDobutamina'] as String,
      vazaoTridil: json['vazaoTridil'] as String,
      pacienteUrinando: json['pacienteUrinando'] as String,
      pacienteSuporteO2: json['pacienteSuporteO2'] as String,
      lraKdigo: json['lraKdigo'] as String,
      usoSvd: json['usoSvd'] as String,
      hdHoje: json['hdHoje'] as String,
      qualHd: json['qualHd'] as String,
      tolerouDialise: json['tolerouDialise'] as String,
      naoRealizouHd: json['naoRealizouHd'] as String,
      medicacoes: json['medicacoes'] != null
          ? (json['medicacoes'] as List<dynamic>)
              .map((c) => c.toString())
              .toList()
          : [],
    );
  }
}
