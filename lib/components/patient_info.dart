import 'package:flutter/material.dart';
import 'package:on_health_app/components/home/text_info.dart';
import 'package:on_health_app/models/agendamentos.dart';
import 'package:on_health_app/utils/capitalize.dart';

class PatientInfo extends StatelessWidget {
  const PatientInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final agendamento =
        ModalRoute.of(context)!.settings.arguments as Agendamentos;

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
                  agendamento.nome!,
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
              info: agendamento.cpf!,
            ),
            const Divider(),
            TextInfo(
              label: 'IMC: ',
              info: agendamento.imc.toString(),
            ),
            const Divider(),
            TextInfo(
              label: 'IMC classe: ',
              info: agendamento.classImc,
            ),
            const Divider(),
            TextInfo(
              label: 'Data da consulta: ',
              info: '${agendamento.dtAgenda} ás ${agendamento.hrAgenda} horas',
            ),
            const Divider(),
            TextInfo(
              label: 'Unidade de Saúde da consulta: ',
              info: agendamento.unidadeSaude,
            ),
            const Divider(),
            TextInfo(
              label: 'Profissional: ',
              info: '${agendamento.nmProfSaude!.capitalizeByWord()}',
            ),
          ],
        ),
      ),
    );
  }
}
