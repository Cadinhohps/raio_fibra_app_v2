import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/premium_card.dart';
import '../models/chamado_model.dart';

class AbrirChamadoPage extends StatefulWidget {
  const AbrirChamadoPage({super.key});

  @override
  State<AbrirChamadoPage> createState() => _AbrirChamadoPageState();
}

class _AbrirChamadoPageState extends State<AbrirChamadoPage> {
  final TextEditingController descricaoController = TextEditingController();

  String categoriaSelecionada = 'Sem internet';
  String prioridadeSelecionada = 'Normal';
  ChamadoModel? chamadoCriado;

  final List<String> categorias = [
    'Sem internet',
    'Internet lenta',
    'Oscilação',
    'Financeiro',
    'Mudança de endereço',
    'Outros',
  ];

  final List<String> prioridades = ['Baixa', 'Normal', 'Alta'];

  String getSlaText() {
    if (prioridadeSelecionada == 'Alta') {
      return 'até 2h úteis';
    }

    if (prioridadeSelecionada == 'Normal') {
      return 'até 4h úteis';
    }

    return 'até 8h úteis';
  }

  void abrirChamado() {
    final novoChamado = ChamadoModel(
      protocolo: '#RF1029',
      categoria: categoriaSelecionada,
      descricao: descricaoController.text.trim().isEmpty
          ? 'Cliente não informou descrição.'
          : descricaoController.text.trim(),
      prioridade: prioridadeSelecionada,
      status: 'Aberto',
      sla: getSlaText(),
      criadoEm: DateTime.now(),
    );

    setState(() {
      chamadoCriado = novoChamado;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Chamado ${novoChamado.protocolo} aberto com sucesso!'),
        backgroundColor: AppColors.secondaryBlue,
      ),
    );
  }

  @override
  void dispose() {
    descricaoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chamado = chamadoCriado;

    return Scaffold(
      backgroundColor: AppColors.lightGray,
      body: SafeArea(
        child: SingleChildScrollView(
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
                      'Abrir Chamado',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              const Text(
                'Descreva o problema para encaminharmos ao suporte.',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),

              const SizedBox(height: 20),

              PremiumCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Categoria',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
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
                          backgroundColor: Colors.white,
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
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: prioridades.map((prioridade) {
                        final selected = prioridade == prioridadeSelecionada;

                        return ChoiceChip(
                          label: Text(prioridade),
                          selected: selected,
                          selectedColor: AppColors.orange,
                          backgroundColor: Colors.white,
                          labelStyle: TextStyle(
                            color: selected ? Colors.white : Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                          onSelected: (_) {
                            setState(() {
                              prioridadeSelecionada = prioridade;
                            });
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'SLA estimado: ${getSlaText()}',
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
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
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

              if (chamado != null)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: Colors.green.shade200),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle, color: Colors.green),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Chamado ${chamado.protocolo} aberto com sucesso.\n'
                          'Categoria: ${chamado.categoria}\n'
                          'Prioridade: ${chamado.prioridade}\n'
                          'SLA: ${chamado.sla}',
                          style: const TextStyle(
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
      ),
    );
  }
}
