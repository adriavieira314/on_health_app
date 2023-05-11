import 'package:flutter/material.dart';
import 'package:on_health_app/components/gauge_range_graph.dart';

class AppGraphDiabetes extends StatelessWidget {
  final double? diabetesValueUnid;
  final double? diabetesValueGeral;

  const AppGraphDiabetes({
    super.key,
    this.diabetesValueUnid,
    this.diabetesValueGeral,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Unidade',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('0.0%'),
            GaugeRangeGraph(
              value: diabetesValueUnid,
            ),
            const Text('100.0%'),
          ],
        ),
        Text(
          'Geral Secretaria',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('0.0%'),
            GaugeRangeGraph(
              value: diabetesValueGeral,
            ),
            const Text('100.0%'),
          ],
        ),
      ],
    );
  }
}

class AppGraphHipertensao extends StatelessWidget {
  final double? hipertensaoValueUnid;
  final double? hipertensaoValueGeral;

  const AppGraphHipertensao({
    super.key,
    this.hipertensaoValueUnid,
    this.hipertensaoValueGeral,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Unidade',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('0.0%'),
            GaugeRangeGraph(
              value: hipertensaoValueUnid,
            ),
            const Text('100.0%'),
          ],
        ),
        Text(
          'Geral Secretaria',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('0.0%'),
            GaugeRangeGraph(
              value: hipertensaoValueGeral,
            ),
            const Text('100.0%'),
          ],
        ),
      ],
    );
  }
}
