import '../models/wifi_model.dart';

class WifiService {
  Future<WifiModel> buscarWifiAtual() async {
    return const WifiModel(
      ssid: 'RaioFibra_600M',
      senha: 'raiofibra-demo',
      frequencia: '2.4 GHz e 5 GHz',
      sinal: 'Excelente',
      dispositivos: [
        {'nome': 'Smart TV Sala', 'tipo': 'Streaming', 'status': 'Online'},
        {'nome': 'Notebook Ricardo', 'tipo': 'Trabalho', 'status': 'Online'},
        {'nome': 'Celular Familia', 'tipo': 'Mobile', 'status': 'Online'},
        {'nome': 'Console', 'tipo': 'Jogos', 'status': 'Online'},
      ],
    );
  }
}
