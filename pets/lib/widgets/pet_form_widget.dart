
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/pet.dart';

typedef SavePetCallback = Future<void> Function(Pet pet);

class PetFormWidget extends StatefulWidget {
  final Pet? initialPet;
  final SavePetCallback onSave;

  const PetFormWidget({Key? key, this.initialPet, required this.onSave}) : super(key: key);

  @override
  State<PetFormWidget> createState() => _PetFormWidgetState();
}

class _PetFormWidgetState extends State<PetFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _dateFormat = DateFormat('dd/MM/yyyy');

  late TextEditingController _nomeCtrl;
  late TextEditingController _contatoCtrl;
  late TextEditingController _racaCtrl;
  late TextEditingController _dataEntradaCtrl;
  late TextEditingController _dataSaidaCtrl;

  String _especie = 'Cachorro';
  late DateTime _dataEntrada;
  DateTime? _dataSaida;

  @override
  void initState() {
    super.initState();
    final p = widget.initialPet;
    _nomeCtrl = TextEditingController(text: p?.nomeTutor ?? '');
    _contatoCtrl = TextEditingController(text: p?.contatoTutor ?? '');
    _racaCtrl = TextEditingController(text: p?.raca ?? '');
    _especie = p?.especie ?? 'Cachorro';
    _dataEntrada = p?.dataEntrada ?? DateTime.now();
    _dataEntradaCtrl = TextEditingController(text: _dateFormat.format(_dataEntrada));
    _dataSaida = p?.dataSaidaPrevista;
    _dataSaidaCtrl = TextEditingController(text: _dataSaida != null ? _dateFormat.format(_dataSaida!) : '');
  }

  @override
  void dispose() {
    _nomeCtrl.dispose();
    _contatoCtrl.dispose();
    _racaCtrl.dispose();
    _dataEntradaCtrl.dispose();
    _dataSaidaCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate(BuildContext context, {required bool isEntrada}) async {
    final initial = isEntrada ? _dataEntrada : (_dataSaida ?? _dataEntrada);
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isEntrada) {
          _dataEntrada = picked;
          _dataEntradaCtrl.text = _dateFormat.format(picked);
          if (_dataSaida != null && _dataSaida!.isBefore(_dataEntrada)) {
            _dataSaida = null;
            _dataSaidaCtrl.text = '';
          }
        } else {
          _dataSaida = picked;
          _dataSaidaCtrl.text = _dateFormat.format(picked);
        }
      });
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final baseId = widget.initialPet?.id ?? '';
    final pet = Pet(
      id: baseId,
      nomeTutor: _nomeCtrl.text.trim(),
      contatoTutor: _contatoCtrl.text.trim(),
      especie: _especie,
      raca: _racaCtrl.text.trim(),
      dataEntrada: DateTime(_dataEntrada.year, _dataEntrada.month, _dataEntrada.day),
      dataSaidaPrevista: _dataSaida != null ? DateTime(_dataSaida!.year, _dataSaida!.month, _dataSaida!.day) : null,
    );

    await widget.onSave(pet);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _nomeCtrl,
            decoration: const InputDecoration(labelText: 'Nome do Tutor'),
            validator: (v) => (v == null || v.trim().isEmpty) ? 'Campo obrigatório' : null,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _contatoCtrl,
            decoration: const InputDecoration(labelText: 'Contato do Tutor'),
            validator: (v) => (v == null || v.trim().isEmpty) ? 'Campo obrigatório' : null,
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: _especie,
            decoration: const InputDecoration(labelText: 'Espécie'),
            items: const [
              DropdownMenuItem(value: 'Cachorro', child: Text('Cachorro')),
              DropdownMenuItem(value: 'Gato', child: Text('Gato')),
            ],
            onChanged: (v) => setState(() => _especie = v ?? 'Cachorro'),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _racaCtrl,
            decoration: const InputDecoration(labelText: 'Raça'),
            validator: (v) => (v == null || v.trim().isEmpty) ? 'Campo obrigatório' : null,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _dataEntradaCtrl,
            readOnly: true,
            decoration: const InputDecoration(labelText: 'Data de entrada'),
            onTap: () => _pickDate(context, isEntrada: true),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _dataSaidaCtrl,
            readOnly: true,
            decoration: const InputDecoration(labelText: 'Previsão de saída (opcional)'),
            onTap: () => _pickDate(context, isEntrada: false),
          ),
          const SizedBox(height: 16),
          Builder(builder: (ctx) {
            final entrada = DateTime(_dataEntrada.year, _dataEntrada.month, _dataEntrada.day);
            final now = DateTime.now();
            final diariasAgora = now.difference(entrada).inDays >= 0 ? now.difference(entrada).inDays : 0;
            int? diariasTotais;
            if (_dataSaida != null) {
              final diff = DateTime(_dataSaida!.year, _dataSaida!.month, _dataSaida!.day).difference(entrada).inDays;
              diariasTotais = diff >= 0 ? diff : 0;
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Diárias até o momento: $diariasAgora', style: textTheme.bodyLarge),
                const SizedBox(height: 6),
                Text('Diárias totais previstas: ${diariasTotais != null ? diariasTotais : '-'}', style: textTheme.bodyLarge),
              ],
            );
          }),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: _submit,
                  child: Text(widget.initialPet == null ? 'Cadastrar' : 'Salvar'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}