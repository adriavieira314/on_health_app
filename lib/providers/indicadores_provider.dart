import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:on_health_app/exceptions/http_exception.dart';
import 'package:on_health_app/models/indicador.dart';

class IndicadoresProvider with ChangeNotifier {
  String? _token;
  Indicador? _indicadorDiabetesUnidade;
  Indicador? _indicadorDiabetesGeral;
  Indicador? _indicadorHipertensaoUnidade;
  Indicador? _indicadorHipertensaoGeral;

  IndicadoresProvider(this._token);

  Indicador? get indicDiabetesUnidade => _indicadorDiabetesUnidade;
  Indicador? get indicDiabetesGeral => _indicadorDiabetesGeral;
  Indicador? get indicHipertensaoUnidade => _indicadorHipertensaoUnidade;
  Indicador? get indicHipertensaoGeral => _indicadorHipertensaoGeral;

  Future<void> indicadorDiabetesUnidade() async {
    final response = await http.get(
      Uri.parse(
        'http://192.168.0.103:8080/onhealth/rest/consultas/gestor/indicadordiabetes?cnes=2708868',
      ),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $_token"
      },
    );

    if (response.statusCode == 200) {
      _indicadorDiabetesUnidade =
          Indicador.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));

      print('_indicadorDiabetesUnidade');
      print(_indicadorDiabetesUnidade);

      notifyListeners();
    } else {
      throw HttpException('Não foi possivel fazer a requisição.');
    }
  }

  Future<void> indicadorDiabetesGeral() async {
    final response = await http.get(
      Uri.parse(
        'http://192.168.0.103:8080/onhealth/rest/consultas/gestor/indicadordiabetes?cnes=${''}',
      ),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $_token"
      },
    );

    if (response.statusCode == 200) {
      _indicadorDiabetesGeral =
          Indicador.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));

      notifyListeners();
    } else {
      throw HttpException('Não foi possivel fazer a requisição.');
    }
  }

  Future<void> indicadorHipertensaoUnidade() async {
    final response = await http.get(
      Uri.parse(
        'http://192.168.0.103:8080/onhealth/rest/consultas/gestor/indicadorhipertensao?cnes=2708868',
      ),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $_token"
      },
    );

    if (response.statusCode == 200) {
      _indicadorHipertensaoUnidade =
          Indicador.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));

      notifyListeners();
    } else {
      throw HttpException('Não foi possivel fazer a requisição.');
    }
  }

  Future<void> indicadorHipertensaoGeral() async {
    final response = await http.get(
      Uri.parse(
        'http://192.168.0.103:8080/onhealth/rest/consultas/gestor/indicadorhipertensao?cnes=${''}',
      ),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $_token"
      },
    );

    if (response.statusCode == 200) {
      _indicadorHipertensaoGeral =
          Indicador.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));

      notifyListeners();
    } else {
      throw HttpException('Não foi possivel fazer a requisição.');
    }
  }
}
