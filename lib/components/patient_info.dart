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
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    radius: 30,
                    child: const Icon(Icons.person),
                  ),
                ),
                Text(
                  info['nome']!,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
            TextInfo(
              label: 'CPF: ',
              info: info['cpf']!,
            ),
            const Divider(),
            TextInfo(
              label: 'IMC: ',
              info: info['imc'].toString(),
            ),
            const Divider(),
            TextInfo(
              label: 'IMC classe: ',
              info: info['classImc']!,
            ),
            const Divider(),
            TextInfo(
              label: 'Data da consulta: ',
              info: '${info['dtAgenda']!} ás ${info['hrAgenda']!} horas',
            ),
            const Divider(),
            TextInfo(
              label: 'Unidade de Saúde: ',
              info: info['unidadeSaude']!,
            ),
            const Divider(),
            TextInfo(
              label: 'Profissional: ',
              info: info['doctor']!,
            ),
          ],
        ),
      ),
    );
  }
}
