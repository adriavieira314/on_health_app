import 'package:flutter/material.dart';

class LoginAdmin extends StatefulWidget {
  const LoginAdmin({super.key});

  @override
  State<LoginAdmin> createState() => _LoginAdminState();
}

class _LoginAdminState extends State<LoginAdmin> {
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
                    'Login',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Digite o seu usuario',
                    border: OutlineInputBorder(),
                  ),
                  textInputAction: TextInputAction.next,
                  onSaved: (user) => _formData['user'] = user ?? '',
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_passwordFocus);
                  },
                  validator: (value) {
                    final user = value ?? '';

                    if (user.trim().isEmpty) {
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
                    'Senha',
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
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(mediaQuery.size.width, 45),
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
          ),
        ],
      ),
    );
  }
}
