class PlanoModel {
  final String id;
  final String nome;
  final int downloadMbps;
  final int uploadMbps;
  final String valor;
  final List<String> beneficios;

  const PlanoModel({
    required this.id,
    required this.nome,
    required this.downloadMbps,
    required this.uploadMbps,
    required this.valor,
    required this.beneficios,
  });

  String get velocidade => '$downloadMbps Mega';

  factory PlanoModel.fromJson(Map<String, dynamic> json) {
    return PlanoModel(
      id: json['id']?.toString() ?? '',
      nome: json['nome']?.toString() ?? '',
      downloadMbps: json['downloadMbps'] is int ? json['downloadMbps'] : 0,
      uploadMbps: json['uploadMbps'] is int ? json['uploadMbps'] : 0,
      valor: json['valor']?.toString() ?? '',
      beneficios: (json['beneficios'] as List<dynamic>? ?? [])
          .map((item) => item.toString())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'downloadMbps': downloadMbps,
      'uploadMbps': uploadMbps,
      'valor': valor,
      'beneficios': beneficios,
    };
  }
}
