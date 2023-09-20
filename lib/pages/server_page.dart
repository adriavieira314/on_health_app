import 'package:flutter/material.dart';
import 'package:on_health_app/main.dart';
import 'package:on_health_app/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:on_health_app/utils/app_routes.dart';

class ServerPage extends StatefulWidget {
  const ServerPage({super.key});

  @override
  State<ServerPage> createState() => _ServerPageState();
}

class _ServerPageState extends State<ServerPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController serverController = TextEditingController();
  final TextEditingController portController = TextEditingController();
  final _portaFocus = FocusNode();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    prefs.getString('server') != null
        ? serverController.text = prefs.getString('server')!
        : serverController.text = "";

    prefs.getString('port') != null
        ? portController.text = prefs.getString('port')!
        : portController.text = "";

    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 15.0, bottom: 8.0),
                          child: Text(
                            'Servidor',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Ex.: 000.000.0.000',
                            border: OutlineInputBorder(),
                          ),
                          controller: serverController,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(_portaFocus);
                          },
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira o servidor';
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
                          padding:
                              const EdgeInsets.only(left: 15.0, bottom: 8.0),
                          child: Text(
                            'Porta',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Porta',
                            border: OutlineInputBorder(),
                          ),
                          controller: portController,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          focusNode: _portaFocus,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira a porta';
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
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final _prefs =
                                await SharedPreferences.getInstance();
                            _prefs.setString('server', serverController.text);
                            _prefs.setString('port', portController.text);
                            getServer();
                            setState(() => _isLoading = true);
                            Navigator.of(context)
                                .pushNamed(AppRoutes.MUNICIPIOS);
                          }
                        },
                        child: const Text(
                          'Salvar',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
