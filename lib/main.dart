import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:on_health_app/models/custom_notification.dart';
import 'package:on_health_app/providers/agendamentos_provider.dart';
import 'package:on_health_app/providers/auth_provider.dart';
import 'package:on_health_app/providers/indicadores_provider.dart';
import 'package:on_health_app/utils/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:workmanager/workmanager.dart';

FlutterLocalNotificationsPlugin localNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
//detalhes da notificaçao para o android
late AndroidNotificationDetails androidDetails;

_setupNotifications() async {
  await _setupTimezone();
  await _initializaNotifications();
}

Future<void> _setupTimezone() async {
  tz.initializeTimeZones(); //inicializa
  // pega o timezone do sistema operacional
  final String? timeZoneName = await FlutterTimezone.getLocalTimezone();
  // seta a localização baseada no nome do timezone do sistema
  tz.setLocalLocation(tz.getLocation(timeZoneName!));
}

_initializaNotifications() async {
  // icone do app para exibir na notificação
  const android = AndroidInitializationSettings('@mipmap/launcher_icon');
  // fazer para macOs, iOS, linux...
  await localNotificationsPlugin.initialize(
    const InitializationSettings(android: android),
    onSelectNotification: _onSelectedNotification,
  );
}

_onSelectedNotification(String? payload) {
  // para qual rota levo o usuario ao clicar na notificação
  if (payload != null) {
    Navigator.of(Routes.navigatorKey!.currentContext!)
        .pushReplacementNamed(payload);
  }
}

showNotification(CustomNotification notification) {
  print('adsadsadasdsad');
  androidDetails = const AndroidNotificationDetails(
    'lembretes_notifications_x',
    'Lembretes',
    channelDescription: 'Este canal é para lembretes',
    importance: Importance.max, //importancia da notificacao
    priority: Priority.max,
    enableVibration: true,
  );

  localNotificationsPlugin.show(
    notification.id,
    notification.title,
    notification.body,
    NotificationDetails(
      android: androidDetails,
    ),
    payload: notification.payload,
  );
}

showNotificationScheduled(CustomNotification notification) {
  final date = DateTime.now().add(const Duration(seconds: 5));

  androidDetails = const AndroidNotificationDetails(
    'lembretes_notifications_x',
    'Lembretes',
    channelDescription: 'Este canal é para lembretes',
    importance: Importance.max, //importancia da notificacao
    priority: Priority.max,
    enableVibration: true,
  );

  localNotificationsPlugin.zonedSchedule(
    notification.id,
    notification.title,
    notification.body,
    tz.TZDateTime.from(date, tz.local),
    NotificationDetails(
      android: androidDetails,
    ),
    payload: notification.payload,
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
  );
}

checkForNotifications() async {
  // ao abrir o aplicativo, verifica se existe notificações - getNotificationAppLaunchDetails -
  // e chama o metedo _onSelectedNotification para levar o usuario a pagina destinada á notificações
  final details =
      await localNotificationsPlugin.getNotificationAppLaunchDetails();
  if (details != null && details.didNotificationLaunchApp) {
    _onSelectedNotification(details.payload);
  }
}

