class ChamadoModel {
  final String protocolo;
  final String categoria;
  final String descricao;
  final String prioridade;
  final String status;
  final String sla;
  final DateTime criadoEm;

  const ChamadoModel({
    required this.protocolo,
    required this.categoria,
    required this.descricao,
    required this.prioridade,
    required this.status,
    required this.sla,
    required this.criadoEm,
  });

  bool get estaAberto => status.toLowerCase() == 'aberto';

  bool get estaEmAndamento => status.toLowerCase() == 'em andamento';

  bool get estaResolvido => status.toLowerCase() == 'resolvido';

  factory ChamadoModel.fromJson(Map<String, dynamic> json) {
    return ChamadoModel(
      protocolo: json['protocolo'] ?? '',
      categoria: json['categoria'] ?? '',
      descricao: json['descricao'] ?? '',
      prioridade: json['prioridade'] ?? '',
      status: json['status'] ?? '',
      sla: json['sla'] ?? '',
      criadoEm: DateTime.tryParse(json['criadoEm'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'protocolo': protocolo,
      'categoria': categoria,
      'descricao': descricao,
      'prioridade': prioridade,
      'status': status,
      'sla': sla,
      'criadoEm': criadoEm.toIso8601String(),
    };
  }
}
