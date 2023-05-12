import 'package:flutter/material.dart';
import 'package:on_health_app/components/app_graph.dart';

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double y;
}

class Graph extends StatefulWidget {
  const Graph({super.key});

  @override
  State<Graph> createState() => _GraphState();
}

class _GraphState extends State<Graph> with SingleTickerProviderStateMixin {
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
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UBS Joao Pereira de Oliveira'),
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
                          AppGraph(graphValue: 9.0),
                          AppGraph(graphValue: 5.0),
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
