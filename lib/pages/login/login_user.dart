import 'package:flutter/material.dart';
import 'package:on_health_app/utils/app_routes.dart';

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
    Navigator.of(context).pushReplacementNamed(AppRoutes.HOME_USER);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Form(
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
                  padding: const EdgeInsets.only(left: 15.0, bottom: 8.0),
                  child: Text(
                    'Número do CPF',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
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
                  onSaved: (cpf) => _formData['cpf'] = cpf ?? '',
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_passwordFocus);
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
                  padding: const EdgeInsets.only(left: 15.0, bottom: 8.0),
                  child: Text(
                    'Senha de acesso',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
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
                  onSaved: (password) => _formData['password'] = password ?? '',
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
                    backgroundColor: Colors.white,
                    elevation: 8,
                    shadowColor: Colors.grey,
                  ),
                  onPressed: () => {},
                  child: Text(
                    'Cadastrar',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
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
    );
  }
}
