import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:on_health_app/exceptions/http_exception.dart';
import 'package:on_health_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:brasil_fields/brasil_fields.dart';

class LoginUsuarioPage extends StatefulWidget {
  const LoginUsuarioPage({super.key});

  @override
  State<LoginUsuarioPage> createState() => _LoginUsuarioPageState();
}

class _LoginUsuarioPageState extends State<LoginUsuarioPage> {
  final _passwordFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isObscure = true;

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

    _formData['cpf'] = _formData['cpf'].replaceAll(new RegExp(r'[^\w\s]+'), '');

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
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CpfInputFormatter(),
                    LengthLimitingTextInputFormatter(14)
                  ],
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
                  decoration: InputDecoration(
                    hintText: 'Digite a sua senha',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                          _isObscure ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    ),
                  ),
                  obscureText: _isObscure,
                  inputFormatters: [LengthLimitingTextInputFormatter(8)],
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
          if (_isLoading)
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: SizedBox(
                width: mediaQuery.size.width,
                height: 45,
                child: Center(
                  child: const CircularProgressIndicator(),
                ),
              ),
            )
          else
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
            )
        ],
      ),
    );
  }
}
