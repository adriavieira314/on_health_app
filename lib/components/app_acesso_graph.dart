import 'package:flutter/material.dart';
import 'package:on_health_app/components/gauge_range_acesso_graph.dart';

class AppGraphAcessoDiabetes extends StatelessWidget {
  final double? diabetesValueUnid;
  final double? diabetesValueGeral;

  const AppGraphAcessoDiabetes({
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
            GaugeRangeAcessoGraph(
              value: diabetesValueUnid,
            ),
          ],
        ),
        Text(
          'Geral Secretaria',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GaugeRangeAcessoGraph(
              value: diabetesValueGeral,
            ),
          ],
        ),
      ],
    );
  }
}

class AppGraphAcessoHipertensao extends StatelessWidget {
  final double? hipertensaoValueUnid;
  final double? hipertensaoValueGeral;

  const AppGraphAcessoHipertensao({
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
            GaugeRangeAcessoGraph(
              value: hipertensaoValueUnid,
            ),
          ],
        ),
        Text(
          'Geral Secretaria',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GaugeRangeAcessoGraph(
              value: hipertensaoValueGeral,
            ),
          ],
        ),
      ],
    );
  }
}
