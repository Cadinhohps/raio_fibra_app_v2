import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../services/mercado_pago_service.dart';
import '../theme/app_theme.dart';
import '../widgets/premium_card.dart';

class PagamentoPage extends StatefulWidget {
  final String clienteId;
  final String faturaId;
  final double valor;
  final String vencimento;

  const PagamentoPage({
    super.key,
    this.clienteId = 'CLI-308',
    this.faturaId = 'FAT-SGP-DEMO',
    this.valor = 99.90,
    this.vencimento = 'Dia 20',
  });

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

  String valorFormatado() {
    return 'R\$ ${widget.valor.toStringAsFixed(2).replaceAll('.', ',')}';
  }

  Future<void> carregarPagamento() async {
    final resultado = await mercadoPagoService.criarPagamento(
      clienteId: widget.clienteId,
      faturaId: widget.faturaId,
      valor: widget.valor,
    );

    if (!mounted) return;

    setState(() {
      pagamento = resultado;
      carregando = false;
    });
  }

  Future<void> copiarPix(String pixCode) async {
    await Clipboard.setData(ClipboardData(text: pixCode));

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Código PIX copiado com sucesso!'),
        backgroundColor: AppColors.secondaryBlue,
      ),
    );
  }

  Future<void> consultarPagamento() async {
    final paymentId = pagamento?['paymentId'] ?? pagamento?['id'] ?? '';

    if (paymentId.toString().isEmpty) return;

    final resultado = await mercadoPagoService.consultarPagamento(
      paymentId.toString(),
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          resultado['mensagem'] ?? resultado['status'] ?? 'Status consultado.',
        ),
        backgroundColor: AppColors.secondaryBlue,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pixCode =
        pagamento?['pixCopiaCola'] ??
        pagamento?['qr_code'] ??
        pagamento?['pix'] ??
        '';

    final checkoutUrl =
        pagamento?['checkoutUrl'] ?? pagamento?['ticket_url'] ?? '';

    final status = pagamento?['status'] ?? 'pending';

    final paymentId = pagamento?['paymentId'] ?? pagamento?['id'] ?? '-';

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
                    constraints: const BoxConstraints(maxWidth: 820),
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
                                'Fatura selecionada',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 14),
                              Text(
                                valorFormatado(),
                                style: const TextStyle(
                                  fontSize: 34,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryBlue,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text('Vencimento: ${widget.vencimento}'),
                              Text('Fatura: ${widget.faturaId}'),
                              Text('Status Mercado Pago: $status'),
                              const SizedBox(height: 8),
                              Text(
                                'ID do pagamento: $paymentId',
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
                                  pixCode.toString(),
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
                                  onPressed: () =>
                                      copiarPix(pixCode.toString()),
                                  icon: const Icon(Icons.copy),
                                  label: const Text(
                                    'Copiar PIX',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
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
                                'Pagamento gerado com base na fatura selecionada.',
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
                                  checkoutUrl.toString(),
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                              const SizedBox(height: 14),
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
              ),
      ),
    );
  }
}
