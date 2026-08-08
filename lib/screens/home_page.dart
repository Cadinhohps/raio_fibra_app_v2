import 'package:flutter/material.dart';

import '../services/sgp_service.dart';
import '../theme/app_theme.dart';
import '../widgets/premium_card.dart';
import 'beneficios_page.dart';
import 'consumo_page.dart';
import 'faturas_page.dart';
import 'meu_wifi_page.dart';
import 'pagamento_page.dart';
import 'suporte_page.dart';
import 'teste_velocidade_page.dart';
import 'vantagens_page.dart';

class HomePage extends StatefulWidget {
  final VoidCallback onOpenRaioIa;

  const HomePage({super.key, required this.onOpenRaioIa});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final SgpService sgpService = SgpService();

  bool carregando = true;
  Map<String, dynamic>? cliente;

  @override
  void initState() {
    super.initState();
    carregarCliente();
  }

  Future<void> carregarCliente() async {
    final resultado = await sgpService.buscarClientePorCpf('00000000000');

    if (!mounted) return;

    setState(() {
      cliente = resultado;
      carregando = false;
    });
  }

  void abrirTela(Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  void reiniciarInternet() {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Reiniciar internet'),
          content: const Text(
            'Esta acao simula o reinicio remoto do equipamento do cliente.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.orange,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Reinicio simulado enviado com sucesso.'),
                    backgroundColor: AppColors.secondaryBlue,
                  ),
                );
              },
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  String get saudacao {
    final hora = DateTime.now().hour;

    if (hora < 12) return 'Bom dia';
    if (hora < 18) return 'Boa tarde';

    return 'Boa noite';
  }

  @override
  Widget build(BuildContext context) {
    final nomeCliente = cliente?['nome'] ?? 'Cliente';
    final plano = cliente?['plano'] ?? 'Plano nao encontrado';
    final statusConexao = cliente?['statusConexao'] ?? 'Indisponivel';

    if (carregando) {
      return const Scaffold(
        backgroundColor: AppColors.lightGray,
        body: SafeArea(
          child: Center(
            child: CircularProgressIndicator(color: AppColors.secondaryBlue),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.lightGray,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 980),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _HeroHeader(
                    saudacao: saudacao,
                    nomeCliente: nomeCliente,
                    statusConexao: statusConexao,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: InfoCard(
                          title: 'Plano Atual',
                          value: plano,
                          icon: Icons.wifi,
                          color: AppColors.secondaryBlue,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: InfoCard(
                          title: 'Status',
                          value: statusConexao,
                          icon: statusConexao == 'Online'
                              ? Icons.check_circle
                              : Icons.warning_amber,
                          color: statusConexao == 'Online'
                              ? AppColors.success
                              : AppColors.orange,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  const PremiumCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Indicadores da conexao',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 14),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MetricItem(label: 'Download', value: '589 Mbps'),
                            MetricItem(label: 'Upload', value: '295 Mbps'),
                            MetricItem(label: 'Ping', value: '8 ms'),
                            MetricItem(label: 'Devices', value: '7'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  const Text(
                    'Atalhos rapidos',
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final width = constraints.maxWidth;
                      final crossAxisCount = width >= 760
                          ? 4
                          : width >= 520
                          ? 3
                          : 2;

                      return GridView.count(
                        crossAxisCount: crossAxisCount,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        children: [
                          QuickAction(
                            icon: Icons.router,
                            label: 'Meu Wi-Fi',
                            onTap: () => abrirTela(const MeuWifiPage()),
                          ),
                          QuickAction(
                            icon: Icons.speed,
                            label: 'Teste',
                            onTap: () => abrirTela(const TesteVelocidadePage()),
                          ),
                          QuickAction(
                            icon: Icons.restart_alt,
                            label: 'Reiniciar',
                            onTap: reiniciarInternet,
                          ),
                          QuickAction(
                            icon: Icons.receipt,
                            label: '2a Via',
                            onTap: () => abrirTela(const FaturasPage()),
                          ),
                          QuickAction(
                            icon: Icons.support_agent,
                            label: 'Suporte',
                            onTap: () => abrirTela(const SuportePage()),
                          ),
                          QuickAction(
                            icon: Icons.bar_chart,
                            label: 'Consumo',
                            onTap: () => abrirTela(const ConsumoPage()),
                          ),
                          QuickAction(
                            icon: Icons.star,
                            label: 'Beneficios',
                            onTap: () => abrirTela(const BeneficiosPage()),
                          ),
                          QuickAction(
                            icon: Icons.apps,
                            label: 'Servicos',
                            onTap: () => abrirTela(const VantagensPage()),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 22),
                  _FeaturedInvoice(
                    onPay: () => abrirTela(const PagamentoPage()),
                  ),
                  const SizedBox(height: 22),
                  _RaioIaBanner(onOpenRaioIa: widget.onOpenRaioIa),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _HeroHeader extends StatelessWidget {
  final String saudacao;
  final String nomeCliente;
  final String statusConexao;

  const _HeroHeader({
    required this.saudacao,
    required this.nomeCliente,
    required this.statusConexao,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primaryBlue, AppColors.secondaryBlue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondaryBlue.withOpacity(0.35),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: Colors.white,
                child: Icon(Icons.flash_on, color: AppColors.orange, size: 32),
              ),
              SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Raio Fibra IA',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Internet rapida no seu bairro',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 26),
          Text(
            '$saudacao, $nomeCliente',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            statusConexao == 'Online'
                ? 'Sua conexao esta online e funcionando normalmente.'
                : 'Sua conexao precisa de atencao.',
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class _FeaturedInvoice extends StatelessWidget {
  final VoidCallback onPay;

  const _FeaturedInvoice({required this.onPay});

  @override
  Widget build(BuildContext context) {
    return PremiumCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Fatura em destaque',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'R\$ 99,90',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryBlue,
                ),
              ),
              Chip(
                label: Text('Em aberto'),
                backgroundColor: Color(0xFFFFE8D6),
              ),
            ],
          ),
          const Text('Vencimento: 10/07/2026'),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.orange,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: onPay,
              child: const Text('Pagar Agora'),
            ),
          ),
        ],
      ),
    );
  }
}

class _RaioIaBanner extends StatelessWidget {
  final VoidCallback onOpenRaioIa;

  const _RaioIaBanner({required this.onOpenRaioIa});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.primaryBlue,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryBlue.withOpacity(0.25),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.orange,
            child: Icon(Icons.smart_toy, color: Colors.white, size: 30),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Raio IA',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Online agora para resolver seu atendimento',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.primaryBlue,
            ),
            onPressed: onOpenRaioIa,
            child: const Text('Conversar'),
          ),
        ],
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const InfoCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return PremiumCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(height: 14),
          Text(title, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class MetricItem extends StatelessWidget {
  final String label;
  final String value;

  const MetricItem({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.secondaryBlue,
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),
      ],
    );
  }
}

class QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const QuickAction({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: onTap,
      child: PremiumCard(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.secondaryBlue, size: 26),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
