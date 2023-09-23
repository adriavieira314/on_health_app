import 'package:flutter/material.dart';
import 'package:on_health_app/components/home/text_info.dart';

class TabBarInfo extends StatelessWidget {
  final dynamic userCondicaoMedica;
  final int? tipo;

  const TabBarInfo({super.key, this.userCondicaoMedica, this.tipo});

  @override
  Widget build(BuildContext context) {
    return tipo == 1
        ? Column(
            children: [
              TextInfo(
                label: 'Unidade de Saúde: ',
                info: userCondicaoMedica['unidadeSaude']!,
              ),
              const Divider(),
              TextInfo(
                label: 'Médico: ',
                info: userCondicaoMedica['nomeProfissional']!,
              ),
              const Divider(),
              TextInfo(
                label: 'Último atendimento: ',
                info: userCondicaoMedica['dtUltAtendimento']!,
              ),
              const Divider(),
              TextInfo(
                label: 'Valor da Glicemia: ',
                info: userCondicaoMedica['glicemia']!.toString(),
              ),
              const Divider(),
              TextInfo(
                label: 'Medicação recebida: ',
                info: userCondicaoMedica['medicacao']!,
              ),
            ],
          )
        : Column(
            children: [
              TextInfo(
                label: 'Unidade de Saúde: ',
                info: userCondicaoMedica['unidadeSaude']!,
              ),
              const Divider(),
              TextInfo(
                label: 'Médico: ',
                info: userCondicaoMedica['nomeProfissional']!,
              ),
              const Divider(),
              TextInfo(
                label: 'Último atendimento: ',
                info: userCondicaoMedica['dtUltAtendimento']!,
              ),
              const Divider(),
              TextInfo(
                label: 'Pressão: ',
                info: userCondicaoMedica['pressao']!.toString(),
              ),
              const Divider(),
              TextInfo(
                label: 'Medicação recebida: ',
                info: userCondicaoMedica['medicacao']!,
              ),
            ],
          );
  }
}
