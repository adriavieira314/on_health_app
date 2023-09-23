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
  dynamic _dadosHipertensao;
  dynamic _dadosDiabetes;

  AgendamentosProvider(this._token, this._cpf, this._cnes);

  get dadosHipertensao => _dadosHipertensao;

  get dadosDiabetes => _dadosDiabetes;

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

  Future<void> getUltimoAtendimento(String cpf) async {
    final response = await http.get(
      Uri.parse(
        '$serverURL/onhealth/rest/consultas/cidadao/ultimosatendimentosgeral?cpf=$cpf&idIBGE=$idIBGE',
      ),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $_token"
      },
    );

    if (response.statusCode != 200) {
      throw HttpException(
        'Não foi possivel buscar informação dos ultimos atendimentos do paciente.',
      );
    }

    final body = jsonDecode(utf8.decode(response.bodyBytes));
    _dadosHipertensao = body['hipertensao'];
    _dadosDiabetes = body['diabetes'];

    notifyListeners();
  }
}
