import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:on_health_app/models/agendamentos.dart';

class AgendamentosProvider with ChangeNotifier {
  String? _token;
  String? _cpf;
  String? _cnes;
  ListaAgendamentos? _listaAgendamentosUsuario;
  ListaAgendamentos? _listaAgendamentosGestor;

  AgendamentosProvider(this._token, this._cpf, this._cnes);

  ListaAgendamentos? get listaAgendamentosUsuario => _listaAgendamentosUsuario;
  ListaAgendamentos? get listaAgendamentosGestor => _listaAgendamentosGestor;

  Future<void> loadAgendamentosUsuario() async {
    final response = await http.get(
      Uri.parse(
        'http://192.168.0.103:8080/onhealth/rest/consultas/cidadao/proximosatendimentos?cpf=$_cpf',
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
        // 'http://192.168.0.103:8080/onhealth/rest/consultas/gestor/proximosatendimentos?cnes=$_cnes',
        'http://192.168.0.103:8080/onhealth/rest/consultas/gestor/proximosatendimentos?cnes=2708868',
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
}
