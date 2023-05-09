import 'package:flutter/material.dart';
import 'package:on_health_app/components/home/text_info.dart';
import 'package:on_health_app/models/custom_notification.dart';
import 'package:on_health_app/providers/auth_provider.dart';
import 'package:on_health_app/services/notification_service.dart';
import 'package:on_health_app/utils/app_routes.dart';
import 'package:provider/provider.dart';

class HomeUserPage extends StatefulWidget {
  const HomeUserPage({super.key});

  @override
  State<HomeUserPage> createState() => _HomeUserPageState();
}

class _HomeUserPageState extends State<HomeUserPage> {
  bool valor = false;

  showNotification() {
    valor = !valor;
    if (valor) {
      Provider.of<NotificationService>(context, listen: false)
          .showNotificationScheduled(
        CustomNotification(
          id: 1,
          title: 'Teste',
          body: 'Acesse o app!',
          payload: AppRoutes.PATIENT_INFO,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context);
    final userData = provider.userData;
    final endereco = userData['endereco'].split('Bairro:');
    final userHipertenso = provider.dadosHipertensao;
    final userDiabetes = provider.dadosDiabetes;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextInfo(
                    label: 'Nascimento: ',
                    info: userData['dtNasc']!,
                  ),
                  const Divider(),
                  TextInfo(
                    label: 'IMC: ',
                    info:
                        '${userData['imc']!.toString()} - ${userData['classImc']!}',
                  ),
                  const Divider(),
                  TextInfo(
                    label: 'Mãe: ',
                    info: userData['nomeMae']!,
                  ),
                  const Divider(),
                  TextInfo(
                    label: 'Endereço: ',
                    info: endereco[0],
                  ),
                  const Divider(),
                  TextInfo(
                    label: 'Bairro: ',
                    info: endereco[1],
                  ),
                ],
              ),
            ),
            SizedBox(height: 80),
            if (userDiabetes != null || userHipertenso != null)
              DefaultTabController(
                length: userDiabetes == null || userHipertenso == null ? 1 : 2,
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
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 8.0),
                                    child: Icon(Icons.monitor_heart_outlined),
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
                              Column(
                                children: [
                                  TextInfo(
                                    label: 'Unidade de Saúde: ',
                                    info: userDiabetes['unidadeSaude']!,
                                  ),
                                  const Divider(),
                                  TextInfo(
                                    label: 'Médico: ',
                                    info: userDiabetes['nomeProfissional']!,
                                  ),
                                  const Divider(),
                                  TextInfo(
                                    label: 'Último atendimento: ',
                                    info: userDiabetes['dtUltAtendimento']!,
                                  ),
                                  const Divider(),
                                  TextInfo(
                                    label: 'Valor da Glicemia: ',
                                    info: userDiabetes['glicemia']!.toString(),
                                  ),
                                  const Divider(),
                                  TextInfo(
                                    label: 'Medicação recebida: ',
                                    info: userDiabetes['medicacao']!,
                                  ),
                                ],
                              ),
                            if (userHipertenso != null)
                              Column(
                                children: [
                                  TextInfo(
                                    label: 'Unidade de Saúde: ',
                                    info: userHipertenso['unidadeSaude']!,
                                  ),
                                  const Divider(),
                                  TextInfo(
                                    label: 'Médico: ',
                                    info: userHipertenso['nomeProfissional']!,
                                  ),
                                  const Divider(),
                                  TextInfo(
                                    label: 'Último atendimento: ',
                                    info: userHipertenso['dtUltAtendimento']!,
                                  ),
                                  const Divider(),
                                  TextInfo(
                                    label: 'Pressão: ',
                                    info: userHipertenso['pressao']!.toString(),
                                  ),
                                  const Divider(),
                                  TextInfo(
                                    label: 'Medicação recebida: ',
                                    info: userHipertenso['medicacao']!,
                                  ),
                                ],
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
