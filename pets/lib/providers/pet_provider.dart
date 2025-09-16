
import 'package:flutter/material.dart';
import '../models/pet.dart';
import '../services/pet_service.dart';

class PetProvider extends ChangeNotifier {
  final PetService service;
  List<Pet> _pets = [];
  bool _loading = false;

  PetProvider({required this.service});

  List<Pet> get pets => List.unmodifiable(_pets);
  bool get loading => _loading;

  Future<void> loadPets() async {
    _loading = true;
    notifyListeners();
    try {
      _pets = await service.fetchAll();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> addPet(Pet pet) async {
    _loading = true;
    notifyListeners();
    try {
      final created = await service.create(pet);
      _pets.add(created);
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> updatePet(Pet pet) async {
    _loading = true;
    notifyListeners();
    try {
      await service.update(pet);
      final idx = _pets.indexWhere((p) => p.id == pet.id);
      if (idx >= 0) {
        _pets[idx] = pet;
      }
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> deletePet(String id) async {
    
    final idx = _pets.indexWhere((p) => p.id == id);
    Pet? removed;
    if (idx >= 0) {
      removed = _pets.removeAt(idx);
      notifyListeners(); 
    }

    try {
      await service.delete(id); 
    } catch (e) {
      
      if (removed != null) {
        _pets.insert(idx, removed);
        notifyListeners();
      }
      rethrow; 
    }
  }


  Pet? getById(String id) {
    try {
      return _pets.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }
}