class FaturaModel {
  final String id;
  final String clienteId;
  final String competencia;
  final String valor;
  final String vencimento;
  final String status;
  final String pixCopiaCola;
  final String pdfUrl;

  const FaturaModel({
    this.id = '',
    this.clienteId = '',
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
    final valorJson = json['valor'];

    return FaturaModel(
      id: json['id']?.toString() ?? '',
      clienteId: json['clienteId']?.toString() ?? '',
      competencia: json['competencia']?.toString() ?? '',
      valor: valorJson is num
          ? 'R\$ ${valorJson.toStringAsFixed(2).replaceAll('.', ',')}'
          : valorJson?.toString() ?? '',
      vencimento: json['vencimento']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      pixCopiaCola: json['pixCopiaCola']?.toString() ?? '',
      pdfUrl: json['pdfUrl']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'clienteId': clienteId,
      'competencia': competencia,
      'valor': valor,
      'vencimento': vencimento,
      'status': status,
      'pixCopiaCola': pixCopiaCola,
      'pdfUrl': pdfUrl,
    };
  }
}
