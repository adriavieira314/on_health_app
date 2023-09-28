import 'package:flutter/material.dart';
import 'package:on_health_app/components/home/text_info.dart';
import 'package:on_health_app/components/tabBarInfo.dart';
import 'package:on_health_app/models/agendamentos.dart';
import 'package:on_health_app/providers/agendamentos_provider.dart';
import 'package:on_health_app/utils/capitalize.dart';
import 'package:on_health_app/utils/cpf_format.dart';
import 'package:provider/provider.dart';

class PatientInfo extends StatefulWidget {
  const PatientInfo({super.key});

  @override
  State<PatientInfo> createState() => _PatientInfoState();
}

class _PatientInfoState extends State<PatientInfo> {
  bool loading = true;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AgendamentosProvider>(context, listen: true);

    final agendamento =
        ModalRoute.of(context)!.settings.arguments as Agendamentos;

    Provider.of<AgendamentosProvider>(
      context,
      listen: false,
    ).getUltimoAtendimento(agendamento.cpf!).then((value) {
      setState(() {
        loading = false;
      });
    });
    final userHipertenso = provider.dadosHipertensao;
    final userDiabetes = provider.dadosDiabetes;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Informações do Paciente'),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 18.0, horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: CircleAvatar(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          radius: 30,
                          child: const Icon(Icons.person),
                        ),
                      ),
                      Text(
                        agendamento.nome!.capitalizeByWord(),
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
                    info: CPF.format(agendamento.cpf!),
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
                    info:
                        '${agendamento.dtAgenda} ás ${agendamento.hrAgenda} horas',
                  ),
                  const Divider(),
                  TextInfo(
                    label: 'Unidade de Saúde: ',
                    info: agendamento.unidadeSaude,
                  ),
                  const Divider(),
                  TextInfo(
                    label: 'Profissional: ',
                    info: '${agendamento.nmProfSaude!.capitalizeByWord()}',
                  ),
                  SizedBox(height: 80),
                  if (userDiabetes != null || userHipertenso != null)
                    DefaultTabController(
                      length: userDiabetes == null || userHipertenso == null
                          ? 1
                          : 2,
                      initialIndex: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            color: Colors.blue.shade50,
                            child: TabBar(
                              labelColor: Colors.green,
                              unselectedLabelColor: Colors.black,
                              tabs: [
                                if (userDiabetes != null)
                                  Tab(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 8.0),
                                          child: Icon(Icons.bloodtype_outlined),
                                        ),
                                        Text(
                                          'Diabetes',
                                          style: TextStyle(fontSize: 22.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                if (userHipertenso != null)
                                  Tab(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 8.0),
                                          child: Icon(
                                              Icons.monitor_heart_outlined),
                                        ),
                                        Text(
                                          'Hipertensão',
                                          style: TextStyle(fontSize: 22.0),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Container(
                            height: 300, //height of TabBarView
                            decoration: const BoxDecoration(
                              // color: Colors.red,
                              border: Border(
                                top: BorderSide(color: Colors.grey, width: 0.5),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: TabBarView(
                                children: [
                                  if (userDiabetes != null)
                                    TabBarInfo(
                                      userCondicaoMedica: userDiabetes,
                                      tipo: 1,
                                    ),
                                  if (userHipertenso != null)
                                    TabBarInfo(
                                      userCondicaoMedica: userHipertenso,
                                      tipo: 2,
                                    ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                ],
              ),
            ),
    );
  }
}
