import 'package:flutter/material.dart';

import 'configuracoes_page.dart';
import 'faturas_page.dart';
import 'suporte_page.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  void _abrirConfiguracoes(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ConfiguracoesPage()),
    );
  }

  void _abrirFaturas(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const FaturasPage()),
    );
  }

  void _abrirSuporte(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SuportePage()),
    );
  }

  void _emBreve(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Funcionalidade preparada para integração.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final opcoes = [
      _ProfileOption(
        titulo: 'Alterar senha',
        subtitulo: 'Atualize sua senha de acesso',
        icon: Icons.lock,
        onTap: () => _emBreve(context),
      ),
      _ProfileOption(
        titulo: 'Atualizar telefone',
        subtitulo: '+55 81 98963-4191',
        icon: Icons.phone,
        onTap: () => _emBreve(context),
      ),
      _ProfileOption(
        titulo: 'Atualizar endereço',
        subtitulo: 'Alterar endereço de instalação',
        icon: Icons.location_on,
        onTap: () => _emBreve(context),
      ),
      _ProfileOption(
        titulo: 'Preferências',
        subtitulo: 'Notificações, segurança e atendimento',
        icon: Icons.settings,
        onTap: () => _abrirConfiguracoes(context),
      ),
      _ProfileOption(
        titulo: 'Sair da conta',
        subtitulo: 'Encerrar sessão neste aparelho',
        icon: Icons.logout,
        onTap: () => _emBreve(context),
      ),
    ];

    return Scaffold(
      backgroundColor: _ProfileColors.orange,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 28),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 860),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _TopTitle(),
                  const SizedBox(height: 16),
                  const _ProfileHero(),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                        child: _QuickButton(
                          icon: Icons.receipt_long,
                          label: 'Faturas',
                          onTap: () => _abrirFaturas(context),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _QuickButton(
                          icon: Icons.support_agent,
                          label: 'Suporte',
                          onTap: () => _abrirSuporte(context),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  const Text(
                    'Dados do cliente',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 14),
                  const _ClientInfoCard(),
                  const SizedBox(height: 22),
                  const Text(
                    'Minha conta',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 14),
                  ...opcoes.map(
                    (opcao) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _OptionTile(option: opcao),
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

class _ProfileColors {
  static const orange = Color(0xFFFF6A00);
  static const blue = Color(0xFF083BBD);
  static const blueDark = Color(0xFF071B52);
  static const white = Color(0xFFFFFFFF);
  static const green = Color(0xFF00A86B);
}

class _ProfileOption {
  final String titulo;
  final String subtitulo;
  final IconData icon;
  final VoidCallback onTap;

  const _ProfileOption({
    required this.titulo,
    required this.subtitulo,
    required this.icon,
    required this.onTap,
  });
}

class _TopTitle extends StatelessWidget {
  const _TopTitle();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Perfil',
      style: TextStyle(
        color: Colors.white,
        fontSize: 28,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}

class _ProfileHero extends StatelessWidget {
  const _ProfileHero();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _ProfileColors.blueDark,
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
            radius: 36,
            backgroundColor: _ProfileColors.orange,
            child: Icon(Icons.person, color: Colors.white, size: 38),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ricardo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Cliente Raio Fibra Telecom',
                  style: TextStyle(color: Colors.white70),
                ),
                SizedBox(height: 8),
                _StatusPill(label: 'Ativo', color: _ProfileColors.green),
              ],
            ),
          ),
          Icon(Icons.edit, color: Colors.white),
        ],
      ),
    );
  }
}

class _ClientInfoCard extends StatelessWidget {
  const _ClientInfoCard();

  @override
  Widget build(BuildContext context) {
    return _WhiteCard(
      child: Column(
        children: const [
          _InfoRow(
            icon: Icons.speed,
            title: 'Plano atual',
            value: '600 Mega Fibra',
          ),
          Divider(),
          _InfoRow(
            icon: Icons.wifi,
            title: 'Status da conexão',
            value: 'Online',
          ),
          Divider(),
          _InfoRow(
            icon: Icons.location_on,
            title: 'Endereço',
            value: 'Endereço de instalação cadastrado',
          ),
          Divider(),
          _InfoRow(
            icon: Icons.phone,
            title: 'Telefone',
            value: '+55 81 98963-4191',
          ),
          Divider(),
          _InfoRow(icon: Icons.badge, title: 'Cliente ID', value: 'CLI001'),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: const Color(0xFFFFF2E8),
            child: Icon(icon, color: _ProfileColors.orange, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    color: _ProfileColors.blueDark,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _ProfileColors.blue,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: _ProfileColors.blueDark.withOpacity(0.28),
              blurRadius: 18,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: 30),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  final _ProfileOption option;

  const _OptionTile({required this.option});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: option.onTap,
      child: Ink(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _ProfileColors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 22,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: const Color(0xFFFFF2E8),
              child: Icon(option.icon, color: _ProfileColors.orange),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    option.titulo,
                    style: const TextStyle(
                      color: _ProfileColors.blueDark,
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    option.subtitulo,
                    style: const TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: _ProfileColors.blueDark,
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  final String label;
  final Color color;

  const _StatusPill({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.18),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w900,
          fontSize: 12,
        ),
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
        color: _ProfileColors.white,
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
