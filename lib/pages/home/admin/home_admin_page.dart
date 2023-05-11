import 'package:flutter/material.dart';
import 'package:on_health_app/components/app_bar_component.dart';
import 'package:on_health_app/components/app_drawer.dart';
import 'package:on_health_app/models/agendamentos.dart';
import 'package:on_health_app/providers/agendamentos_provider.dart';
import 'package:on_health_app/providers/auth_provider.dart';
import 'package:on_health_app/utils/app_routes.dart';
import 'package:provider/provider.dart';

class HomeAdminPage extends StatefulWidget {
  const HomeAdminPage({super.key});

  @override
  State<HomeAdminPage> createState() => _HomeAdminPageState();
}

class _HomeAdminPageState extends State<HomeAdminPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    Provider.of<AgendamentosProvider>(
      context,
      listen: false,
    ).loadAgendamentosGestor();
  }

  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<AuthProvider>(
      context,
      listen: false,
    ).userData;
    final listaAgendamentos = Provider.of<AgendamentosProvider>(
      context,
      listen: false,
    ).listaAgendamentosGestor;

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
                    title: Center(
                      child: Text(
                        userInfo['unidadeSaude'],
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
                itemCount: listaAgendamentos!.agendamentos!.length,
                itemBuilder: (BuildContext context, int index) {
                  Lista lista = listaAgendamentos.agendamentos![index];

                  return Column(
                    children: [
                      ListTile(
                        tileColor: Colors.grey.shade200,
                        title: Row(
                          children: [
                            Text(
                              'Pacientes do dia: ',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(lista.dtAgenda!),
                          ],
                        ),
                      ),
                      ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: lista.agendamentos!.length,
                        itemBuilder: (BuildContext context, int index) {
                          Agendamentos agendamento = lista.agendamentos![index];

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
                                  title: Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      agendamento.nome!,
                                      style: const TextStyle(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'IMC: ${agendamento.imc}',
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
                                          color: Colors.red,
                                        ),
                                        height: 10,
                                        width: 50,
                                      )
                                    ],
                                  ),
                                  trailing: TextButton(
                                    child: const Text('Ver mais'),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed(AppRoutes.PATIENT_INFO);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  );

                  // return ListView.builder(
                  //   scrollDirection: Axis.vertical,
                  //   shrinkWrap: true,
                  //   itemCount: lista.agendamentos!.length,
                  //   itemBuilder: (BuildContext context, int index) {
                  //     Agendamentos agendamento = lista.agendamentos![index];

                  //     return Card(
                  //       elevation: 3,
                  //       child: Padding(
                  //         padding: const EdgeInsets.symmetric(vertical: 5.0),
                  //         child: Column(
                  //           mainAxisSize: MainAxisSize.min,
                  //           children: [
                  //             ListTile(
                  //               leading: Column(
                  //                 mainAxisAlignment: MainAxisAlignment.center,
                  //                 children: [
                  //                   Icon(Icons.date_range),
                  //                 ],
                  //               ),
                  //               title: Column(
                  //                 crossAxisAlignment: CrossAxisAlignment.start,
                  //                 children: [
                  //                   Text(
                  //                     'Especialidade: ${agendamento.dsCBO!.capitalizeByWord()}',
                  //                     style: TextStyle(
                  //                       fontSize: 18.0,
                  //                       fontWeight: FontWeight.w500,
                  //                     ),
                  //                   ),
                  //                   Text(
                  //                     'Médico: ${agendamento.nmProfSaude!.capitalizeByWord()}',
                  //                     style: TextStyle(
                  //                       fontSize: 16.0,
                  //                       fontWeight: FontWeight.w400,
                  //                     ),
                  //                   ),
                  //                   SizedBox(height: 10.0),
                  //                 ],
                  //               ),
                  //               subtitle: Text(
                  //                 'Data: ${agendamento.dtAgenda}',
                  //                 style: TextStyle(
                  //                   fontSize: 15.0,
                  //                   fontWeight: FontWeight.w500,
                  //                 ),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
