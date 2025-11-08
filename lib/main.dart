import 'package:e_commerce/pages/home_page.dart';
import 'package:e_commerce/pages/login_page.dart';
import 'package:e_commerce/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const TireStoreApp());
}

class TireStoreApp extends StatelessWidget {
  const TireStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'إدارة مخزن الكاوتش',
      locale: const Locale('ar'),
      supportedLocales: const [Locale('ar'), Locale('en')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        fontFamily: 'Roboto',
        primaryColor: const Color(0xFF0B7A75),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0B7A75),
          brightness: Brightness.light,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      routes: {
        LoginPage.routeName: (context) => const LoginPage(),
        RegisterPage.routeName: (context) => const RegisterPage(),
        HomePage.routeName: (context) => const HomePage(),
      },
      initialRoute: LoginPage.routeName,
    );
  }
}
