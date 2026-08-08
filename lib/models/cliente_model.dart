class ClienteModel {
  final String id;
  final String nome;
  final String cpf;
  final String plano;
  final String statusContrato;
  final String statusConexao;

  const ClienteModel({
    required this.id,
    required this.nome,
    required this.cpf,
    required this.plano,
    required this.statusContrato,
    required this.statusConexao,
  });

  bool get contratoAtivo => statusContrato.toLowerCase() == 'ativo';

  bool get conexaoOnline => statusConexao.toLowerCase() == 'online';

  factory ClienteModel.fromJson(Map<String, dynamic> json) {
    return ClienteModel(
      id: json['id']?.toString() ?? '',
      nome: json['nome']?.toString() ?? 'Cliente',
      cpf: json['cpf']?.toString() ?? '',
      plano: json['plano']?.toString() ?? '',
      statusContrato: json['statusContrato']?.toString() ?? '',
      statusConexao: json['statusConexao']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'cpf': cpf,
      'plano': plano,
      'statusContrato': statusContrato,
      'statusConexao': statusConexao,
    };
  }
}
