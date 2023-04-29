import 'package:flutter/material.dart';
import 'package:on_health_app/components/home/text_info.dart';
import 'package:on_health_app/data/dumb_data.dart';

class PatientInfo extends StatelessWidget {
  const PatientInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> info = userInfo;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Informações do Paciente'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  radius: 30,
                  child: const Icon(Icons.person),
                ),
                Text(
                  info['nome'],
                  style: const TextStyle(
                    fontSize: 19.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextInfo(
                  label: 'Valor da glicemia: ',
                  info: info['address']!,
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                TextInfo(
                  label: 'IMC: ',
                  info: info['imc']!,
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ],
            ),
            const SizedBox(height: 30),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: TextInfo(
                    label: 'Último atendimento: ',
                    info: info['lastAppointment']!['date']!,
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: Column(
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    'Unidade de Saúde: ',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    info['lastAppointment']!['ubs']!,
                                    style: const TextStyle(
                                      fontSize: 17.0,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  children: [
                                    const Text(
                                      'Médico: ',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      info['lastAppointment']!['doctor']!,
                                      style: const TextStyle(
                                        fontSize: 17.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Especialidade: ',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    info['lastAppointment']!['speciality']!,
                                    style: const TextStyle(
                                      fontSize: 17.0,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: TextInfo(
                    label: 'Próximo atendimento: ',
                    info: info['nextAppointment']!['date']!,
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: Column(
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    'Unidade de Saúde: ',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    info['nextAppointment']!['ubs']!,
                                    style: const TextStyle(
                                      fontSize: 17.0,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  children: [
                                    const Text(
                                      'Médico: ',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      info['nextAppointment']!['doctor']!,
                                      style: const TextStyle(
                                        fontSize: 17.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Especialidade: ',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    info['nextAppointment']!['speciality']!,
                                    style: const TextStyle(
                                      fontSize: 17.0,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
