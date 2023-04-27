import 'package:flutter/material.dart';
import 'package:on_health_app/components/app_bar_component.dart';
import 'package:on_health_app/components/app_drawer.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

class Patient {
  String? name;
  double? imc;
  int? age;

  Patient({this.name, this.imc, this.age});

  Patient.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    imc = json['imc'];
    age = json['age'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['imc'] = imc;
    data['age'] = age;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['date'] = date;
    data['patients'] =
        patients != null ? patients!.map((v) => v?.toJson()).toList() : null;
    return data;
  }
}

List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
      headerValue: 'Panel $index',
      expandedValue: 'This is item number $index',
    );
  });
}

class _HomeAdminState extends State<HomeAdmin> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Item> _data = generateItems(3);
  final List<ListOfPatients> _agendamentos = [
    ListOfPatients(
      date: "15/03/2023",
      patients: [
        Patient(age: 25, name: 'Adria Vieira Lima', imc: 29.0),
        Patient(age: 30, name: 'Adria Vieira Lima', imc: 29.0),
      ],
    ),
    ListOfPatients(
      date: "16/03/2023",
      patients: [
        Patient(age: 59, name: 'Adria Vieira Lima', imc: 29.0),
        Patient(age: 20, name: 'Adria Vieira Lima', imc: 29.0),
        Patient(age: 60, name: 'Adria Vieira Lima', imc: 29.0),
      ],
    ),
    ListOfPatients(
      date: "17/03/2023",
      patients: [
        Patient(age: 18, name: 'Adria Vieira Lima', imc: 29.0),
        Patient(age: 5, name: 'Adria Vieira Lima', imc: 29.0),
        Patient(age: 2, name: 'Adria Vieira Lima', imc: 29.0),
        Patient(age: 5, name: 'Adria Vieira Lima', imc: 29.0),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBarComponent(scaffoldKey: _scaffoldKey),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
          child: Column(
            children: [
              Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      title: const Text('Nome da Unidade'),
                      trailing: ElevatedButton(
                        onPressed: () {},
                        child: const Text('Alterar'),
                      ),
                    ),
                  ],
                ),
              ),
              const Text('Próximos Atendimentos'),
              ExpansionPanelList(
                elevation: 0,
                expansionCallback: (int index, bool isExpanded) {
                  setState(() {
                    _agendamentos[index].isExpanded = !isExpanded;
                  });
                },
                children:
                    _agendamentos.map<ExpansionPanel>((ListOfPatients item) {
                  return ExpansionPanel(
                    canTapOnHeader: true,
                    backgroundColor: Colors.grey.shade200,
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(
                        title: Row(
                          children: [
                            const Text(
                              'Pacientes do dia: ',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(item.date!),
                          ],
                        ),
                      );
                    },
                    body: Column(
                        children: item.patients!.map((patient) {
                      return Card(
                        elevation: 0,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                backgroundColor:
                                    Theme.of(context).colorScheme.secondary,
                                radius: 20,
                                child: const Icon(Icons.person),
                              ),
                              title: Text(
                                patient!.name ?? '',
                                style: const TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                'IMC: ${patient.imc}',
                                style: const TextStyle(
                                  fontSize: 15.0,
                                ),
                              ),
                              trailing: TextButton(
                                child: const Text('Ver mais'),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList()),
                    isExpanded: item.isExpanded ?? true,
                  );
                }).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
