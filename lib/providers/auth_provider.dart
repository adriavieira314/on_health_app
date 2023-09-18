import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:on_health_app/data/store.dart';
import 'package:on_health_app/exceptions/http_exception.dart';
import 'package:on_health_app/utils/constants.dart';

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
  dynamic _dadosHipertensao;
  dynamic _dadosDiabetes;
  dynamic _userData;

  bool get hasToken {
    return _token != null && _token != '';
  }

  bool get isAdmin {
    return _cnes != null && _cnes != '';
  }

  String? get token {
    return hasToken ? _token : null;
  }

  String? get cpf {
    return _cpf != '' ? _cpf : null;
  }

  String? get cnes {
    return _cnes != '' ? _cnes : null;
  }

  get dadosHipertensao => _dadosHipertensao;

  get dadosDiabetes => _dadosDiabetes;

  get userData => _userData;

  Future<void> _authenticate(
    String cpf,
    String password,
    String urlFragment,
  ) async {
    final url = '$serverURL/onhealth/rest/consultas/$urlFragment/login';
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode({
        'cpf': cpf,
        'dtNasc': password,
        'idIBGE': idIBGE,
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
    _userData = await Store.getMap('userData');
    if (_userData.isEmpty) return false;

    _token = _userData['token'] ?? '';
    _cpf = _userData['cpf'] ?? '';
    _dtNasc = _userData['dtNasc'] ?? '';
    _nome = _userData['nome'] ?? '';
    _nomeMae = _userData['nomeMae'] ?? '';
    _endereco = _userData['endereco'] ?? '';
    _imc = _userData['imc'] ?? 0.0;
    _classImc = _userData['classImc'] ?? '';
    _cnes = _userData['cnes'] ?? '';
    _unidadeSaude = _userData['unidadeSaude'] ?? '';
    _dsCBO = _userData['dsCBO'] ?? '';

    final url =
        '$serverURL/onhealth/rest/consultas/cidadao/ultimosatendimentos?cpf=$_cpf&idIBGE=$idIBGE';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $_token"
      },
    ).timeout(
      Duration(seconds: 60),
      onTimeout: () {
        print('hello');
        return http.Response(
          'Tempo de espera de resposta da URL excedeu. Tente reiniciar o aplicativo.',
          408,
        ); // Request Timeout response status code
      },
    );

    if (response.statusCode == 401 || response.statusCode != 200) {
      logout();
      return false;
    }

    final body = jsonDecode(utf8.decode(response.bodyBytes));
    _dadosHipertensao = body['hipertensao'];
    _dadosDiabetes = body['diabetes'];

    return true;
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
