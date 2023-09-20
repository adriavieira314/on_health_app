import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:on_health_app/exceptions/http_exception.dart';
import 'package:on_health_app/models/municipios.dart';
import 'package:on_health_app/utils/constants.dart';

class MunicipiosProvider with ChangeNotifier {
  ListaMunicipios? _listaMunicipios;

  ListaMunicipios? get listaMunicipios => _listaMunicipios;

  Future<void> loadMunicipios() async {
    final response = await http.get(
      Uri.parse(
        '$serverURL/onhealth/rest/consultas/municipios',
      ),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
    ).timeout(
      Duration(seconds: 30),
      onTimeout: () {
        print('hello');
        return http.Response(
          'Tempo de espera de resposta da URL excedeu. Tente reiniciar o aplicativo.',
          408,
        ); // Request Timeout response status code
      },
    );

    if (response.statusCode == 200) {
      _listaMunicipios =
          ListaMunicipios.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));

      notifyListeners();
    } else {
      throw HttpException(
        'Não foi possivel buscar o endpoint de municípios. Verifique se o servidor está correto.',
      );
    }

    notifyListeners();
  }
}
