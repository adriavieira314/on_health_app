import 'package:flutter/material.dart';
import 'package:on_health_app/components/home/text_info.dart';

class HomeUser extends StatelessWidget {
  const HomeUser({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final Map<String, String> user_info = {
      'nome': 'José Maria de Souza',
      'cpf': '000.000.000-00',
      'birthdate': '12/01/1956',
      'imc': '(sendentarismo/odesidade) CID/CIAP',
      'parent': 'Maria de Cassia Rodrigues',
      'street': 'Rua Antonio Batista da Silva, 440',
      'address': 'Centro - João Pessoa/PB',
    };

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(18.0, 0.0, 18.0, 25.0),
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    width: mediaQuery.size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.blue.shade100,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.brown.shade800,
                          radius: 30,
                          child: const Text('AH'),
                        ),
                        Text(
                          user_info['nome']!,
                          style: const TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'CPF: ${user_info['cpf']!}',
                          style: const TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextInfo(
                    label: 'Nascimento: ',
                    info: user_info['birthdate']!,
                  ),
                  const Divider(),
                  TextInfo(
                    label: 'IMC: ',
                    info: user_info['imc']!,
                  ),
                  const Divider(),
                  TextInfo(
                    label: 'Mãe: ',
                    info: user_info['parent']!,
                  ),
                  const Divider(),
                  TextInfo(
                    label: 'Endereço: ',
                    info: user_info['street']!,
                  ),
                  const Divider(),
                  TextInfo(
                    label: 'Bairro: ',
                    info: user_info['address']!,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
