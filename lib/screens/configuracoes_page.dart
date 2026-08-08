import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/premium_card.dart';

class ConfiguracoesPage extends StatefulWidget {
  const ConfiguracoesPage({super.key});

  @override
  State<ConfiguracoesPage> createState() => _ConfiguracoesPageState();
}

class _ConfiguracoesPageState extends State<ConfiguracoesPage> {
  bool notificacoes = true;
  bool biometria = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGray,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Configuracoes',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              PremiumCard(
                child: Column(
                  children: [
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      value: notificacoes,
                      activeColor: AppColors.secondaryBlue,
                      title: const Text('Notificacoes de fatura'),
                      subtitle: const Text('Avisos antes do vencimento.'),
                      onChanged: (value) {
                        setState(() {
                          notificacoes = value;
                        });
                      },
                    ),
                    const Divider(),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      value: biometria,
                      activeColor: AppColors.secondaryBlue,
                      title: const Text('Entrada segura'),
                      subtitle: const Text('Preparado para biometria futura.'),
                      onChanged: (value) {
                        setState(() {
                          biometria = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              const PremiumCard(
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.api, color: AppColors.secondaryBlue),
                  title: Text('API local'),
                  subtitle: Text('http://localhost:3000'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
