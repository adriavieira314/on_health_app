import 'package:flutter/material.dart';
import 'package:on_health_app/components/gauge_range_acesso_graph.dart';

class AppGraphAcessoDiabetes extends StatelessWidget {
  final double? diabetesValueUnid;
  final double? diabetesValueGeral;
  final int? demandaProgramaUnid;
  final int? demandaEspontaneaUnid;
  final int? demandaProgramaGeral;
  final int? demandaEspontaneaGeral;

  const AppGraphAcessoDiabetes({
    super.key,
    this.diabetesValueUnid,
    this.diabetesValueGeral,
    this.demandaProgramaUnid,
    this.demandaEspontaneaUnid,
    this.demandaProgramaGeral,
    this.demandaEspontaneaGeral,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Column(
        children: [
          Text(
            'Unidade',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Column(
                  children: [
                    Demanda('Demanda Programada', demandaProgramaUnid!),
                    SizedBox(height: 10),
                    Demanda('Demanda Espontânea', demandaEspontaneaUnid!),
                  ],
                ),
              ),
              GaugeRangeAcessoGraph(
                value: diabetesValueUnid,
              ),
            ],
          ),
          SizedBox(height: 60),
          Text(
            'Geral Secretaria',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Column(
                  children: [
                    Demanda('Demanda Programada', demandaProgramaGeral!),
                    SizedBox(height: 10),
                    Demanda('Demanda Espontânea', demandaEspontaneaGeral!),
                  ],
                ),
              ),
              GaugeRangeAcessoGraph(
                value: diabetesValueGeral,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AppGraphAcessoHipertensao extends StatelessWidget {
  final double? hipertensaoValueUnid;
  final double? hipertensaoValueGeral;
  final int? demandaProgramaUnid;
  final int? demandaEspontaneaUnid;
  final int? demandaProgramaGeral;
  final int? demandaEspontaneaGeral;

  const AppGraphAcessoHipertensao({
    super.key,
    this.hipertensaoValueUnid,
    this.hipertensaoValueGeral,
    this.demandaProgramaUnid,
    this.demandaEspontaneaUnid,
    this.demandaProgramaGeral,
    this.demandaEspontaneaGeral,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Column(
        children: [
          Text(
            'Unidade',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Column(
                  children: [
                    Demanda('Demanda Programada', demandaProgramaUnid!),
                    SizedBox(height: 10),
                    Demanda('Demanda Espontânea', demandaEspontaneaUnid!),
                  ],
                ),
              ),
              GaugeRangeAcessoGraph(
                value: hipertensaoValueUnid,
              ),
            ],
          ),
          SizedBox(height: 60),
          Text(
            'Geral Secretaria',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Column(
                  children: [
                    Demanda('Demanda Programada', demandaProgramaGeral!),
                    SizedBox(height: 10),
                    Demanda('Demanda Espontânea', demandaEspontaneaGeral!),
                  ],
                ),
              ),
              GaugeRangeAcessoGraph(
                value: hipertensaoValueGeral,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Demanda extends StatelessWidget {
  final String title;
  final int? value;

  const Demanda(this.title, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            color: Colors.grey[300],
            padding: EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            value.toString(),
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
