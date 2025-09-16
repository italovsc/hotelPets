
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../models/pet.dart';
import '../providers/pet_provider.dart';
import '../app_routes.dart';

class PetListScreen extends StatefulWidget {
  const PetListScreen({Key? key}) : super(key: key);

  @override
  State<PetListScreen> createState() => _PetListScreenState();
}

class _PetListScreenState extends State<PetListScreen> {
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = Provider.of<PetProvider>(context, listen: false);
      await provider.loadPets();
      setState(() => _loading = false);
    });
  }

  void _navigateToForm({Pet? pet}) {
    AppNavigator.pushToPetForm(context, pet: pet);
  }

  Future<void> _confirmDelete(String id) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Excluir registro'),
        content: const Text('Tem certeza que deseja excluir este registro?'),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Cancelar')),
          TextButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('Excluir')),
        ],
      ),
    );

    if (confirmed == true) {
      final provider = Provider.of<PetProvider>(context, listen: false);
      try {
        await provider.deletePet(id); 
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Registro excluído')));
      } catch (e) {
        
        
        try {
          await provider.loadPets();
        } catch (_) {}
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao excluir: $e')));
      }
    }
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.pets, size: 72, color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6)),
          const SizedBox(height: 12),
          Text('Nenhum pet cadastrado', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () => _navigateToForm(),
            child: const Text('Cadastrar o primeiro pet'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PetProvider>(context);
    final pets = provider.pets;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pets hospedados'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : pets.isEmpty
          ? _buildEmpty()
          : ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 12),
        itemCount: pets.length,
        itemBuilder: (context, index) {
          final pet = pets[index];

          
          final entrada = _dateFormat.format(pet.dataEntrada);
          final diariasAgora = pet.diariasAteOMomento;
          final previsao = pet.dataSaidaPrevista != null ? _dateFormat.format(pet.dataSaidaPrevista!) : '—';
          final diariasTotais = pet.diariasTotaisPrevistas != null ? '${pet.diariasTotaisPrevistas}' : '—';

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              leading: CircleAvatar(
                radius: 28,
                child: Icon(
                  pet.especie.toLowerCase() == 'gato' ? Icons.pets : Icons.pets_outlined,
                  size: 28,
                ),
              ),
              title: Text('${pet.raca} • ${pet.especie}', style: Theme.of(context).textTheme.titleMedium),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 6),
                  Text('Tutor: ${pet.nomeTutor} • ${pet.contatoTutor}', style: Theme.of(context).textTheme.bodyLarge),
                  const SizedBox(height: 6),
                  Text('Entrada: $entrada  •  Diárias até o momento: $diariasAgora', style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 4),
                  Text('Previsão saída: $previsao  •  Diárias previstas: $diariasTotais', style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
              isThreeLine: true,
              trailing: PopupMenuButton<String>(
                onSelected: (value) async {
                  if (value == 'edit') {
                    _navigateToForm(pet: pet);
                  } else if (value == 'delete') {
                    await _confirmDelete(pet.id);
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(value: 'edit', child: Text('Editar')),
                  const PopupMenuItem(value: 'delete', child: Text('Excluir')),
                ],
              ),
              onTap: () => _navigateToForm(pet: pet),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _navigateToForm(),
        icon: const Icon(Icons.add),
        label: const Text('Adicionar pet'),
      ),
    );
  }
}