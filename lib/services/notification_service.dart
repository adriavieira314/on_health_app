import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:on_health_app/models/custom_notification.dart';
import 'package:on_health_app/utils/app_routes.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';

class NotificationService {
  late FlutterLocalNotificationsPlugin localNotificationsPlugin;
  //detalhes da notificaçao para o android
  late AndroidNotificationDetails androidDetails;

  NotificationService() {
    //cria uma instancia para acessar os dados do android
    localNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _setupNotifications();
  }

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
    androidDetails = const AndroidNotificationDetails(
      'lembretes_notifications_x',
      'Lembretes',
      channelDescription: 'Este canala é para lembretes',
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

  checkForNotifications() async {
    // ao abrir o aplicativo, verifica se existe notificações - getNotificationAppLaunchDetails -
    // e chama o metedo _onSelectedNotification para levar o usuario a pagina destinada á notificações
    final details =
        await localNotificationsPlugin.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      _onSelectedNotification(details.payload);
    }
  }
}
