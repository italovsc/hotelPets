
import 'dart:async';
import 'package:uuid/uuid.dart';
import '../models/pet.dart';

abstract class PetService {
  Future<List<Pet>> fetchAll();
  Future<Pet> create(Pet pet);
  Future<void> update(Pet pet);
  Future<void> delete(String id);
  Future<Pet?> getById(String id);
}


class LocalPetService implements PetService {
  final List<Pet> _store = [];
  final _uuid = const Uuid();

  LocalPetService() {
    
    final now = DateTime.now();
    _store.addAll([
      Pet(
        id: _uuid.v4(),
        nomeTutor: 'Ana Silva',
        contatoTutor: '1199999-0000',
        especie: 'Cachorro',
        raca: 'Vira-lata',
        dataEntrada: now.subtract(const Duration(days: 3)),
        dataSaidaPrevista: now.add(const Duration(days: 2)),
      ),
      Pet(
        id: _uuid.v4(),
        nomeTutor: 'Carlos Souza',
        contatoTutor: 'carlos@example.com',
        especie: 'Gato',
        raca: 'Siamês',
        dataEntrada: now.subtract(const Duration(days: 1)),
        dataSaidaPrevista: null,
      ),
    ]);
  }

  
  Future<T> _withDelay<T>(T Function() fn) async {
    await Future.delayed(const Duration(milliseconds: 250));
    return fn();
  }

  @override
  Future<Pet> create(Pet pet) async {
    return _withDelay(() {
      final toAdd = pet.id.isEmpty ? pet.copyWith(id: _uuid.v4()) : pet;
      _store.add(toAdd);
      return toAdd;
    });
  }

  @override
  Future<void> delete(String id) async {
    return _withDelay(() {
      _store.removeWhere((p) => p.id == id);
    });
  }

  @override
  Future<List<Pet>> fetchAll() async {
    return _withDelay(() => List<Pet>.from(_store));
  }

  @override
  Future<void> update(Pet pet) async {
    return _withDelay(() {
      final idx = _store.indexWhere((p) => p.id == pet.id);
      if (idx >= 0) {
        _store[idx] = pet;
      } else {
        throw Exception('Pet não encontrado: ${pet.id}');
      }
    });
  }

  @override
  Future<Pet?> getById(String id) async {
    return _withDelay(() {
      try {
        return _store.firstWhere((p) => p.id == id);
      } catch (e) {
        return null;
      }
    });
  }
}