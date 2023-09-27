import 'package:flutter/material.dart';
import 'package:on_health_app/components/gauge_range_dcnt_graph.dart';

class AppGraphDcntDiabetes extends StatelessWidget {
  final double? diabetesValueUnid;
  final double? diabetesValueGeral;

  const AppGraphDcntDiabetes({
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
            GaugeRangeDcntGraph(
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
            GaugeRangeDcntGraph(
              value: diabetesValueGeral,
            ),
            const Text('100.0%'),
          ],
        ),
      ],
    );
  }
}

class AppGraphDcntHipertensao extends StatelessWidget {
  final double? hipertensaoValueUnid;
  final double? hipertensaoValueGeral;

  const AppGraphDcntHipertensao({
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
            GaugeRangeDcntGraph(
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
            GaugeRangeDcntGraph(
              value: hipertensaoValueGeral,
            ),
            const Text('100.0%'),
          ],
        ),
      ],
    );
  }
}
