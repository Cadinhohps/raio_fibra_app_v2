import '../models/cliente_model.dart';
import 'sgp_service.dart';

class ClienteService {
  final SgpService _sgpService;

  ClienteService({SgpService? sgpService})
    : _sgpService = sgpService ?? SgpService();

  Future<ClienteModel> buscarClienteAtual() async {
    final data = await _sgpService.buscarClientePorCpf('00000000000');
    return ClienteModel.fromJson(data);
  }
}
