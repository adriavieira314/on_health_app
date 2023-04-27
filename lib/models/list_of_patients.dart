class Patient {
  String? name;
  double? imc;
  int? age;
  int? confirmation;

  Patient({this.name, this.imc, this.age, this.confirmation});

  Patient.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    imc = json['imc'];
    age = json['age'];
    confirmation = json['confirmation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['imc'] = imc;
    data['age'] = age;
    data['confirmation'] = confirmation;
    return data;
  }
}

class ListOfPatients {
  String? date;
  List<Patient?>? patients;
  bool? isExpanded;

  ListOfPatients({this.date, this.patients, this.isExpanded = true});

  ListOfPatients.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    if (json['patients'] != null) {
      patients = <Patient>[];
      json['patients'].forEach((v) {
        patients!.add(Patient.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['patients'] =
        patients != null ? patients!.map((v) => v?.toJson()).toList() : null;
    return data;
  }
}
