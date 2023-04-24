import 'package:flutter/material.dart';
import 'package:on_health_app/components/text_form_field.dart';

class LoginUsuario extends StatelessWidget {
  const LoginUsuario({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Image.asset(
                    'assets/images/logo_1.png',
                    width: 300,
                    height: 300,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Form(
                      child: Column(
                        children: [
                          const TextFormFieldComponent(
                            label: 'Número do CPF',
                            hintText: 'Digite o seu CPF',
                          ),
                          const TextFormFieldComponent(
                            label: 'Senha de acesso',
                            hintText: 'Digite a sua senha',
                          ),
                          Row(
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(
                                    (MediaQuery.of(context).size.width * 0.5) -
                                        23,
                                    45,
                                  ),
                                  backgroundColor:
                                      Theme.of(context).colorScheme.secondary,
                                  elevation: 8,
                                  shadowColor: Colors.grey,
                                ),
                                onPressed: () => {},
                                child: Text(
                                  'Cadastrar',
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(
                                    (MediaQuery.of(context).size.width * 0.5) -
                                        23,
                                    45,
                                  ),
                                  elevation: 8,
                                  shadowColor: Colors.grey,
                                ),
                                onPressed: () => {},
                                child: const Text(
                                  'Entrar',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(
                        (MediaQuery.of(context).size.width * 0.5) - 23,
                        45,
                      ),
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      elevation: 8,
                      shadowColor: Colors.grey,
                    ),
                    onPressed: () => {},
                    child: Text(
                      'Sou administrador',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      'Esqueci a senha',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
