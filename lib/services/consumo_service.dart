import '../models/consumo_model.dart';

class ConsumoService {
  Future<ConsumoModel> buscarConsumoAtual() async {
    return const ConsumoModel(
      totalGb: 842,
      percentualUso: 0.72,
      categorias: [
        {'label': 'Streaming', 'value': '48%', 'icon': 'live_tv'},
        {'label': 'Trabalho', 'value': '28%', 'icon': 'laptop'},
        {'label': 'Jogos', 'value': '16%', 'icon': 'games'},
        {'label': 'Outros', 'value': '8%', 'icon': 'more'},
      ],
    );
  }
}
