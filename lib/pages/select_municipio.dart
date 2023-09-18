import 'package:flutter/material.dart';
import 'package:on_health_app/models/municipios.dart';
import 'package:on_health_app/providers/municipios_provider.dart';
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
          child: Column(
            children: [
              Text(
                'Selecione o município em que você está:',
                style: const TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              loading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : listaMunicipios.municipios!.length == 0
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container(
                          width: mediaQuery.size.width * 0.9,
                          margin: EdgeInsets.only(top: 30.0),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: Colors.black38, width: 2),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  10.0, 8.0, 10.0, 8.0),
                              child: DropdownButton<Municipios>(
                                value: dropdownValue,
                                elevation: 16,
                                style: const TextStyle(
                                    color: Colors.green, fontSize: 20.0),
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
