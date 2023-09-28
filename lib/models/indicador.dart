class Indicador {
  double? indice;
  int? demandaProgramada;
  int? deamandaEspontanea;

  Indicador({this.indice, this.demandaProgramada, this.deamandaEspontanea});

  Indicador.fromJson(Map<String, dynamic> json) {
    indice = json['indice'];
    demandaProgramada = json['demandaProgramada'];
    deamandaEspontanea = json['deamandaEspontanea'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['indice'] = this.indice;
    data['demandaProgramada'] = this.demandaProgramada;
    data['deamandaEspontanea'] = this.deamandaEspontanea;
    return data;
  }
}
