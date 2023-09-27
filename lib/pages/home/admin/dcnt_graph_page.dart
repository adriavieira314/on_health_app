import 'package:flutter/material.dart';
import 'package:on_health_app/components/app_dcnt_graph.dart';
import 'package:on_health_app/providers/auth_provider.dart';
import 'package:on_health_app/providers/indicadores_provider.dart';
import 'package:provider/provider.dart';

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double y;
}

class DcntGraphPage extends StatefulWidget {
  const DcntGraphPage({super.key});

  @override
  State<DcntGraphPage> createState() => _DcntGraphPageState();
}

class _DcntGraphPageState extends State<DcntGraphPage>
    with SingleTickerProviderStateMixin {
  final List<bool> loadDiabetesGraph = [false, false];
  final List<bool> loadHipertensaoGraph = [false, false];
  final List<Tab> myTabs = <Tab>[
    new Tab(
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
    new Tab(
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
  ];

  late TabController _tabController =
      new TabController(vsync: this, length: myTabs.length);

  @override
  void initState() {
    super.initState();
    callIndicadores();
    _tabController.animation!.addListener(_tabListener);
  }

  void _tabListener() {
    setState(() {});
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  callIndicadores() async {
    await Provider.of<IndicadoresProvider>(
      context,
      listen: false,
    ).indicadorDiabetesUnidade().then((value) {
      print('value1');
      setState(() {
        loadDiabetesGraph[0] = true;
      });
    });
    await Provider.of<IndicadoresProvider>(
      context,
      listen: false,
    ).indicadorDiabetesGeral().then((value) {
      print('value2');
      setState(() {
        loadDiabetesGraph[1] = true;
      });
    });
    await Provider.of<IndicadoresProvider>(
      context,
      listen: false,
    ).indicadorHipertensaoUnidade().then((value) {
      print('value3');
      setState(() {
        loadHipertensaoGraph[0] = true;
      });
    });
    await Provider.of<IndicadoresProvider>(
      context,
      listen: false,
    ).indicadorHipertensaoGeral().then((value) {
      print('value4');
      setState(() {
        loadHipertensaoGraph[1] = true;
      });
    });
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            DefaultTabController(
              length: 2,
              initialIndex: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: Image.asset(
                      'assets/images/previne-brasil.jpeg',
                      width: 40,
                      height: 40,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 18.0),
                    child: Center(
                      child: Text(
                        _tabController.index == 0
                            ? 'Percentual de diabéticos com solicitação de hemoglobina glicada'
                            : 'Percentual de pessoas hipertensas com Pressão Arterial aferida em cada semestre',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.blue.shade50,
                    child: TabBar(
                      labelColor: Colors.green,
                      unselectedLabelColor: Colors.black,
                      controller: _tabController,
                      tabs: myTabs,
                      onTap: (value) => setState(() {}),
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
                        controller: _tabController,
                        children: [
                          loadDiabetesGraph.every((value) => value == true)
                              ? AppGraphDcntDiabetes(
                                  diabetesValueGeral: providerIndicadores
                                          .indicDiabetesGeral?.indice ??
                                      0.0,
                                  diabetesValueUnid: providerIndicadores
                                          .indicDiabetesUnidade?.indice ??
                                      0.0,
                                )
                              : Center(
                                  child: CircularProgressIndicator(),
                                ),
                          loadHipertensaoGraph.every((value) => value == true)
                              ? AppGraphDcntHipertensao(
                                  hipertensaoValueGeral: providerIndicadores
                                          .indicHipertensaoGeral?.indice ??
                                      0.0,
                                  hipertensaoValueUnid: providerIndicadores
                                          .indicHipertensaoUnidade?.indice ??
                                      0.0,
                                )
                              : Center(
                                  child: CircularProgressIndicator(),
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
