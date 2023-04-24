import 'package:flutter/material.dart';

class LoginUsuario extends StatefulWidget {
  const LoginUsuario({super.key});

  @override
  State<LoginUsuario> createState() => _LoginUsuarioState();
}

class _LoginUsuarioState extends State<LoginUsuario> {
  final _passwordFocus = FocusNode();
  final _formData = <String, Object>{};
  final _formKey = GlobalKey<FormState>();

  void _submitForm() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();
    print(_formData);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: mediaQuery.size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Image.asset(
                    'assets/images/logo_1.png',
                    width: 300,
                    height: 280,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, bottom: 8.0),
                                  child: Text(
                                    'Número do CPF',
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  decoration: const InputDecoration(
                                    hintText: 'Digite o seu CPF',
                                    border: OutlineInputBorder(),
                                  ),
                                  textInputAction: TextInputAction.next,
                                  onSaved: (cpf) =>
                                      _formData['cpf'] = cpf ?? '',
                                  onFieldSubmitted: (_) {
                                    FocusScope.of(context)
                                        .requestFocus(_passwordFocus);
                                  },
                                  validator: (value) {
                                    final cpf = value ?? '';

                                    if (cpf.trim().isEmpty) {
                                      return 'Campo obrigatório.';
                                    }

                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, bottom: 8.0),
                                  child: Text(
                                    'Senha de acesso',
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  decoration: const InputDecoration(
                                    hintText: 'Digite a sua senha',
                                    border: OutlineInputBorder(),
                                  ),
                                  textInputAction: TextInputAction.done,
                                  focusNode: _passwordFocus,
                                  onSaved: (password) =>
                                      _formData['password'] = password ?? '',
                                  validator: (value) {
                                    final password = value ?? '';

                                    if (password.trim().isEmpty) {
                                      return 'Campo obrigatório.';
                                    }

                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Row(
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size(
                                      (mediaQuery.size.width * 0.5) - 23,
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
                                      (mediaQuery.size.width * 0.5) - 23,
                                      45,
                                    ),
                                    elevation: 8,
                                    shadowColor: Colors.grey,
                                  ),
                                  onPressed: _submitForm,
                                  child: const Text(
                                    'Entrar',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
                      minimumSize: const Size(200, 50),
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
