import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:on_health_app/models/agendamentos.dart';
import 'package:on_health_app/utils/constants.dart';

class AgendamentosProvider with ChangeNotifier {
  String? _token;
  String? _cpf;
  String? _cnes;
  ListaAgendamentos? _listaAgendamentosUsuario;
  ListaAgendamentos? _listaAgendamentosGestor;
  ListaAgendamentos? _listaFake;

  AgendamentosProvider(this._token, this._cpf, this._cnes);

  ListaAgendamentos? get listaAgendamentosUsuario => _listaAgendamentosUsuario;
  ListaAgendamentos? get listaAgendamentosGestor => _listaAgendamentosGestor;
  ListaAgendamentos? get listaFake => _listaFake;

  Future<void> loadAgendamentosUsuario() async {
    final response = await http.get(
      Uri.parse(
        '$serverURL/onhealth/rest/consultas/cidadao/proximosatendimentos?cpf=$_cpf',
      ),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $_token"
      },
    );

    if (response.body == 'null' || response.body == null) return;

    _listaAgendamentosUsuario =
        ListaAgendamentos.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));

    notifyListeners();
  }

  Future<void> loadAgendamentosGestor() async {
    final response = await http.get(
      Uri.parse(
        // '$serverURL/onhealth/rest/consultas/gestor/proximosatendimentos?cnes=$_cnes',
        '$serverURL/onhealth/rest/consultas/gestor/proximosatendimentos?cnes=2708868',
      ),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $_token"
      },
    );

    if (response.body == 'null' || response.body == null) return;

    _listaAgendamentosGestor =
        ListaAgendamentos.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));

    notifyListeners();
  }

  Future<void> loadFake() async {
    final response = await http.get(
      Uri.parse('https://my.api.mockaroo.com/users.json?key=7eccf8d0'),
    );

    if (response.body == 'null' || response.body == null) return;
    // print('response.body');
    // print(response.body);

    _listaFake =
        ListaAgendamentos.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));

    notifyListeners();
  }
}

class Fake {
  Future loadFake() async {
    final response = await http.get(
      Uri.parse(
        'https://my.api.mockaroo.com/users.json?key=7eccf8d0',
      ),
    );

    print(response);
    if (response.statusCode == 200) {
      print('mandando resposta lista_acao_dao');
      print(response.body);

      return ListaAgendamentos.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      print('response.erro lista_acao_dao');
      print(response.body);
      throw Exception('Failed to load lista de acao');
    }
  }
}
