class ConsumoModel {
  final int totalGb;
  final double percentualUso;
  final List<Map<String, String>> categorias;

  const ConsumoModel({
    required this.totalGb,
    required this.percentualUso,
    required this.categorias,
  });

  String get totalFormatado => '$totalGb GB';

  factory ConsumoModel.fromJson(Map<String, dynamic> json) {
    return ConsumoModel(
      totalGb: json['totalGb'] is int ? json['totalGb'] : 0,
      percentualUso: json['percentualUso'] is num
          ? (json['percentualUso'] as num).toDouble()
          : 0,
      categorias: (json['categorias'] as List<dynamic>? ?? [])
          .map((item) => Map<String, String>.from(item as Map))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalGb': totalGb,
      'percentualUso': percentualUso,
      'categorias': categorias,
    };
  }
}
