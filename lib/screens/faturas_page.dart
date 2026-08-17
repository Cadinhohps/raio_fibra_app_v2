import 'package:flutter/material.dart';

import 'pagamento_page.dart';

class FaturasPage extends StatefulWidget {
  const FaturasPage({super.key});

  @override
  State<FaturasPage> createState() => _FaturasPageState();
}

class _FaturasPageState extends State<FaturasPage> {
  bool promessaAtiva = false;

  void abrirPagamento() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => PagamentoPage()));
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
                child: const Row(
                  children: [
                    CircleAvatar(
                      radius: 31,
                      backgroundColor: Color(0xFFFF6A00),
                      child: Icon(
                        Icons.receipt_long,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Central de faturas',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 23,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Consulte e pague suas faturas.',
                            style: TextStyle(color: Colors.white70),
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
                    const Text(
                      'R\$ 99,90',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 34,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Vencimento: 10/07/2026',
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Color(0xFF071B52),
                          padding: const EdgeInsets.all(15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        onPressed: abrirPagamento,
                        icon: const Icon(Icons.pix),
                        label: const Text(
                          'Pagar agora',
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
                        onPressed: promessaAtiva ? null : registrarPromessa,
                        icon: Icon(
                          promessaAtiva ? Icons.check : Icons.schedule,
                        ),
                        label: Text(
                          promessaAtiva
                              ? 'Promessa ativa'
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
                status: 'Pendente',
                onPay: abrirPagamento,
              ),
              _FaturaItem(
                mes: 'Junho/2026',
                valor: 'R\$ 99,90',
                status: 'Pago',
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
  final VoidCallback onPay;

  const _FaturaItem({
    required this.mes,
    required this.valor,
    required this.status,
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
              color: pago ? const Color(0xFF00A86B) : const Color(0xFFFF6A00),
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
                Text(
                  status,
                  style: TextStyle(
                    color: pago
                        ? const Color(0xFF00A86B)
                        : const Color(0xFFFF6A00),
                  ),
                ),
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
