import 'package:flutter/material.dart';

class SobrePage extends StatelessWidget {
  const SobrePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Software fundamentado na pesquisa  desenvolvida em parceria com a Universidade Federal de Santa Catarina (UFSC) ,  cujo objetivo é melhorar o acesso aos serviços  e o desempenho dos atendimentos de pessoas com doenças crônicas não transmissíveis.',
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.only(bottom: 18.0),
                child: Text(
                  'Idealizador da equipe:',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                'Cláudio Fernandes Tino, mestrando em informática em saúde pela UFSC administrador, especialista em gestão de processo de software, gerenciamento de projetos e saúde pública.',
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
