import 'package:flutter/material.dart';

import '../models/fatura_model.dart';
import '../services/sgp_service.dart';
import '../theme/app_theme.dart';
import '../widgets/premium_card.dart';
import 'pagamento_page.dart';

class FaturasPage extends StatefulWidget {
  const FaturasPage({super.key});

  @override
  State<FaturasPage> createState() => _FaturasPageState();
}

class _FaturasPageState extends State<FaturasPage> {
  final SgpService sgpService = SgpService();

  bool carregando = true;
  List<FaturaModel> faturas = const [];

  @override
  void initState() {
    super.initState();
    carregarFaturas();
  }

  Future<void> carregarFaturas() async {
    final resultado = await sgpService.buscarFaturas('CLI001');

    if (!mounted) return;

    setState(() {
      faturas = resultado.map(FaturaModel.fromJson).toList();
      carregando = false;
    });
  }

  void abrirPagamento() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const PagamentoPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final faturaAtual = faturas.isNotEmpty ? faturas.first : null;

    return Scaffold(
      backgroundColor: AppColors.lightGray,
      body: SafeArea(
        child: carregando
            ? const Center(
                child: CircularProgressIndicator(
                  color: AppColors.secondaryBlue,
                ),
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.all(18),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 980),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Faturas',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryBlue,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Consulte, pague e baixe suas faturas.',
                          style: TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 20),
                        if (faturaAtual != null)
                          _FaturaAtualCard(
                            fatura: faturaAtual,
                            onPay: abrirPagamento,
                          ),
                        const SizedBox(height: 22),
                        _PromessaPagamentoCard(),
                        const SizedBox(height: 22),
                        const Text(
                          'Historico',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ...faturas.map(
                          (fatura) => _FaturaListItem(
                            fatura: fatura,
                            onPay: abrirPagamento,
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

class _FaturaAtualCard extends StatelessWidget {
  final FaturaModel fatura;
  final VoidCallback onPay;

  const _FaturaAtualCard({required this.fatura, required this.onPay});

  @override
  Widget build(BuildContext context) {
    return PremiumCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Fatura atual',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 16,
            runSpacing: 8,
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                fatura.valor,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryBlue,
                ),
              ),
              Chip(
                label: Text(fatura.status),
                backgroundColor: fatura.estaPago
                    ? Colors.green.shade50
                    : const Color(0xFFFFE8D6),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text('Competencia: ${fatura.competencia}'),
          Text('Vencimento: ${fatura.vencimento}'),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.orange,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: onPay,
              icon: const Icon(Icons.payment),
              label: const Text(
                'Pagar agora',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'PIX copia e cola sera exibido na tela de pagamento.',
                      ),
                      backgroundColor: AppColors.secondaryBlue,
                    ),
                  ),
                  icon: const Icon(Icons.pix),
                  label: const Text('PIX'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'PDF da fatura sera integrado futuramente.',
                      ),
                    ),
                  ),
                  icon: const Icon(Icons.picture_as_pdf),
                  label: const Text('PDF'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PromessaPagamentoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PremiumCard(
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Color(0xFFFFE8D6),
            child: Icon(Icons.schedule, color: AppColors.orange),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Promessa de pagamento',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Registro simulado por ate 24h.',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Promessa de pagamento registrada por 24h.'),
                backgroundColor: AppColors.secondaryBlue,
              ),
            ),
            child: const Text('Prometer'),
          ),
        ],
      ),
    );
  }
}

class _FaturaListItem extends StatelessWidget {
  final FaturaModel fatura;
  final VoidCallback onPay;

  const _FaturaListItem({required this.fatura, required this.onPay});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: PremiumCard(
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: fatura.estaPago
                  ? Colors.green.shade50
                  : Colors.orange.shade50,
              child: Icon(
                fatura.estaPago ? Icons.check : Icons.warning_amber,
                color: fatura.estaPago ? Colors.green : AppColors.orange,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fatura.competencia,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Vencimento: ${fatura.vencimento}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  fatura.valor,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  fatura.status,
                  style: TextStyle(
                    color: fatura.estaPago ? Colors.green : AppColors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (!fatura.estaPago)
                  TextButton(onPressed: onPay, child: const Text('Pagar')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
