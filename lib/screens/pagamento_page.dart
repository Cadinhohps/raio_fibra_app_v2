import 'package:flutter/material.dart';

import '../services/mercado_pago_service.dart';
import '../theme/app_theme.dart';
import '../widgets/premium_card.dart';

class PagamentoPage extends StatefulWidget {
  const PagamentoPage({super.key});

  @override
  State<PagamentoPage> createState() => _PagamentoPageState();
}

class _PagamentoPageState extends State<PagamentoPage> {
  final MercadoPagoService mercadoPagoService = MercadoPagoService();

  bool carregando = true;
  Map<String, dynamic>? pagamento;

  @override
  void initState() {
    super.initState();
    carregarPagamento();
  }

  Future<void> carregarPagamento() async {
    final resultado = await mercadoPagoService.criarPagamento(
      clienteId: 'CLI001',
      faturaId: 'FAT-JUL-2026',
      valor: 99.90,
    );

    setState(() {
      pagamento = resultado;
      carregando = false;
    });
  }

  Future<void> consultarPagamento() async {
    final paymentId = pagamento?['paymentId'] ?? '';

    if (paymentId.isEmpty) return;

    final resultado = await mercadoPagoService.consultarPagamento(paymentId);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(resultado['mensagem'] ?? 'Status consultado.'),
        backgroundColor: AppColors.secondaryBlue,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pixCode = pagamento?['pixCopiaCola'] ?? '';
    final checkoutUrl = pagamento?['checkoutUrl'] ?? '';
    final status = pagamento?['status'] ?? 'pending';

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
                            'Pagamento',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryBlue,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    PremiumCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Fatura atual',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 14),
                          const Text(
                            'R\$ 99,90',
                            style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryBlue,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text('Vencimento: 10/07/2026'),
                          Text('Status Mercado Pago: $status'),
                          const SizedBox(height: 8),
                          Text(
                            'ID do pagamento: ${pagamento?['paymentId'] ?? '-'}',
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 18),

                    PremiumCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Pagar com PIX',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 14),

                          Center(
                            child: Container(
                              width: 190,
                              height: 190,
                              decoration: BoxDecoration(
                                color: AppColors.lightGray,
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(
                                  color: const Color(0xFFE0E7F3),
                                ),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.qr_code_2,
                                  size: 130,
                                  color: AppColors.primaryBlue,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: AppColors.lightGray,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Text(
                              pixCode,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),

                          const SizedBox(height: 14),

                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.orange,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.all(16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Código PIX copiado com sucesso!',
                                    ),
                                    backgroundColor: AppColors.secondaryBlue,
                                  ),
                                );
                              },
                              icon: const Icon(Icons.copy),
                              label: const Text(
                                'Copiar PIX',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 18),

                    PremiumCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Mercado Pago',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Este botão está usando um service simulado. Na versão final, ele abrirá o checkout real do Mercado Pago.',
                            style: TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 14),

                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: AppColors.lightGray,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Text(
                              checkoutUrl,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),

                          const SizedBox(height: 14),

                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton.icon(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Checkout Mercado Pago simulado. Integração real será feita com API.',
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.payment),
                              label: const Text('Abrir checkout Mercado Pago'),
                            ),
                          ),

                          const SizedBox(height: 10),

                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton.icon(
                              onPressed: consultarPagamento,
                              icon: const Icon(Icons.refresh),
                              label: const Text('Consultar status'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
