class ListaAgendamentos {
  List<Lista>? agendamentos;

  ListaAgendamentos({this.agendamentos});

  ListaAgendamentos.fromJson(Map<String, dynamic> json) {
    if (json['agendamentos'] != null) {
      agendamentos = <Lista>[];
      json['agendamentos'].forEach((v) {
        agendamentos!.add(new Lista.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.agendamentos != null) {
      data['agendamentos'] = this.agendamentos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Lista {
  String? dtAgenda;
  List<Agendamentos>? agendamentos;

  Lista({this.dtAgenda, this.agendamentos});

  Lista.fromJson(Map<String, dynamic> json) {
    dtAgenda = json['dtAgenda'];
    if (json['agendamentos'] != null) {
      agendamentos = <Agendamentos>[];
      json['agendamentos'].forEach((v) {
        agendamentos!.add(new Agendamentos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dtAgenda'] = this.dtAgenda;
    if (this.agendamentos != null) {
      data['agendamentos'] = this.agendamentos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Agendamentos {
  int? id;
  String? nome;
  String? cpf;
  double? imc;
  String? classImc;
  String? dtAgenda;
  String? hrAgenda;
  String? unidadeSaude;
  String? dsCBO;
  String? nmProfSaude;
  bool? pushSent;

  Agendamentos({
    this.id,
    this.nome,
    this.cpf,
    this.imc,
    this.classImc,
    this.dtAgenda,
    this.hrAgenda,
    this.unidadeSaude,
    this.dsCBO,
    this.nmProfSaude,
    this.pushSent,
  });

  Agendamentos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    cpf = json['cpf'];
    imc = json['imc'];
    classImc = json['classImc'];
    dtAgenda = json['dtAgenda'];
    hrAgenda = json['hrAgenda'];
    unidadeSaude = json['unidadeSaude'];
    dsCBO = json['dsCBO'];
    nmProfSaude = json['nmProfSaude'];
    pushSent = json['pushSent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['cpf'] = this.cpf;
    data['imc'] = this.imc;
    data['classImc'] = this.classImc;
    data['dtAgenda'] = this.dtAgenda;
    data['hrAgenda'] = this.hrAgenda;
    data['unidadeSaude'] = this.unidadeSaude;
    data['dsCBO'] = this.dsCBO;
    data['nmProfSaude'] = this.nmProfSaude;
    data['pushSent'] = this.pushSent;
    return data;
  }
}
