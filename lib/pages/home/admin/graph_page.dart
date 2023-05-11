import 'package:flutter/material.dart';
import 'package:on_health_app/components/app_graph.dart';
import 'package:on_health_app/providers/auth_provider.dart';
import 'package:on_health_app/providers/indicadores_provider.dart';
import 'package:provider/provider.dart';

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double y;
}

class GraphPage extends StatefulWidget {
  const GraphPage({super.key});

  @override
  State<GraphPage> createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  @override
  void initState() {
    super.initState();
    callIndicadores();
  }

  callIndicadores() async {
    await Provider.of<IndicadoresProvider>(
      context,
      listen: false,
    ).indicadorDiabetesUnidade().then((value) => print('value'));
    await Provider.of<IndicadoresProvider>(
      context,
      listen: false,
    ).indicadorDiabetesGeral().then((value) => print('value2'));
    await Provider.of<IndicadoresProvider>(
      context,
      listen: false,
    ).indicadorHipertensaoUnidade().then((value) => print('value3'));
    await Provider.of<IndicadoresProvider>(
      context,
      listen: false,
    ).indicadorHipertensaoGeral().then((value) => print('value4'));
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context);
    final userInfo = provider.userData;
    final providerIndicadores =
        Provider.of<IndicadoresProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: Text(userInfo['unidadeSaude']),
        centerTitle: true,
        toolbarHeight: 80,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 18.0),
            child: Text(
              'Análise de Dados',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          DefaultTabController(
            length: 2,
            initialIndex: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  color: Colors.blue.shade50,
                  child: const TabBar(
                    labelColor: Colors.green,
                    unselectedLabelColor: Colors.black,
                    tabs: [
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
                  height: 680, //height of TabBarView
                  decoration: const BoxDecoration(
                    // color: Colors.red,
                    border: Border(
                      top: BorderSide(color: Colors.grey, width: 0.5),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: TabBarView(
                      children: [
                        AppGraphDiabetes(
                          diabetesValueGeral:
                              providerIndicadores.indicDiabetesGeral?.indice ??
                                  0.0,
                          diabetesValueUnid: providerIndicadores
                                  .indicDiabetesUnidade?.indice ??
                              0.0,
                        ),
                        AppGraphHipertensao(
                          hipertensaoValueGeral: providerIndicadores
                                  .indicHipertensaoGeral?.indice ??
                              0.0,
                          hipertensaoValueUnid: providerIndicadores
                                  .indicHipertensaoUnidade?.indice ??
                              0.0,
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
    );
  }
}
