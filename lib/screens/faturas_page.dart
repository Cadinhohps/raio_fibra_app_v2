import 'package:flutter/material.dart';

import '../services/mercado_pago_service.dart';
import 'pagamento_page.dart';

class FaturasPage extends StatefulWidget {
  const FaturasPage({super.key});

  @override
  State<FaturasPage> createState() => _FaturasPageState();
}

class _FaturasPageState extends State<FaturasPage> {
  final MercadoPagoService mercadoPagoService = MercadoPagoService();

  bool promessaAtiva = false;
  bool carregandoStatus = true;

  String statusPagamento = 'nao_encontrado';
  String statusDetalhe = '';
  String pagamentoId = '-';

  static const String faturaId = 'FAT-JUL-2026';

  bool get faturaPaga => statusPagamento == 'approved';

  @override
  void initState() {
    super.initState();
    consultarStatusFatura();
  }

  Future<void> consultarStatusFatura() async {
    setState(() {
      carregandoStatus = true;
    });

    try {
      final resultado = await mercadoPagoService.consultarStatusFatura(
        faturaId,
      );

      final pagamento = resultado['pagamento'];

      if (!mounted) return;

      setState(() {
        if (pagamento is Map<String, dynamic>) {
          statusPagamento = pagamento['status']?.toString() ?? 'pending';
          statusDetalhe = pagamento['status_detail']?.toString() ?? '';
          pagamentoId = pagamento['id']?.toString() ?? '-';
        } else {
          statusPagamento = resultado['status']?.toString() ?? 'nao_encontrado';
          statusDetalhe = resultado['mensagem']?.toString() ?? '';
          pagamentoId = '-';
        }

        carregandoStatus = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        statusPagamento = 'erro';
        statusDetalhe = 'Não foi possível consultar o status.';
        pagamentoId = '-';
        carregandoStatus = false;
      });
    }
  }

  Future<void> abrirPagamento() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => PagamentoPage()),
    );

    consultarStatusFatura();
  }

  void registrarPromessa() {
    setState(() {
      promessaAtiva = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Promessa registrada. Internet liberada por até 24 horas.',
        ),
        backgroundColor: Color(0xFF071B52),
      ),
    );
  }

  String get statusTexto {
    if (carregandoStatus) return 'Consultando...';

    switch (statusPagamento) {
      case 'approved':
        return 'Pago';
      case 'pending':
        return 'Pendente';
      case 'rejected':
        return 'Recusado';
      case 'cancelled':
        return 'Cancelado';
      case 'nao_encontrado':
        return 'Pendente';
      case 'erro':
        return 'Erro ao consultar';
      default:
        return statusPagamento;
    }
  }

  Color get statusCor {
    if (faturaPaga) return const Color(0xFF00A86B);
    if (statusPagamento == 'erro') return Colors.red;
    return const Color(0xFFFF6A00);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFF6A00),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.18),
                    ),
                    onPressed: () => Navigator.maybePop(context),
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      'Faturas',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 27,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  IconButton(
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.18),
                    ),
                    onPressed: consultarStatusFatura,
                    icon: const Icon(Icons.refresh, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 18),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF071B52),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 31,
                      backgroundColor: Color(0xFFFF6A00),
                      child: Icon(
                        Icons.receipt_long,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Central de faturas',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 23,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            faturaPaga
                                ? 'Sua fatura atual está paga.'
                                : 'Consulte e pague suas faturas.',
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF083BBD),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Fatura atual',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'R\$ 99,90',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 34,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.18),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            statusTexto,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Vencimento: 10/07/2026',
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'ID pagamento: $pagamentoId',
                      style: const TextStyle(color: Colors.white54),
                    ),
                    if (statusDetalhe.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        statusDetalhe,
                        style: const TextStyle(color: Colors.white54),
                      ),
                    ],
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: faturaPaga
                              ? const Color(0xFF00A86B)
                              : Colors.white,
                          foregroundColor: faturaPaga
                              ? Colors.white
                              : const Color(0xFF071B52),
                          padding: const EdgeInsets.all(15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        onPressed: faturaPaga ? null : abrirPagamento,
                        icon: Icon(faturaPaga ? Icons.check_circle : Icons.pix),
                        label: Text(
                          faturaPaga ? 'Fatura paga' : 'Pagar agora',
                          style: const TextStyle(fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: Colors.white),
                          padding: const EdgeInsets.all(14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        onPressed: consultarStatusFatura,
                        icon: const Icon(Icons.refresh),
                        label: const Text(
                          'Atualizar status',
                          style: TextStyle(fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 27,
                          backgroundColor: promessaAtiva
                              ? const Color(0xFFE8FFF5)
                              : const Color(0xFFFFF2E8),
                          child: Icon(
                            promessaAtiva
                                ? Icons.check_circle
                                : Icons.lock_open,
                            color: promessaAtiva
                                ? const Color(0xFF00A86B)
                                : const Color(0xFFFF6A00),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Text(
                            promessaAtiva
                                ? 'Internet liberada por até 24 horas.'
                                : 'Promessa de pagamento: libere sua internet por 24h.',
                            style: const TextStyle(
                              color: Color(0xFF071B52),
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: promessaAtiva
                              ? const Color(0xFF00A86B)
                              : const Color(0xFFFF6A00),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.all(14),
                        ),
                        onPressed: promessaAtiva || faturaPaga
                            ? null
                            : registrarPromessa,
                        icon: Icon(
                          promessaAtiva ? Icons.check : Icons.schedule,
                        ),
                        label: Text(
                          promessaAtiva
                              ? 'Promessa ativa'
                              : faturaPaga
                              ? 'Fatura já paga'
                              : 'Liberar internet por 24 horas',
                          style: const TextStyle(fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              const Text(
                'Histórico de faturas',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 12),

              _FaturaItem(
                mes: 'Julho/2026',
                valor: 'R\$ 99,90',
                status: statusTexto,
                statusColor: statusCor,
                onPay: abrirPagamento,
              ),
              _FaturaItem(
                mes: 'Junho/2026',
                valor: 'R\$ 99,90',
                status: 'Pago',
                statusColor: const Color(0xFF00A86B),
                onPay: abrirPagamento,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FaturaItem extends StatelessWidget {
  final String mes;
  final String valor;
  final String status;
  final Color statusColor;
  final VoidCallback onPay;

  const _FaturaItem({
    required this.mes,
    required this.valor,
    required this.status,
    required this.statusColor,
    required this.onPay,
  });

  @override
  Widget build(BuildContext context) {
    final pago = status == 'Pago';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: pago
                ? const Color(0xFFE8FFF5)
                : const Color(0xFFFFF2E8),
            child: Icon(
              pago ? Icons.check : Icons.warning_amber,
              color: statusColor,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mes,
                  style: const TextStyle(
                    color: Color(0xFF071B52),
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(status, style: TextStyle(color: statusColor)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                valor,
                style: const TextStyle(
                  color: Color(0xFF071B52),
                  fontWeight: FontWeight.w900,
                ),
              ),
              if (!pago)
                TextButton(onPressed: onPay, child: const Text('Pagar')),
            ],
          ),
        ],
      ),
    );
  }
}
