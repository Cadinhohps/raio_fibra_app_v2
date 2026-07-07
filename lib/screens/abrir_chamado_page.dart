import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/premium_card.dart';

class AbrirChamadoPage extends StatefulWidget {
  const AbrirChamadoPage({super.key});

  @override
  State<AbrirChamadoPage> createState() => _AbrirChamadoPageState();
}

class _AbrirChamadoPageState extends State<AbrirChamadoPage> {
  final TextEditingController descricaoController = TextEditingController();

  String categoriaSelecionada = 'Sem internet';
  String prioridadeSelecionada = 'Normal';
  bool chamadoAberto = false;

  final List<String> categorias = [
    'Sem internet',
    'Internet lenta',
    'Oscilação',
    'Financeiro',
    'Mudança de endereço',
    'Outros',
  ];

  final List<String> prioridades = ['Baixa', 'Normal', 'Alta'];

  void abrirChamado() {
    setState(() {
      chamadoAberto = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Chamado aberto com sucesso! Protocolo #RF1029'),
        backgroundColor: AppColors.secondaryBlue,
      ),
    );
  }

  String getSlaText() {
    if (prioridadeSelecionada == 'Alta') {
      return 'SLA estimado: até 2h úteis';
    }

    if (prioridadeSelecionada == 'Normal') {
      return 'SLA estimado: até 4h úteis';
    }

    return 'SLA estimado: até 8h úteis';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Abrir Chamado',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Descreva o problema para encaminharmos ao suporte.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),

            PremiumCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Categoria',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: categorias.map((categoria) {
                      final selected = categoria == categoriaSelecionada;

                      return ChoiceChip(
                        label: Text(categoria),
                        selected: selected,
                        selectedColor: AppColors.secondaryBlue,
                        labelStyle: TextStyle(
                          color: selected ? Colors.white : Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                        onSelected: (_) {
                          setState(() {
                            categoriaSelecionada = categoria;
                          });
                        },
                      );
                    }).toList(),
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
                    'Prioridade',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: prioridades.map((prioridade) {
                      final selected = prioridade == prioridadeSelecionada;

                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            label: Text(prioridade),
                            selected: selected,
                            selectedColor: AppColors.orange,
                            labelStyle: TextStyle(
                              color: selected ? Colors.white : Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                            onSelected: (_) {
                              setState(() {
                                prioridadeSelecionada = prioridade;
                              });
                            },
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    getSlaText(),
                    style: const TextStyle(
                      color: AppColors.secondaryBlue,
                      fontWeight: FontWeight.bold,
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
                    'Descrição do problema',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: descricaoController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText:
                          'Exemplo: estou sem internet desde ontem à noite. O roteador está com luz vermelha...',
                      filled: true,
                      fillColor: AppColors.lightGray,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            if (chamadoAberto)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Colors.green.shade200),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Chamado #RF1029 aberto com sucesso. Nossa equipe acompanhará pelo SLA informado.',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 18),

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
                onPressed: abrirChamado,
                icon: const Icon(Icons.send),
                label: const Text(
                  'Enviar chamado',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
