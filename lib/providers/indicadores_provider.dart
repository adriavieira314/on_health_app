import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:on_health_app/exceptions/http_exception.dart';
import 'package:on_health_app/models/indicador.dart';
import 'package:on_health_app/utils/constants.dart';

class IndicadoresProvider with ChangeNotifier {
  String? _token;
  String? _cnes;
  Indicador? _indicadorDiabetesUnidade;
  Indicador? _indicadorDiabetesGeral;
  Indicador? _indicadorHipertensaoUnidade;
  Indicador? _indicadorHipertensaoGeral;
  Indicador? _indicadorAcessoHipertensaoUnidade;
  Indicador? _indicadorAcessoHipertensaoGeral;
  Indicador? _indicadorAcessoDiabetesUnidade;
  Indicador? _indicadorAcessoDiabetesGeral;

  IndicadoresProvider(this._token, this._cnes);

  Indicador? get indicDiabetesUnidade => _indicadorDiabetesUnidade;
  Indicador? get indicDiabetesGeral => _indicadorDiabetesGeral;
  Indicador? get indicHipertensaoUnidade => _indicadorHipertensaoUnidade;
  Indicador? get indicHipertensaoGeral => _indicadorHipertensaoGeral;
  Indicador? get indicAcessoHipertensaoUnidade =>
      _indicadorAcessoHipertensaoUnidade;
  Indicador? get indicAcessoHipertensaoGeral =>
      _indicadorAcessoHipertensaoGeral;
  Indicador? get indicAcessoDiabetesUnidade => _indicadorAcessoDiabetesUnidade;
  Indicador? get indicAcessoDiabetesGeral => _indicadorAcessoDiabetesGeral;

  Future<void> indicadorDiabetesUnidade() async {
    final response = await http.get(
      Uri.parse(
        // '$serverURL/onhealth/rest/consultas/gestor/indicadordiabetes?cnes=$_cnes&idIBGE=$idIBGE',
        '$serverURL/onhealth/rest/consultas/gestor/indicadordiabetes?cnes=2708868&idIBGE=$idIBGE',
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

      notifyListeners();
    } else {
      throw HttpException(
          'Não foi possivel fazer a requisição: indicador diabetes unidade.');
    }
  }

  Future<void> indicadorDiabetesGeral() async {
    final response = await http.get(
      Uri.parse(
        '$serverURL/onhealth/rest/consultas/gestor/indicadordiabetes?idIBGE=$idIBGE',
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
      throw HttpException(
          'Não foi possivel fazer a requisição: indicador diabetes geral.');
    }
  }

  Future<void> indicadorHipertensaoUnidade() async {
    final response = await http.get(
      Uri.parse(
        // '$serverURL/onhealth/rest/consultas/gestor/indicadorhipertensao?cnes=$_cnes&idIBGE=$idIBGE',
        '$serverURL/onhealth/rest/consultas/gestor/indicadorhipertensao?cnes=2708868&idIBGE=$idIBGE',
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
      throw HttpException(
          'Não foi possivel fazer a requisição: indicador hipertensao unidade');
    }
  }

  Future<void> indicadorHipertensaoGeral() async {
    final response = await http.get(
      Uri.parse(
        '$serverURL/onhealth/rest/consultas/gestor/indicadorhipertensao?idIBGE=$idIBGE',
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
      throw HttpException(
          'Não foi possivel fazer a requisição: indicador hipertensão geral');
    }
  }

  Future<void> indicadorAcessoHipertensaoUnidade() async {
    final response = await http.get(
      Uri.parse(
        // '$serverURL/onhealth/rest/consultas/gestor/indicadoracessohipertensao?cnes=$_cnes&idIBGE=$idIBGE',
        '$serverURL/onhealth/rest/consultas/gestor/indicadoracessohipertensao?cnes=2708868&idIBGE=$idIBGE',
      ),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $_token"
      },
    );

    if (response.statusCode == 200) {
      _indicadorAcessoHipertensaoUnidade =
          Indicador.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));

      notifyListeners();
    } else {
      throw HttpException(
          'Não foi possivel fazer a requisição: indicador acesso hipertensao unidade.');
    }
  }

  Future<void> indicadorAcessoHipertensaoGeral() async {
    final response = await http.get(
      Uri.parse(
        '$serverURL/onhealth/rest/consultas/gestor/indicadoracessohipertensao?idIBGE=$idIBGE',
      ),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $_token"
      },
    );

    if (response.statusCode == 200) {
      _indicadorAcessoHipertensaoGeral =
          Indicador.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));

      notifyListeners();
    } else {
      throw HttpException(
          'Não foi possivel fazer a requisição: indicador acesso hipertensao geral');
    }
  }

  Future<void> indicadorAcessoDiabetesUnidade() async {
    final response = await http.get(
      Uri.parse(
        // '$serverURL/onhealth/rest/consultas/gestor/indicadoracessodiabetes?cnes=$_cnes&idIBGE=$idIBGE',
        '$serverURL/onhealth/rest/consultas/gestor/indicadoracessodiabetes?cnes=2708868&idIBGE=$idIBGE',
      ),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $_token"
      },
    );

    if (response.statusCode == 200) {
      _indicadorAcessoDiabetesUnidade =
          Indicador.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));

      notifyListeners();
    } else {
      throw HttpException(
          'Não foi possivel fazer a requisição: indicador acesso diabetes unidade.');
    }
  }

  Future<void> indicadorAcessoDiabetesGeral() async {
    final response = await http.get(
      Uri.parse(
        '$serverURL/onhealth/rest/consultas/gestor/indicadoracessodiabetes?idIBGE=$idIBGE',
      ),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $_token"
      },
    );

    if (response.statusCode == 200) {
      _indicadorAcessoDiabetesGeral =
          Indicador.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));

      notifyListeners();
    } else {
      throw HttpException(
          'Não foi possivel fazer a requisição: indicador acesso diabetes geral');
    }
  }
}
