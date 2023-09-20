import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:on_health_app/exceptions/http_exception.dart';
import 'package:on_health_app/models/agendamentos.dart';
import 'package:on_health_app/utils/constants.dart';

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
        '$serverURL/onhealth/rest/consultas/cidadao/proximosatendimentos?cpf=$_cpf&idIBGE=$idIBGE',
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
        '$serverURL/onhealth/rest/consultas/gestor/proximosatendimentos?cnes=2708868&idIBGE=$idIBGE',
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

  Future<void> changeAgendamentoStatus(int stts, int id, String cpf) async {
    print(stts);
    print(id);
    print(cpf);
    final url =
        '$serverURL/onhealth/rest/consultas/cidadao/proximosatendimentos/alterarstatus';

    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode({
        "idAgendamento": id,
        "cpf": cpf,
        "stAgendamento": stts,
      }),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $_token"
      },
    );

    if (response.statusCode != 200) {
      throw HttpException(
        'Não foi possivel alterar o status do servidor.',
      );
    }

    notifyListeners();
  }
}
