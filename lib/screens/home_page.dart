import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services/sgp_service.dart';
import 'faturas_page.dart';
import 'pagamento_page.dart';
import 'perfil_page.dart';
import 'suporte_page.dart';

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
    try {
      final resultado = await sgpService
          .buscarClientePorCpf('00000000000')
          .timeout(const Duration(seconds: 5));

      if (!mounted) return;

      setState(() {
        cliente = resultado;
        carregando = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        cliente = {
          'nome': 'Ricardo',
          'plano': 'Plano 600 Mega',
          'statusConexao': 'Online',
        };
        carregando = false;
      });
    }
  }

  void abrirTela(Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  Future<void> abrirWhatsApp() async {
    const numeroWhatsapp = '5581989634191';

    const mensagem = '''
Olá, Raio Fibra Telecom!

Preciso de atendimento pelo app.
Cliente: Ricardo
Cliente ID: CLI001
''';

    final uri = Uri.parse(
      'https://wa.me/$numeroWhatsapp?text=${Uri.encodeComponent(mensagem)}',
    );

    final abriu = await launchUrl(uri, mode: LaunchMode.externalApplication);

    if (!abriu && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Não foi possível abrir o WhatsApp.')),
      );
    }
  }

  void promessaPagamento() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Promessa registrada. Internet liberada por até 24 horas.',
        ),
        backgroundColor: _HomeColors.blueDark,
      ),
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
    final plano = cliente?['plano'] ?? 'Plano 600 Mega';
    final statusConexao = cliente?['statusConexao'] ?? 'Online';

    if (carregando) {
      return const Scaffold(
        backgroundColor: _HomeColors.orange,
        body: SafeArea(
          child: Center(child: CircularProgressIndicator(color: Colors.white)),
        ),
      );
    }

    return Scaffold(
      backgroundColor: _HomeColors.orange,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 28),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 980),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _TopBrandHeader(nomeCliente: nomeCliente, saudacao: saudacao),
                  const SizedBox(height: 18),

                  _RaioIaMainCard(onOpenRaioIa: widget.onOpenRaioIa),

                  const SizedBox(height: 18),

                  Row(
                    children: [
                      Expanded(
                        child: _MiniStatusCard(
                          icon: Icons.speed,
                          title: 'Plano atual',
                          value: plano,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _MiniStatusCard(
                          icon: statusConexao == 'Online'
                              ? Icons.check_circle
                              : Icons.warning_amber,
                          title: 'Status',
                          value: statusConexao,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 22),

                  const Text(
                    'Acesso rápido',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 12),

                  LayoutBuilder(
                    builder: (context, constraints) {
                      final width = constraints.maxWidth;
                      final crossAxisCount = width >= 760 ? 4 : 2;

                      return GridView.count(
                        crossAxisCount: crossAxisCount,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: width >= 760 ? 1.2 : 1.25,
                        children: [
                          BlueQuickAction(
                            icon: Icons.home,
                            label: 'Home',
                            subtitle: 'Tela inicial',
                            onTap: () {},
                          ),
                          BlueQuickAction(
                            icon: Icons.support_agent,
                            label: 'Suporte',
                            subtitle: 'Atendimento',
                            onTap: () => abrirTela(const SuportePage()),
                          ),
                          BlueQuickAction(
                            icon: Icons.receipt_long,
                            label: 'Faturas',
                            subtitle: '2ª via e Pix',
                            onTap: () => abrirTela(const FaturasPage()),
                          ),
                          BlueQuickAction(
                            icon: Icons.person,
                            label: 'Perfil',
                            subtitle: 'Minha conta',
                            onTap: () => abrirTela(const PerfilPage()),
                          ),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 22),

                  _FeaturedInvoice(onPay: () => abrirTela(PagamentoPage())),

                  const SizedBox(height: 18),

                  _PromisePaymentCard(onPromise: promessaPagamento),

                  const SizedBox(height: 18),

                  _HelpCard(
                    onOpenSupport: () => abrirTela(const SuportePage()),
                    onWhatsapp: abrirWhatsApp,
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

class _HomeColors {
  static const orange = Color(0xFFFF6A00);
  static const blue = Color(0xFF083BBD);
  static const blueDark = Color(0xFF071B52);
  static const white = Color(0xFFFFFFFF);
  static const softWhite = Color(0xFFFFF7F0);
  static const green = Color(0xFF00A86B);
}

class _TopBrandHeader extends StatelessWidget {
  final String nomeCliente;
  final String saudacao;

  const _TopBrandHeader({required this.nomeCliente, required this.saudacao});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Container(
                    width: 84,
                    height: 84,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.flash_on,
                          color: _HomeColors.orange,
                          size: 44,
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Raio Fibra',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            height: 1,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          'Telecom',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            letterSpacing: 5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              style: IconButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.16),
              ),
              onPressed: () {},
              icon: const Icon(Icons.notifications, color: Colors.white),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '$saudacao, $nomeCliente!',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 29,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        const SizedBox(height: 6),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Como podemos ajudar hoje?',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ],
    );
  }
}

class _RaioIaMainCard extends StatelessWidget {
  final VoidCallback onOpenRaioIa;

  const _RaioIaMainCard({required this.onOpenRaioIa});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _HomeColors.blueDark,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 22,
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
                radius: 32,
                backgroundColor: _HomeColors.orange,
                child: Icon(
                  Icons.psychology_alt,
                  color: Colors.white,
                  size: 36,
                ),
              ),
              SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Raio IA',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      'Atendimento inteligente da Raio Fibra',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Tire duqvidas, consulte faturas, receba orientação de suporte e resolva problemas com ajuda da nossa inteligência artificial.',
            style: TextStyle(color: Colors.white, height: 1.35),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: _HomeColors.blueDark,
                padding: const EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              onPressed: onOpenRaioIa,
              icon: const Icon(Icons.chat_bubble),
              label: const Text(
                'Falar com a Raio IA',
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniStatusCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _MiniStatusCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 112),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _HomeColors.blue,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: _HomeColors.blueDark.withOpacity(0.28),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white, size: 30),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class BlueQuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final VoidCallback onTap;

  const BlueQuickAction({
    super.key,
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _HomeColors.blue,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: _HomeColors.blueDark.withOpacity(0.28),
              blurRadius: 18,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 34),
            const SizedBox(height: 10),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white70, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeaturedInvoice extends StatelessWidget {
  final VoidCallback onPay;

  const _FeaturedInvoice({required this.onPay});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Fatura atual',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: _HomeColors.blueDark,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Expanded(
                child: Text(
                  'R\$ 99,90',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: _HomeColors.blueDark,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE4D0),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text(
                  'Pendente',
                  style: TextStyle(
                    color: _HomeColors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Text('Vencimento: 10/07/2026'),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: _HomeColors.orange,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: onPay,
              icon: const Icon(Icons.pix),
              label: const Text(
                'Pagar agora',
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PromisePaymentCard extends StatelessWidget {
  final VoidCallback onPromise;

  const _PromisePaymentCard({required this.onPromise});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _HomeColors.blueDark,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: _HomeColors.blueDark.withOpacity(0.3),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: _HomeColors.orange,
                child: Icon(Icons.lock_open, color: Colors.white, size: 30),
              ),
              SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Promessa de pagamento',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      'Libere sua internet por até 24 horas.',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Text(
            'Se sua fatura venceu e a conexão foi bloqueada, registre uma promessa de pagamento para desbloqueio temporário.',
            style: TextStyle(color: Colors.white, height: 1.35),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: _HomeColors.blueDark,
                padding: const EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              onPressed: onPromise,
              icon: const Icon(Icons.schedule),
              label: const Text(
                'Liberar por 24 horas',
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HelpCard extends StatelessWidget {
  final VoidCallback onOpenSupport;
  final VoidCallback onWhatsapp;

  const _HelpCard({required this.onOpenSupport, required this.onWhatsapp});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _HomeColors.softWhite,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              CircleAvatar(
                radius: 27,
                backgroundColor: _HomeColors.blueDark,
                child: Icon(Icons.help, color: Colors.white),
              ),
              SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Precisa de ajuda?',
                      style: TextStyle(
                        color: _HomeColors.blueDark,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      'Fale com o suporte ou chame no WhatsApp.',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _HomeColors.blueDark,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: onOpenSupport,
                  icon: const Icon(Icons.support_agent),
                  label: const Text(
                    'Suporte',
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: _HomeColors.blueDark,
                    side: const BorderSide(color: _HomeColors.blueDark),
                    padding: const EdgeInsets.all(14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: onWhatsapp,
                  icon: const Icon(Icons.chat),
                  label: const Text(
                    'WhatsApp',
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
