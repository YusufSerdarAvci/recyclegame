import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recycle_game/screens/auth_screen.dart';
import 'package:recycle_game/screens/main_menu_screen.dart';
import 'package:recycle_game/services/auth_service.dart';
import 'package:recycle_game/services/settings_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  await Firebase.initializeApp();
  // Artık kullanıcıyı burada değil, AuthWrapper içinde yöneteceğiz.

  runApp(
    MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService()),
        ChangeNotifierProvider<SettingsService>(create: (_) => SettingsService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsService>(context);

    return MaterialApp(
      title: 'Recycle Game',
      theme: ThemeData(
         primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.green[100],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.green[700],
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green[600],
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            textStyle: const TextStyle(fontSize: 18),
          ),
        ),
      ),
      locale: settings.locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: AuthWrapper(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    
    return StreamBuilder<User?>(
      stream: authService.user,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            // Kullanıcı oturum açmış
            return const MainMenuScreen();
          }
          // Kullanıcı oturum açmamış
          return const AuthScreen();
        }
        // Bağlantı bekleniyor
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}