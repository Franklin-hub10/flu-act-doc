import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_actividad_autonoma/estudianteScreen.dart';
import 'package:flutter_application_actividad_autonoma/screens/calcluadoraScreen.dart';
import 'package:flutter_application_actividad_autonoma/screens/simpleInteresScreen.dart';
import 'package:flutter_application_actividad_autonoma/screens/simulador_screen.dart';
import 'package:flutter_application_actividad_autonoma/screens/pantalla1Screen.dart';
import 'package:flutter_application_actividad_autonoma/screens/pantalla2Screen.dart';
import 'package:flutter_application_actividad_autonoma/screens/pantalla3Screen.dart';
import 'package:flutter_application_actividad_autonoma/bibliotecaScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const EjerciciosApp());
}

class EjerciciosApp extends StatelessWidget {
  const EjerciciosApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ejercicios Flutter',
        locale: const Locale('es', 'EC'),
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
        ),
        home: const HomePage(),
      );
}

// ─────────────────────────────────────────────
//      HOME   (Stack + Drawer + BottomNav)
// ─────────────────────────────────────────────
class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Drawer –––––––––––––––––––––––––––––––––––
  Drawer _drawer(BuildContext context) => Drawer(
        backgroundColor: Colors.black,
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.orange),
              child: Center(
                child: Text('Ejercicios 04', style: TextStyle(fontSize: 24)),
              ),
            ),
            _drawerItem(context, 'Calculadora de Propinas',
                const TipCalculatorScreen()),
            _drawerItem(context, 'Interés Simple', const SimpleInterestScreen()),
            _drawerItem(
                context, 'Simulador de Ahorro', const SavingsSimulatorScreen()),
          ],
        ),
      );

  ListTile _drawerItem(BuildContext ctx, String t, Widget page) => ListTile(
        title: Text(t),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.orange),
        onTap: () {
          Navigator.pop(ctx);
          Navigator.push(ctx, MaterialPageRoute(builder: (_) => page));
        },
      );

  // Botones (Stack) –––––––––––––––––––––––––––
  ElevatedButton _stackBtn(BuildContext ctx, String label, Widget page) =>
      ElevatedButton(
        onPressed: () =>
            Navigator.push(ctx, MaterialPageRoute(builder: (_) => page)),
        child: Text(label),
      );

  // BottomNavigationBar (button tap) –––––––––––
  int _currentBNIndex = -1; // no resalta nada al inicio

  void _onBottomTap(int index) {
    setState(() => _currentBNIndex = index);
    if (index == 0) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const EstudianteScreen()));
    } else if (index == 1) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const BibliotecaScreen()));
    }
  }

  // UI ––––––––––––––––––––––––––––––––––––––––
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Ejercicios Flutter')),
        drawer: _drawer(context),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _stackBtn(context, 'Ejercicio 10', const Pantalla1()),
              const SizedBox(height: 12),
              _stackBtn(context, 'Ejercicio 11', const Pantalla2()),
              const SizedBox(height: 12),
              _stackBtn(context, 'Ejercicio 12', const Pantalla3()),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.white70,
          currentIndex:
              _currentBNIndex < 0 ? 0 : _currentBNIndex, // evita warning
          onTap: _onBottomTap,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.school), label: 'Materias'),
            BottomNavigationBarItem(
                icon: Icon(Icons.library_books), label: 'Biblioteca'),
          ],
        ),
      );
}
