import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:on_health_app/models/agendamentos.dart';

class AgendamentosProvider with ChangeNotifier {
  ListaAgendamentos? _listaAgendamentos;

  ListaAgendamentos? get listaAgendamentos => _listaAgendamentos;

  Future<void> loadAgendamentos() async {
    final token =
        "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIxMzUzMjk3OTI2OCIsImV4cCI6MTY4MzY4NjkwOX0.ipjbbKUsNaJf2PZHRJ3DaJiYruTUMNynO-YevqA6UZo4RbTNgNRcv4jmQQ8-jbKuS0IILmIRVVD_FdAvO0Vjkg";
    final response = await http.get(
      Uri.parse(
        'http://192.168.0.103:8080/onhealth/rest/consultas/cidadao/proximosatendimentos?cpf=16080904268',
      ),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );

    if (response.body == 'null') return;

    _listaAgendamentos =
        ListaAgendamentos.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    print(_listaAgendamentos!.agendamentos![0].agendamentos![0].cpf);

    notifyListeners();
  }
}
