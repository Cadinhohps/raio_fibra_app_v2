import 'package:flutter/material.dart';

import '../services/sgp_service.dart';
import 'pagamento_page.dart';

class FaturasPage extends StatefulWidget {
  const FaturasPage({super.key});

  @override
  State<FaturasPage> createState() => _FaturasPageState();
}

class _FaturasPageState extends State<FaturasPage> {
  final SgpService sgpService = SgpService();

  bool carregando = true;
  List<Map<String, dynamic>> faturas = [];

  @override
  void initState() {
    super.initState();
    carregarFaturas();
  }

  Future<void> carregarFaturas() async {
    setState(() {
      carregando = true;
    });

    try {
      final resultado = await sgpService.buscarFaturas('CLI-308');

      if (!mounted) return;

      setState(() {
        faturas = resultado;
        carregando = false;
      });
    } catch (_) {
      if (!mounted) return;

      setState(() {
        carregando = false;
      });
    }
  }

  bool estaPago(Map<String, dynamic> fatura) {
    final status = (fatura['status'] ?? '').toString().toLowerCase();
    return fatura['estaPago'] == true || status.contains('pago');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFF7A00),
      appBar: AppBar(
        title: const Text('Faturas'),
        backgroundColor: const Color(0xFFFF7A00),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: carregando
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : RefreshIndicator(
              onRefresh: carregarFaturas,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  const Text(
                    'Minhas faturas',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Dados consultados no SGP Demo',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  const SizedBox(height: 20),
                  if (faturas.isEmpty)
                    const _InfoCard(
                      titulo: 'Nenhuma fatura encontrada',
                      subtitulo:
                          'O SGP Demo não retornou faturas para este contrato.',
                    ),
                  ...faturas.map((fatura) {
                    final pago = estaPago(fatura);

                    return Container(
                      margin: const EdgeInsets.only(bottom: 14),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF004AAD),
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            (fatura['competencia'] ?? 'Fatura SGP').toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          _LinhaFatura(
                            titulo: 'Valor',
                            valor: (fatura['valor'] ?? '-').toString(),
                          ),
                          _LinhaFatura(
                            titulo: 'Vencimento',
                            valor: (fatura['vencimento'] ?? '-').toString(),
                          ),
                          _LinhaFatura(
                            titulo: 'Contrato',
                            valor: (fatura['contrato'] ?? '308').toString(),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 7,
                            ),
                            decoration: BoxDecoration(
                              color: pago ? Colors.green : Colors.orange,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                              pago
                                  ? 'Pago'
                                  : (fatura['status'] ?? 'Em aberto')
                                        .toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
                          if (!pago)
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => PagamentoPage(
                                        clienteId:
                                            (fatura['clienteId'] ?? 'CLI-308')
                                                .toString(),
                                        faturaId:
                                            (fatura['id'] ?? 'FAT-SGP-DEMO')
                                                .toString(),
                                        valor:
                                            double.tryParse(
                                              (fatura['valor'] ?? '99.90')
                                                  .toString()
                                                  .replaceAll('R\$', '')
                                                  .replaceAll('.', '')
                                                  .replaceAll(',', '.')
                                                  .trim(),
                                            ) ??
                                            99.90,
                                        vencimento:
                                            (fatura['vencimento'] ?? 'Dia 20')
                                                .toString(),
                                      ),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.pix),
                                label: const Text('Pagar agora'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: const Color(0xFF004AAD),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 13,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
    );
  }
}

class _LinhaFatura extends StatelessWidget {
  final String titulo;
  final String valor;

  const _LinhaFatura({required this.titulo, required this.valor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            titulo,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
          Flexible(
            child: Text(
              valor,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String titulo;
  final String subtitulo;

  const _InfoCard({required this.titulo, required this.subtitulo});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF004AAD),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(subtitulo, style: const TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }
}
