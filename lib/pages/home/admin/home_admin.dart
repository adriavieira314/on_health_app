import 'package:flutter/material.dart';
import 'package:on_health_app/components/app_bar_component.dart';
import 'package:on_health_app/components/app_drawer.dart';
import 'package:on_health_app/models/list_of_patients.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<ListOfPatients> _agendamentos = [
    ListOfPatients(
      date: "15/03/2023",
      patients: [
        Patient(age: 25, name: 'Adria Vieira Lima', imc: 29.0, confirmation: 0),
        Patient(age: 30, name: 'Adria Vieira Lima', imc: 29.0, confirmation: 1),
      ],
    ),
    ListOfPatients(
      date: "16/03/2023",
      patients: [
        Patient(age: 59, name: 'Adria Vieira Lima', imc: 29.0, confirmation: 2),
        Patient(age: 20, name: 'Adria Vieira Lima', imc: 29.0, confirmation: 0),
        Patient(age: 60, name: 'Adria Vieira Lima', imc: 29.0, confirmation: 1),
      ],
    ),
    ListOfPatients(
      date: "17/03/2023",
      patients: [
        Patient(age: 18, name: 'Adria Vieira Lima', imc: 29.0, confirmation: 0),
        Patient(age: 5, name: 'Adria Vieira Lima', imc: 29.0, confirmation: 1),
        Patient(age: 2, name: 'Adria Vieira Lima', imc: 29.0, confirmation: 2),
        Patient(age: 5, name: 'Adria Vieira Lima', imc: 29.0, confirmation: 1),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBarComponent(scaffoldKey: _scaffoldKey),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 18.0),
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
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 18.0),
              child: Text(
                'Próximos Atendimentos',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _agendamentos.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = _agendamentos[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Column(
                      children: [
                        ListTile(
                          tileColor: Colors.grey.shade200,
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
                        ),
                        Column(
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
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'IMC: ${patient.imc}',
                                        style: const TextStyle(
                                          fontSize: 15.0,
                                        ),
                                      ),
                                      // ! confirmação de agendamento
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: patient.confirmation == 0
                                              ? Colors.green
                                              : patient.confirmation == 1
                                                  ? Colors.orange
                                                  : Colors.red,
                                        ),
                                        height: 10,
                                        width: 50,
                                      )
                                    ],
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
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
