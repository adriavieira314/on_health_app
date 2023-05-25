import 'package:flutter/material.dart';
import 'package:on_health_app/providers/agendamentos_provider.dart';
import 'package:on_health_app/providers/auth_provider.dart';
import 'package:on_health_app/providers/indicadores_provider.dart';
import 'package:on_health_app/services/notification_service.dart';
import 'package:on_health_app/utils/app_routes.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
        Provider<NotificationService>(
          create: (context) => NotificationService(),
        ),
      ],
      child: App(),
    ),
  );
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
