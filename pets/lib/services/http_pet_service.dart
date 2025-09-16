import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pet.dart';
import 'pet_service.dart';

class HttpPetService implements PetService {
  final String baseUrl;
  HttpPetService({required this.baseUrl});

  @override
  Future<List<Pet>> fetchAll() async {
    final resp = await http.get(Uri.parse('$baseUrl/pets'));
    if (resp.statusCode == 200) {
      final list = jsonDecode(resp.body) as List;
      return list.map((j) => Pet.fromJson(j)).toList();
    }
    throw Exception('Erro ao buscar pets');
  }

  @override
  Future<Pet> create(Pet pet) async {
    final url = Uri.parse('$baseUrl/pets');
    final body = jsonEncode(pet.toJson());
    try {
      final resp = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );
      if (resp.statusCode == 200 || resp.statusCode == 201) {
        return Pet.fromJson(jsonDecode(resp.body));
      } else {
        throw Exception('Erro ao criar pet: ${resp.statusCode} ${resp.body}');
      }
    } catch (e, st) {
      rethrow;
    }
  }


  @override
  Future<void> update(Pet pet) async {
    final resp = await http.put(
      Uri.parse('$baseUrl/pets/${pet.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(pet.toJson()),
    );
    if (resp.statusCode != 200) {
      throw Exception('Erro ao atualizar pet');
    }
  }

  @override
  Future<void> delete(String id) async {
    final url = Uri.parse('$baseUrl/pets/$id');
    try {
      final resp = await http.delete(url);
      if (resp.statusCode != 200 && resp.statusCode != 204) {
        throw Exception('Erro ao deletar pet: ${resp.statusCode} ${resp.body}');
      }
    } catch (e, st) {
      rethrow; 
    }
  }

  @override
  Future<Pet?> getById(String id) async {
    final resp = await http.get(Uri.parse('$baseUrl/pets/$id'));
    if (resp.statusCode == 200) {
      return Pet.fromJson(jsonDecode(resp.body));
    }
    if (resp.statusCode == 404) return null;
    throw Exception('Erro ao buscar pet por id');
  }
}