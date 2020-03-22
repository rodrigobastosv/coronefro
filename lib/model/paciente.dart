class Paciente {
  Paciente({
    this.id,
    this.registro,
    this.sexo,
    this.etnia,
    this.idade,
    this.comorbidades,
    this.creatininaBasal,
    this.jaFaziaTsr,
  });

  String id;
  String registro;
  String sexo;
  String etnia;
  int idade;
  List<String> comorbidades;
  double creatininaBasal;
  String jaFaziaTsr;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'registro': registro,
      'sexo': sexo,
      'etnia': etnia,
      'idade': idade,
      'creatininaBasal': creatininaBasal,
      'comorbidades': comorbidades,
      'jaFaziaTsr': jaFaziaTsr,
    };
  }

  static Paciente fromJson(Map<String, dynamic> json) {
    return Paciente()
      ..id = json['id']
      ..registro = json['registro']
      ..sexo = json['sexo']
      ..etnia = json['etnia']
      ..idade = json['idade']
      ..creatininaBasal = json['creatininaBasal']
      ..comorbidades = (json['comorbidades'] as List<dynamic>)
          .map((c) => c.toString())
          .toList()
      ..jaFaziaTsr = json['jaFaziaTsr'];
  }

  Paciente copyWith({
    String id,
    String registro,
    String sexo,
    String etnia,
    int idade,
    List<String> comorbidades,
    double creatininaBasal,
    String jaFaziaTsr,
  }) {
    return Paciente(
      id: id ?? this.id,
      registro: registro ?? this.registro,
      sexo: sexo ?? this.sexo,
      etnia: etnia ?? this.etnia,
      idade: idade ?? this.idade,
      comorbidades: comorbidades ?? this.comorbidades,
      creatininaBasal: creatininaBasal ?? this.creatininaBasal,
      jaFaziaTsr: jaFaziaTsr ?? this.jaFaziaTsr,
    );
  }
}
