class WifiModel {
  final String ssid;
  final String senha;
  final String frequencia;
  final String sinal;
  final List<Map<String, String>> dispositivos;

  const WifiModel({
    required this.ssid,
    required this.senha,
    required this.frequencia,
    required this.sinal,
    required this.dispositivos,
  });

  int get totalDispositivos => dispositivos.length;

  factory WifiModel.fromJson(Map<String, dynamic> json) {
    return WifiModel(
      ssid: json['ssid']?.toString() ?? '',
      senha: json['senha']?.toString() ?? '',
      frequencia: json['frequencia']?.toString() ?? '',
      sinal: json['sinal']?.toString() ?? '',
      dispositivos: (json['dispositivos'] as List<dynamic>? ?? [])
          .map((item) => Map<String, String>.from(item as Map))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ssid': ssid,
      'senha': senha,
      'frequencia': frequencia,
      'sinal': sinal,
      'dispositivos': dispositivos,
    };
  }
}
