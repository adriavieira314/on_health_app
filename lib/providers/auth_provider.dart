import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:on_health_app/data/store.dart';
import 'package:on_health_app/exceptions/http_exception.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  String? _cpf;
  String? _dtNasc;
  String? _nome;
  String? _nomeMae;
  String? _endereco;
  double? _imc;
  String? _classImc;
  String? _cnes;
  String? _unidadeSaude;
  String? _dsCBO;

  bool get hasToken {
    return _token != null && _token != '';
  }

  bool get isAdmin {
    return _cnes != null && _cnes != '';
  }

  Future<void> _authenticate(
    String cpf,
    String password,
    String urlFragment,
  ) async {
    final url =
        'http://192.168.0.103:8080/onhealth/rest/consultas/$urlFragment/login';
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode({
        'cpf': cpf,
        'dtNasc': password,
      }),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json"
      },
    );

    final body = jsonDecode(utf8.decode(response.bodyBytes));

    if (response.statusCode == 200) {
      _token = body['token'] ?? '';
      _cpf = body['cpf'] ?? '';
      _dtNasc = body['dtNasc'] ?? '';
      _nome = body['nome'] ?? '';
      _nomeMae = body['nomeMae'] ?? '';
      _endereco = body['endereco'] ?? '';
      _imc = body['imc'] ?? 0.0;
      _classImc = body['classImc'] ?? '';
      _cnes = body['cnes'] ?? '';
      _unidadeSaude = body['unidadeSaude'] ?? '';
      _dsCBO = body['dsCBO'] ?? '';

      Store.saveMap('userData', {
        'token': _token,
        'cpf': _cpf,
        'dtNasc': _dtNasc,
        'nome': _nome,
        'nomeMae': _nomeMae,
        'endereco': _endereco,
        'imc': _imc,
        'classImc': _classImc,
        'cnes': _cnes,
        'unidadeSaude': _unidadeSaude,
        'dsCBO': _dsCBO,
      });

      notifyListeners();
    } else if (response.statusCode == 404) {
      throw HttpException(body['message']);
    } else {
      throw HttpException(body['message'] ?? null);
    }
  }

  Future<void> loginAdmin(String cpf, String password) async {
    return _authenticate(cpf, password, 'gestor');
  }

  Future<void> loginUser(String cpf, String password) async {
    return _authenticate(cpf, password, 'cidadao');
  }

  Future<bool> tryAutoLogout() async {
    final userData = await Store.getMap('userData');
    if (userData.isEmpty) return false;

    _token = userData['token'] ?? '';
    _cpf = userData['cpf'] ?? '';
    _dtNasc = userData['dtNasc'] ?? '';
    _nome = userData['nome'] ?? '';
    _nomeMae = userData['nomeMae'] ?? '';
    _endereco = userData['endereco'] ?? '';
    _imc = userData['imc'] ?? 0.0;
    _classImc = userData['classImc'] ?? '';
    _cnes = userData['cnes'] ?? '';
    _unidadeSaude = userData['unidadeSaude'] ?? '';
    _dsCBO = userData['dsCBO'] ?? '';

    final url =
        'http://192.168.0.103:8080/onhealth/rest/consultas/cidadao/ultimosatendimentos?cpf=$_cpf';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $_token"
      },
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(utf8.decode(response.bodyBytes));
      //salvar os dados do usuario
    }

    return response.statusCode == 401 ? false : true;
  }

  void logout() {
    _token = null;
    _cpf = null;
    _dtNasc = null;
    _nome = null;
    _nomeMae = null;
    _endereco = null;
    _imc = null;
    _classImc = null;
    _cnes = null;
    _unidadeSaude = null;
    _dsCBO = null;

    Store.remove('userData');
  }
}
