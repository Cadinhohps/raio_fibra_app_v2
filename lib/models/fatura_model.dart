class FaturaModel {
  final String competencia;
  final String valor;
  final String vencimento;
  final String status;
  final String pixCopiaCola;
  final String pdfUrl;

  const FaturaModel({
    required this.competencia,
    required this.valor,
    required this.vencimento,
    required this.status,
    required this.pixCopiaCola,
    required this.pdfUrl,
  });

  bool get estaPago => status.toLowerCase() == 'pago';

  bool get estaEmAberto => status.toLowerCase() == 'em aberto';

  factory FaturaModel.fromJson(Map<String, dynamic> json) {
    return FaturaModel(
      competencia: json['competencia'] ?? '',
      valor: json['valor'] ?? '',
      vencimento: json['vencimento'] ?? '',
      status: json['status'] ?? '',
      pixCopiaCola: json['pixCopiaCola'] ?? '',
      pdfUrl: json['pdfUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'competencia': competencia,
      'valor': valor,
      'vencimento': vencimento,
      'status': status,
      'pixCopiaCola': pixCopiaCola,
      'pdfUrl': pdfUrl,
    };
  }
}
