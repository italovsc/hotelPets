// lib/widgets/pet_card.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/pet.dart';
import '../utils/date_utils.dart';

typedef PetCallback = void Function(Pet pet);

class PetCard extends StatelessWidget {
  final Pet pet;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const PetCard({
    Key? key,
    required this.pet,
    this.onEdit,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy');
    final entrada = dateFormat.format(pet.dataEntrada);
    final previsao = pet.dataSaidaPrevista != null ? dateFormat.format(pet.dataSaidaPrevista!) : '—';
    final diariasAgora = pet.diariasAteOMomento;
    final diariasPrevistas = pet.diariasTotaisPrevistas != null ? pet.diariasTotaisPrevistas.toString() : '—';

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
            Text('Entrada: $entrada  •  Diárias agora: $diariasAgora', style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 4),
            Text('Previsão saída: $previsao  •  Diárias previstas: $diariasPrevistas', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        isThreeLine: true,
        trailing: Wrap(
          spacing: 6,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              tooltip: 'Editar',
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              tooltip: 'Excluir',
              onPressed: onDelete,
            ),
          ],
        ),
        onTap: onEdit,
      ),
    );
  }
}
