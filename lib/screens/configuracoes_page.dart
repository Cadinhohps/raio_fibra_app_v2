import 'package:flutter/material.dart';

class ConfiguracoesPage extends StatefulWidget {
  const ConfiguracoesPage({super.key});

  @override
  State<ConfiguracoesPage> createState() => _ConfiguracoesPageState();
}

class _ConfiguracoesPageState extends State<ConfiguracoesPage> {
  bool notificacoes = true;
  bool biometria = false;
  bool avisoWhatsApp = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _ConfigColors.orange,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 28),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 860),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _TopBar(onBack: () => Navigator.pop(context)),
                  const SizedBox(height: 16),
                  const _HeroCard(),
                  const SizedBox(height: 22),
                  const Text(
                    'Preferências',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 14),
                  _WhiteCard(
                    child: Column(
                      children: [
                        SwitchListTile(
                          contentPadding: EdgeInsets.zero,
                          value: notificacoes,
                          activeThumbColor: _ConfigColors.orange,
                          title: const Text(
                            'Notificações de fatura',
                            style: TextStyle(fontWeight: FontWeight.w900),
                          ),
                          subtitle: const Text(
                            'Receber avisos antes do vencimento.',
                          ),
                          secondary: const Icon(
                            Icons.notifications_active,
                            color: _ConfigColors.blue,
                          ),
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
                          activeThumbColor: _ConfigColors.orange,
                          title: const Text(
                            'Entrada segura',
                            style: TextStyle(fontWeight: FontWeight.w900),
                          ),
                          subtitle: const Text(
                            'Preparado para biometria futura.',
                          ),
                          secondary: const Icon(
                            Icons.fingerprint,
                            color: _ConfigColors.blue,
                          ),
                          onChanged: (value) {
                            setState(() {
                              biometria = value;
                            });
                          },
                        ),
                        const Divider(),
                        SwitchListTile(
                          contentPadding: EdgeInsets.zero,
                          value: avisoWhatsApp,
                          activeThumbColor: _ConfigColors.orange,
                          title: const Text(
                            'Avisos pelo WhatsApp',
                            style: TextStyle(fontWeight: FontWeight.w900),
                          ),
                          subtitle: const Text(
                            'Receber lembretes e protocolos pelo atendimento.',
                          ),
                          secondary: const Icon(
                            Icons.chat,
                            color: _ConfigColors.blue,
                          ),
                          onChanged: (value) {
                            setState(() {
                              avisoWhatsApp = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  const Text(
                    'Atendimento e sistema',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 14),
                  const _SettingsTile(
                    icon: Icons.phone_in_talk,
                    title: 'WhatsApp de atendimento',
                    subtitle: '+55 81 98963-4191',
                  ),
                  const SizedBox(height: 12),
                  const _SettingsTile(
                    icon: Icons.api,
                    title: 'API local',
                    subtitle: 'http://localhost:3000',
                  ),
                  const SizedBox(height: 12),
                  const _SettingsTile(
                    icon: Icons.info,
                    title: 'Sobre o app',
                    subtitle: 'Raio Fibra Telecom - versão inicial',
                  ),
                  const SizedBox(height: 22),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white, width: 1.4),
                        padding: const EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Função de sair será ligada no login real.',
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.logout),
                      label: const Text(
                        'Sair da conta',
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ConfigColors {
  static const orange = Color(0xFFFF6A00);
  static const blue = Color(0xFF083BBD);
  static const blueDark = Color(0xFF071B52);
  static const white = Color(0xFFFFFFFF);
}

class _TopBar extends StatelessWidget {
  final VoidCallback onBack;

  const _TopBar({required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          style: IconButton.styleFrom(
            backgroundColor: Colors.white.withOpacity(0.18),
          ),
          onPressed: onBack,
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        const SizedBox(width: 10),
        const Expanded(
          child: Text(
            'Configurações',
            style: TextStyle(
              color: Colors.white,
              fontSize: 27,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _ConfigColors.blueDark,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 22,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: const Row(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: _ConfigColors.orange,
            child: Icon(Icons.settings, color: Colors.white, size: 34),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Central do cliente',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Gerencie preferências, segurança e canais de atendimento.',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return _WhiteCard(
      child: Row(
        children: [
          CircleAvatar(
            radius: 27,
            backgroundColor: const Color(0xFFFFF2E8),
            child: Icon(icon, color: _ConfigColors.orange),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: _ConfigColors.blueDark,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(color: Colors.black54)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: _ConfigColors.blueDark),
        ],
      ),
    );
  }
}

class _WhiteCard extends StatelessWidget {
  final Widget child;

  const _WhiteCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _ConfigColors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: child,
    );
  }
}
