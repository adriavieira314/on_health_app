class ListaMunicipios {
  List<Municipios>? municipios;

  ListaMunicipios({this.municipios});

  ListaMunicipios.fromJson(Map<String, dynamic> json) {
    if (json['municipios'] != null) {
      municipios = <Municipios>[];
      json['municipios'].forEach((v) {
        municipios!.add(new Municipios.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.municipios != null) {
      data['municipios'] = this.municipios!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Municipios {
  String? id;
  String? municipio;

  Municipios({this.id, this.municipio});

  Municipios.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    municipio = json['municipio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['municipio'] = this.municipio;
    return data;
  }
}
