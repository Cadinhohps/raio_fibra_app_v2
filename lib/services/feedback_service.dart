class FeedbackService {
  Future<Map<String, dynamic>> enviarFeedback({
    required int nota,
    required String comentario,
  }) async {
    return {
      'status': 'ok',
      'nota': nota,
      'comentario': comentario,
      'mensagem': 'Feedback registrado em modo demonstracao.',
    };
  }
}
