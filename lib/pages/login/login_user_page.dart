import 'package:flutter/material.dart';
import 'package:on_health_app/exceptions/http_exception.dart';
import 'package:on_health_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginUsuarioPage extends StatefulWidget {
  const LoginUsuarioPage({super.key});

  @override
  State<LoginUsuarioPage> createState() => _LoginUsuarioPageState();
}

class _LoginUsuarioPageState extends State<LoginUsuarioPage> {
  final _passwordFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final Map<String?, dynamic> _formData = {
    'cpf': '',
    'password': '',
  };

  void _showErrorDialog(String msg) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Ocorreu um Erro'),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }

  void _submitForm() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    setState(() => _isLoading = true);

    _formKey.currentState?.save();
    AuthProvider auth = Provider.of(context, listen: false);

    try {
      await auth.loginUser(
        _formData['cpf']!,
        _formData['password']!,
      );
    } on HttpException catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
      _showErrorDialog(
          'Ocorreu um erro no processo. Entre em contato com suporte técnico.');
    }

    setState(() => _isLoading = false);
    FocusManager.instance.primaryFocus?.unfocus();
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
                  keyboardType: TextInputType.number,
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
                  keyboardType: TextInputType.number,
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
                if (_isLoading)
                  SizedBox(
                    width: (mediaQuery.size.width * 0.5) - 23,
                    height: 45,
                    child: Center(
                      child: const CircularProgressIndicator(),
                    ),
                  )
                else
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
