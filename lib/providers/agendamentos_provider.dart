import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:on_health_app/models/agendamentos.dart';

class AgendamentosProvider with ChangeNotifier {
  ListaAgendamentos? _listaAgendamentosUsuario;
  ListaAgendamentos? _listaAgendamentosGestor;

  ListaAgendamentos? get listaAgendamentosUsuario => _listaAgendamentosUsuario;
  ListaAgendamentos? get listaAgendamentosGestor => _listaAgendamentosGestor;

  Future<void> loadAgendamentosUsuario() async {
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

    _listaAgendamentosUsuario =
        ListaAgendamentos.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    print(_listaAgendamentosUsuario!.agendamentos![0].agendamentos![0].cpf);

    notifyListeners();
  }

  Future<void> loadAgendamentosGestor() async {
    final token =
        "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIxNDkzNTM5MjIxNSIsImV4cCI6MTY4Mzg1MTkxMX0.eJqzT4xpWyKNnvkh2iZlWo0fPysMIiRgpZdW0jwBgZ38NY8kcIpy1ixUxFuwR15gwSEk4Bpeu9FILjmkz1706A";
    final response = await http.get(
      Uri.parse(
        'http://192.168.0.103:8080/onhealth/rest/consultas/gestor/proximosatendimentos?cnes=2708868',
      ),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );

    if (response.body == 'null') return;

    _listaAgendamentosGestor =
        ListaAgendamentos.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    print(_listaAgendamentosGestor!.agendamentos![0].agendamentos![0].cpf);

    notifyListeners();
  }
}
