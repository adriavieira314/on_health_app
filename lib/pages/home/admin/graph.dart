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

class _GraphState extends State<Graph> {
  final List<ChartData> chartData = [
    ChartData('Jan', 10),
    ChartData('Fev', 11),
    ChartData('Mar', 9),
    ChartData('Abr', 10),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nome da Unidade'),
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
                fontSize: 20.0,
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
                  height: 450, //height of TabBarView
                  decoration: const BoxDecoration(
                    // color: Colors.red,
                    border: Border(
                      top: BorderSide(color: Colors.grey, width: 0.5),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: TabBarView(
                      children: [
                        AppGraph(graphValue: 60.0),
                        AppGraph(graphValue: 40.0),
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
