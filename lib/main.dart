import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_actividad_autonoma/screens/calcluadoraScreen.dart';
import 'package:flutter_application_actividad_autonoma/screens/pantalla1Screen.dart';
import 'package:flutter_application_actividad_autonoma/screens/pantalla2Screen.dart';
import 'package:flutter_application_actividad_autonoma/screens/pantalla3Screen.dart';
import 'package:flutter_application_actividad_autonoma/screens/simpleInteresScreen.dart';
import 'package:flutter_application_actividad_autonoma/screens/simulador_screen.dart';
import 'package:intl/intl.dart';

// ► EJERCICIOS 04 (Drawer)


// ► EJERCICIOS 10-12 (Botones con Stack)


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) => runApp(const EjerciciosApp()));
}

class EjerciciosApp extends StatelessWidget {
  const EjerciciosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ejercicios Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        primarySwatch: Colors.orange,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.white70),
          border: OutlineInputBorder(),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
        ),
      ),
      home: const HomePage(),
      locale: const Locale('es', 'EC'),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Drawer _drawer(BuildContext context) => Drawer(
        backgroundColor: Colors.black,
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.orange),
              child: Center(
                  child: Text('Ejercicios 04',
                      style: TextStyle(fontSize: 24))),
            ),
            _item(context, 'Calculadora de Propinas',
                const TipCalculatorScreen()),
            _item(context, 'Interés Simple', const SimpleInterestScreen()),
            _item(context, 'Simulador de Ahorro',
                const SavingsSimulatorScreen()),
          ],
        ),
      );

  ListTile _item(BuildContext ctx, String t, Widget page) => ListTile(
        title: Text(t),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.orange),
        onTap: () {
          Navigator.pop(ctx);
          Navigator.push(ctx, MaterialPageRoute(builder: (_) => page));
        },
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ejercicios Flutter')),
      drawer: _drawer(context),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _nav(context, 'Ejercicio 10', const Pantalla1()),
            const SizedBox(height: 12),
            _nav(context, 'Ejercicio 11', const Pantalla2()),
            const SizedBox(height: 12),
            _nav(context, 'Ejercicio 12', const Pantalla3()),
          ],
        ),
      ),
    );
  }

  ElevatedButton _nav(BuildContext ctx, String txt, Widget page) =>
      ElevatedButton(
        onPressed: () =>
            Navigator.push(ctx, MaterialPageRoute(builder: (_) => page)),
        child: Text(txt),
      );
}
