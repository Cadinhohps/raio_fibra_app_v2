class SgpService {
  Future<Map<String, dynamic>> buscarClientePorCpf(String cpf) async {
    await Future.delayed(const Duration(milliseconds: 600));

    return {
      'id': 'CLI001',
      'nome': 'Ricardo',
      'cpf': cpf,
      'plano': '600 Mega',
      'statusContrato': 'Ativo',
      'statusConexao': 'Online',
    };
  }

  Future<List<Map<String, dynamic>>> buscarFaturas(String clienteId) async {
    await Future.delayed(const Duration(milliseconds: 600));

    return [
      {
        'competencia': 'Julho/2026',
        'valor': 'R\$ 99,90',
        'vencimento': '10/07/2026',
        'status': 'Em aberto',
      },
      {
        'competencia': 'Junho/2026',
        'valor': 'R\$ 99,90',
        'vencimento': '10/06/2026',
        'status': 'Pago',
      },
    ];
  }

  Future<Map<String, dynamic>> abrirChamado({
    required String clienteId,
    required String categoria,
    required String descricao,
    required String prioridade,
  }) async {
    await Future.delayed(const Duration(milliseconds: 700));

    return {
      'protocolo': '#RF1030',
      'clienteId': clienteId,
      'categoria': categoria,
      'descricao': descricao,
      'prioridade': prioridade,
      'status': 'Aberto',
    };
  }
}