final agenda = {
  "agendamentos": [
    {
      "dtAgenda": "23/05/2023",
      "agendamentos": [
        {
          "nome": "CLECIDIS CRUZ DEODATO",
          "cpf": "16080904268",
          "imc": 17.60,
          "classImc": "Abaixo do Peso",
          "dtAgenda": "21/05/2023",
          "hrAgenda": "08:00",
          "unidadeSaude": "UBS Mae Laurinda",
          "dsCBO": "ENFERMEIRO DA ESTRATÉGIA DE SAÚDE DA FAMÍLIA",
          "nmProfSaude": "IVONETE GUEDES DE SOUZA"
        },
        {
          "nome": "CLECIDIS CRUZ DEODATO",
          "cpf": "16080904268",
          "imc": 17.60,
          "classImc": "Abaixo do Peso",
          "dtAgenda": "21/05/2023",
          "hrAgenda": "08:00",
          "unidadeSaude": "UBS Mae Laurinda",
          "dsCBO": "ENFERMEIRO DA ESTRATÉGIA DE SAÚDE DA FAMÍLIA",
          "nmProfSaude": "IVONETE GUEDES DE SOUZA"
        },
        {
          "nome": "CLECIDIS CRUZ DEODATO",
          "cpf": "16080904268",
          "imc": 17.60,
          "classImc": "Abaixo do Peso",
          "dtAgenda": "21/05/2023",
          "hrAgenda": "08:00",
          "unidadeSaude": "UBS Mae Laurinda",
          "dsCBO": "ENFERMEIRO DA ESTRATÉGIA DE SAÚDE DA FAMÍLIA",
          "nmProfSaude": "IVONETE GUEDES DE SOUZA"
        },
      ]
    },
    {
      "dtAgenda": "22/05/2023",
      "agendamentos": [
        {
          "nome": "CLECIDIS CRUZ DEODATO",
          "cpf": "16080904268",
          "imc": 17.60,
          "classImc": "Abaixo do Peso",
          "dtAgenda": "18/05/2023",
          "hrAgenda": "20:40",
          "unidadeSaude": "UBS Mae Laurinda",
          "dsCBO": "DERMATOLOGIA",
          "nmProfSaude": "CAROLINA CHIRANO"
        }
      ]
    },
  ]
};

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //cria uma instancia para acessar os dados do android
  await _setupNotifications();

  Workmanager().initialize(callbackDispatcher);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProxyProvider<AuthProvider, AgendamentosProvider>(
          create: (_) => AgendamentosProvider('', '', ''),
          update: (ctx, auth, previousProductList) {
            return AgendamentosProvider(
              auth.token ?? '',
              auth.cpf,
              auth.cnes,
            );
          },
        ),
        ChangeNotifierProxyProvider<AuthProvider, IndicadoresProvider>(
          create: (_) => IndicadoresProvider(''),
          update: (ctx, auth, previousProductList) {
            return IndicadoresProvider(
              auth.token ?? '',
            );
          },
        ),
        // Provider<NotificationService>(
        //   create: (context) => NotificationService(),
        // ),
      ],
      child: App(),
    ),
  );
}

void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) {
    // your code that you want to run in background
    print(taskName);
    getDate();
    return Future.value(true);
  });
}

getDate() {
  print('aaaaaaaaaaaaaa');
  final agendamento = agenda;
  for (var i = 0; i < agendamento['agendamentos']!.length; i++) {
    dynamic element = agendamento['agendamentos']![i];

    if (element['agendamentos'].length == 1) {
      convert(element['dtAgenda'], element['agendamentos'][0]['hrAgenda']);
      print('somente um');
    } else {
      convert(element['dtAgenda'], '21:00');
      print('mais de um');
      print(element['dtAgenda']);
    }
  }
}

convert(dateString, hour) {
  print('bbbbbbbbbb');

  var string = dateString;
  print('string');
  print(string);
  var array = string.split('/');
  print('array');
  print(array);
  var newDate = '${array[2]}-${array[1]}-${array[0]} $hour';
  print('newDate');
  print(newDate);

  get24Hours(newDate, dateString);
}

get24Hours(dateFormatted, date) async {
  print('difference.inHours');
  var dateParsed = DateTime.parse(dateFormatted);
  Duration difference = dateParsed.difference(DateTime.now());
  print(difference.inHours);
  print('helllllllloooooooooo');

  if (difference.inHours >= 20 && difference.inHours <= 24) {
    print('entrou aqui');
    await showNotification(
      CustomNotification(
        id: 1,
        title: 'Você tem uma consulta.',
        body: 'Não esqueça sua consulta no dia $date',
        payload: AppRoutes.PATIENT_INFO,
      ),
    );
  } else if (difference.inHours >= 44 && difference.inHours <= 48) {
    print('entrou 48 horas');
    await showNotification(
      CustomNotification(
        id: 1,
        title: 'Você tem uma consulta.',
        body: 'Não esqueça sua consulta no dia $date',
        payload: AppRoutes.PATIENT_INFO,
      ),
    );
    print(difference.inHours);
  }
}

class App extends StatefulWidget {
  const App({
    super.key,
  });

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    checkNotifications();

    print('object');
    Workmanager().registerPeriodicTask(
      'teste27',
      'teste27',
      frequency: Duration(minutes: 15),
    );
  }

  checkNotifications() async {
    await checkForNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'On Health',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green.shade900,
          secondary: Colors.blue.shade50,
        ),
        useMaterial3: false,
      ),
      routes: Routes.list,
      initialRoute: Routes.initial,
      navigatorKey: Routes.navigatorKey,
    );
  }
}
