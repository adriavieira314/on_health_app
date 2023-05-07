import 'package:flutter/material.dart';
import 'package:on_health_app/providers/auth_provider.dart';
import 'package:on_health_app/services/notification_service.dart';
import 'package:on_health_app/utils/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    checkNotifications();
  }

  checkNotifications() async {
    await Provider.of<NotificationService>(context, listen: false)
        .checkForNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        Provider<NotificationService>(
          create: (context) => NotificationService(),
        ),
      ],
      child: MaterialApp(
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
      ),
    );
  }
}
