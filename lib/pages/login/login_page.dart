import 'package:flutter/material.dart';
import 'package:on_health_app/main.dart';
import 'package:on_health_app/pages/login/login_admin_page.dart';
import 'package:on_health_app/pages/login/login_user_page.dart';
import 'package:on_health_app/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
    double appHeight = AppBar().preferredSize.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actionsIconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.primary),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18.0, left: 15.0),
            child: PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: const Text("Configuração"),
                  value: 1,
                  onTap: () => {
                    Future.delayed(
                      const Duration(seconds: 0),
                      () => showDialog(
                        context: context,
                        builder: (context) => const AlertDialog(
                          title: Text(
                            'Configurar Servidor',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          content: Configuracao(),
                        ),
                      ),
                    )
                  },
                ),
                PopupMenuItem(
                  child: const Text("Tempo"),
                  value: 3,
                  onTap: () => {
                    Future.delayed(
                      const Duration(seconds: 0),
                      () => showDialog(
                        context: context,
                        builder: (context) => const AlertDialog(
                          title: Text(
                            'Tempo',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          content: TempoAgenda(),
                        ),
                      ),
                    )
                  },
                ),
              ],
            ),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: mediaQuery.size.height - safeAreaHeight - appHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Image.asset(
                      'assets/images/logo_1.png',
                      width: 300,
                      height: 220,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: _isAdmin
                            ? const LoginAdminPage()
                            : const LoginUsuarioPage(),
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
                    // if (!_isAdmin)
                    //   Padding(
                    //     padding: const EdgeInsets.symmetric(vertical: 20.0),
                    //     child: Text(
                    //       'Esqueci a senha',
                    //       style: TextStyle(
                    //         color: Theme.of(context).colorScheme.primary,
                    //         fontSize: 18.0,
                    //       ),
                    //     ),
                    //   ),
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

class Configuracao extends StatelessWidget {
  const Configuracao({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController serverController = TextEditingController();
    final TextEditingController portController = TextEditingController();

    prefs.getString('server') != null
        ? serverController.text = prefs.getString('server')!
        : serverController.text = "";

    prefs.getString('port') != null
        ? portController.text = prefs.getString('port')!
        : portController.text = "";

    return SingleChildScrollView(
      child: SizedBox(
        height: 250.0,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextFormField(
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: 'Servidor',
                ),
                controller: serverController,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o servidor';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextFormField(
                  onTap: () {},
                  decoration: const InputDecoration(
                    labelText: 'Porta',
                  ),
                  controller: portController,
                  keyboardType: TextInputType.number,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira a porta';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final _prefs = await SharedPreferences.getInstance();
                      _prefs.setString('server', serverController.text);
                      _prefs.setString('port', portController.text);
                      getServer();
                      Navigator.pop(context);
                      RestartWidget.restartApp(context);
                    }
                  },
                  child: const Text(
                    'Finalizar',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 25.0),
                    elevation: 5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TempoAgenda extends StatelessWidget {
  const TempoAgenda({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController tempoChaveamentoController =
        TextEditingController();

    prefs.getString('tempoChaveamento') != null
        ? tempoChaveamentoController.text = prefs.getString('tempoChaveamento')!
        : tempoChaveamentoController.text = "";

    return SingleChildScrollView(
      child: SizedBox(
        height: 250.0,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextFormField(
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: 'Tempo (em minutos)',
                ),
                controller: tempoChaveamentoController,
                keyboardType: TextInputType.number,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o tempo';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final _prefs = await SharedPreferences.getInstance();
                      _prefs.setString(
                          'tempoChaveamento', tempoChaveamentoController.text);
                      getTempoBuscaAgenda();
                      Navigator.pop(context);
                      RestartWidget.restartApp(context);
                    }
                  },
                  child: const Text(
                    'Finalizar',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 25.0),
                    elevation: 5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
