class Indicador {
  double? indice;

  Indicador({this.indice});

  Indicador.fromJson(Map<String, dynamic> json) {
    indice = json['indice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['indice'] = this.indice;
    return data;
  }
}
