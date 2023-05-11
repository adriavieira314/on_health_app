import 'package:flutter/material.dart';
import 'package:on_health_app/models/agendamentos.dart';
import 'package:on_health_app/providers/agendamentos_provider.dart';
import 'package:provider/provider.dart';
import 'package:on_health_app/utils/capitalize.dart';

class AgendamentosUserPage extends StatefulWidget {
  const AgendamentosUserPage({super.key});

  @override
  State<AgendamentosUserPage> createState() => _AgendamentosUserPageState();
}

class _AgendamentosUserPageState extends State<AgendamentosUserPage> {
  bool loading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<AgendamentosProvider>(
      context,
      listen: false,
    ).loadAgendamentosUsuario().then((value) {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final listaAgendamentos = Provider.of<AgendamentosProvider>(
      context,
      listen: true,
    ).listaAgendamentosUsuario;

    return loading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : listaAgendamentos == null
            ? Center(
                child: Text(
                  'Sem agendamentos',
                  style: TextStyle(fontSize: 16),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: listaAgendamentos.agendamentos!.length,
                itemBuilder: (BuildContext context, int index) {
                  Lista lista = listaAgendamentos.agendamentos![index];

                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: lista.agendamentos!.length,
                    itemBuilder: (BuildContext context, int index) {
                      Agendamentos agendamento = lista.agendamentos![index];

                      return Card(
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                leading: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.date_range),
                                  ],
                                ),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Especialidade: ${agendamento.dsCBO!.capitalizeByWord()}',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      'Profissional: ${agendamento.nmProfSaude!.capitalizeByWord()}',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(height: 10.0),
                                  ],
                                ),
                                subtitle: Text(
                                  'Data: ${agendamento.dtAgenda}',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              );
  }
}
