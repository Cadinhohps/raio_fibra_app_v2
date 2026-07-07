import 'package:flutter/material.dart';

import 'theme/app_theme.dart';
import 'screens/home_page.dart';
import 'screens/faturas_page.dart';
import 'screens/suporte_page.dart';
import 'screens/raio_ia_page.dart';
import 'screens/vantagens_page.dart';
import 'screens/perfil_page.dart';

void main() {
  runApp(const RaioFibraApp());
}

class RaioFibraApp extends StatelessWidget {
  const RaioFibraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Raio Fibra IA',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int currentIndex = 0;

  final List<Widget> pages = const [
    HomePage(),
    FaturasPage(),
    SuportePage(),
    RaioIaPage(),
    VantagensPage(),
    PerfilPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.secondaryBlue,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        elevation: 12,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Faturas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.support_agent),
            label: 'Suporte',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.smart_toy),
            label: 'Raio IA',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: 'Vantagens',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}
