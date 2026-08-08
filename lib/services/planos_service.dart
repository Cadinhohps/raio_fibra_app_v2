import '../models/plano_model.dart';

class PlanosService {
  Future<List<PlanoModel>> listarPlanos() async {
    return const [
      PlanoModel(
        id: 'PLANO600',
        nome: '600 Mega',
        downloadMbps: 600,
        uploadMbps: 300,
        valor: 'R\$ 99,90',
        beneficios: [
          'Wi-Fi premium',
          'Suporte prioritario',
          'Instalacao inclusa',
        ],
      ),
      PlanoModel(
        id: 'PLANO800',
        nome: '800 Mega',
        downloadMbps: 800,
        uploadMbps: 400,
        valor: 'R\$ 119,90',
        beneficios: [
          'Mais velocidade',
          'Ideal para streaming',
          'Upgrade facilitado',
        ],
      ),
    ];
  }
}
