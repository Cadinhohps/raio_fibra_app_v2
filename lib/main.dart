import 'package:flutter/material.dart';
import 'screens/home_page.dart';
import 'theme/app_theme.dart';
import 'widgets/premium_card.dart';

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
            icon: Icon(Icons.card_giftcard),
            label: 'Vantagens',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}

class FaturasPage extends StatelessWidget {
  const FaturasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SimplePage(
      title: 'Faturas',
      icon: Icons.receipt_long,
      description:
          'Aqui ficarão as faturas, PIX, QR Code, segunda via e pagamento online.',
    );
  }
}

class SuportePage extends StatelessWidget {
  const SuportePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SimplePage(
      title: 'Suporte',
      icon: Icons.support_agent,
      description:
          'Aqui o cliente poderá abrir chamado, acompanhar protocolo e falar com a Raio IA.',
    );
  }
}

class VantagensPage extends StatelessWidget {
  const VantagensPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SimplePage(
      title: 'Vantagens',
      icon: Icons.card_giftcard,
      description:
          'Aqui ficarão promoções, benefícios, parceiros, descontos e indique e ganhe.',
    );
  }
}

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SimplePage(
      title: 'Perfil',
      icon: Icons.person,
      description:
          'Aqui o cliente poderá alterar senha, telefone, endereço e preferências.',
    );
  }
}

class SimplePage extends StatelessWidget {
  final String title;
  final IconData icon;
  final String description;

  const SimplePage({
    super.key,
    required this.title,
    required this.icon,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: premiumCardDecoration(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 70, color: AppColors.secondaryBlue),
              const SizedBox(height: 20),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
