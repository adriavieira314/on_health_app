import 'package:shared_preferences/shared_preferences.dart';

String serverURL = "";
int tempoBuscaAgenda = 5;
dynamic cancelTimer;

void getServer() async {
  final prefs = await SharedPreferences.getInstance();
  String? server;
  String? port;

  if (prefs.getString('server') == null) {
    server = "";
    port = "";
  } else {
    server = prefs.getString('server');
    port = prefs.getString('port');
    server = server!.trim();
    port = port!.trim();
    serverURL = "http://$server:$port";
  }
}

void getTempoBuscaAgenda() async {
  final prefs = await SharedPreferences.getInstance();

  if (prefs.getString('tempoChaveamento') == null) {
    tempoBuscaAgenda = 5;
  } else {
    tempoBuscaAgenda = int.parse(prefs.getString('tempoChaveamento')!);
  }
}
