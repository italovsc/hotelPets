// lib/models/pet.dart
class Pet {
  final String id; // usamos String para compatibilidade (id do servidor pode ser número)
  final String nomeTutor;
  final String contatoTutor;
  final String especie; // "Cachorro" | "Gato"
  final String raca;
  final DateTime dataEntrada;
  final DateTime? dataSaidaPrevista;

  Pet({
    required this.id,
    required this.nomeTutor,
    required this.contatoTutor,
    required this.especie,
    required this.raca,
    required this.dataEntrada,
    this.dataSaidaPrevista,
  });

  factory Pet.fromJson(Map<String, dynamic> json) {
    final idVal = json['id'] != null ? json['id'].toString() : '';

    final dataEntradaStr = json['dataEntrada'] ?? json['data_entrada'] ?? json['dataEntrada'];
    final dataEntrada = DateTime.parse(dataEntradaStr);

    DateTime? dataSaida;
    if (json['dataSaidaPrevista'] != null) {
      dataSaida = DateTime.parse(json['dataSaidaPrevista']);
    } else if (json['data_saida_prevista'] != null) {
      dataSaida = DateTime.parse(json['data_saida_prevista']);
    }

    return Pet(
      id: idVal,
      nomeTutor: json['nomeTutor'] ?? json['nome'] ?? '',
      contatoTutor: json['contatoTutor'] ?? json['dono'] ?? '',
      especie: json['especie'] ?? '',
      raca: json['raca'] ?? '',
      dataEntrada: dataEntrada,
      dataSaidaPrevista: dataSaida,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nomeTutor': nomeTutor,
      'contatoTutor': contatoTutor,
      'especie': especie,
      'raca': raca,
      // envia apenas a parte da data no formato YYYY-MM-DD (DATEONLY)
      'dataEntrada': dataEntrada.toIso8601String().split('T').first,
      'dataSaidaPrevista': dataSaidaPrevista?.toIso8601String().split('T').first,
    };
  }

  // copyWith para criar cópias modificadas (útil em LocalPetService)
  Pet copyWith({
    String? id,
    String? nomeTutor,
    String? contatoTutor,
    String? especie,
    String? raca,
    DateTime? dataEntrada,
    DateTime? dataSaidaPrevista,
  }) {
    return Pet(
      id: id ?? this.id,
      nomeTutor: nomeTutor ?? this.nomeTutor,
      contatoTutor: contatoTutor ?? this.contatoTutor,
      especie: especie ?? this.especie,
      raca: raca ?? this.raca,
      dataEntrada: dataEntrada ?? this.dataEntrada,
      dataSaidaPrevista: dataSaidaPrevista ?? this.dataSaidaPrevista,
    );
  }

  // getters utilitários (diárias)
  int get diariasAteOMomento {
    final now = DateTime.now();
    final start = DateTime(dataEntrada.year, dataEntrada.month, dataEntrada.day);
    final diff = now.difference(start).inDays;
    return diff >= 0 ? diff : 0;
  }

  int? get diariasTotaisPrevistas {
    if (dataSaidaPrevista == null) return null;
    final start = DateTime(dataEntrada.year, dataEntrada.month, dataEntrada.day);
    final end = DateTime(dataSaidaPrevista!.year, dataSaidaPrevista!.month, dataSaidaPrevista!.day);
    final diff = end.difference(start).inDays;
    return diff >= 0 ? diff : 0;
  }

  @override
  String toString() {
    return 'Pet(id: $id, tutor: $nomeTutor, especie: $especie, raca: $raca)';
  }
}
