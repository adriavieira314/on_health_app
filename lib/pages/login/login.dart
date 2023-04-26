import 'package:flutter/material.dart';
import 'package:on_health_app/pages/login/login_admin.dart';
import 'package:on_health_app/pages/login/login_user.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isAdmin = false;

  void _changeLogin() {
    setState(() {
      _isAdmin = !_isAdmin;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    double safeAreaHeight = mediaQuery.padding.top;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: mediaQuery.size.height - safeAreaHeight,
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
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: _isAdmin
                            ? const LoginAdmin()
                            : const LoginUsuario(),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (!_isAdmin)
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(200, 50),
                          backgroundColor: Colors.white,
                          elevation: 8,
                          shadowColor: Colors.grey,
                        ),
                        onPressed: _changeLogin,
                        child: Text(
                          'Sou administrador',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    if (!_isAdmin)
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
                    if (_isAdmin)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(200, 50),
                            backgroundColor: Colors.white,
                            elevation: 8,
                            shadowColor: Colors.grey,
                          ),
                          onPressed: _changeLogin,
                          child: Text(
                            'Voltar',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
