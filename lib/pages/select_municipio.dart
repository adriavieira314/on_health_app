import 'package:flutter/material.dart';
import 'package:on_health_app/models/municipios.dart';
import 'package:on_health_app/providers/municipios_provider.dart';
import 'package:on_health_app/utils/app_routes.dart';
import 'package:on_health_app/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectMunicipioPage extends StatelessWidget {
  const SelectMunicipioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MunicipiosDropdownButton(),
    );
  }
}

class MunicipiosDropdownButton extends StatefulWidget {
  const MunicipiosDropdownButton({super.key});

  @override
  State<MunicipiosDropdownButton> createState() =>
      Municipios_DropdownButtonState();
}

class Municipios_DropdownButtonState extends State<MunicipiosDropdownButton> {
  bool loading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<MunicipiosProvider>(
      context,
      listen: false,
    ).loadMunicipios().then((value) {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final listaMunicipios = Provider.of<MunicipiosProvider>(
      context,
      listen: true,
    ).listaMunicipios;
    Municipios dropdownValue = listaMunicipios!.municipios!.first;
    fetchIdIBGE(dropdownValue);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 18.0),
        child: Center(
          child: loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    Image.asset(
                      'assets/images/logo_1.png',
                      width: 300,
                      height: 220,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: Text(
                              'Selecione o município em que você está:',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          listaMunicipios.municipios!.length == 0
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Container(
                                  width: mediaQuery.size.width,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.black38, width: 1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                        10.0,
                                        8.0,
                                        10.0,
                                        8.0,
                                      ),
                                      child: DropdownButton<Municipios>(
                                        value: dropdownValue,
                                        elevation: 16,
                                        style: const TextStyle(
                                            color: Colors.green,
                                            fontSize: 20.0),
                                        underline: Container(
                                          height: 0,
                                          color: Colors.deepPurpleAccent,
                                        ),
                                        onChanged: (Municipios? value) {
                                          setState(() async {
                                            dropdownValue = value!;
                                            print(dropdownValue);
                                            await fetchIdIBGE(dropdownValue);
                                          });
                                        },
                                        items: listaMunicipios.municipios!
                                            .map<DropdownMenuItem<Municipios>>(
                                                (Municipios value) {
                                          return DropdownMenuItem<Municipios>(
                                            value: value,
                                            child: Text(value.municipio!),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(mediaQuery.size.width, 55),
                                elevation: 8,
                                shadowColor: Colors.grey,
                              ),
                              onPressed: () => {
                                Navigator.of(context)
                                    .pushNamed(AppRoutes.AUTH_OR_HOME)
                              },
                              child: const Text(
                                'Próximo',
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Future<void> fetchIdIBGE(Municipios dropdownValue) async {
    final _prefs = await SharedPreferences.getInstance();

    _prefs.setString('idIBGE', dropdownValue.id!);
    getIdIBGE();
  }
}
