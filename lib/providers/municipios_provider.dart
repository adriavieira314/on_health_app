import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:on_health_app/data/store.dart';
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
    );

    if (response.body == 'null' || response.body == null) return;

    _listaMunicipios =
        ListaMunicipios.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    print(_listaMunicipios);

    notifyListeners();
  }
}
