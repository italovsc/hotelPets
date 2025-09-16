// lib/screens/pet_form_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../models/pet.dart';
import '../providers/pet_provider.dart';

class PetFormScreen extends StatefulWidget {
  const PetFormScreen({Key? key}) : super(key: key);

  @override
  State<PetFormScreen> createState() => _PetFormScreenState();
}

class _PetFormScreenState extends State<PetFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _dateFormat = DateFormat('dd/MM/yyyy');

  // Controllers
  final TextEditingController _nomeTutorCtrl = TextEditingController();
  final TextEditingController _contatoCtrl = TextEditingController();
  final TextEditingController _racaCtrl = TextEditingController();
  final TextEditingController _dataEntradaCtrl = TextEditingController();
  final TextEditingController _dataSaidaCtrl = TextEditingController();

  String _especie = 'Cachorro';
  DateTime _dataEntrada = DateTime.now();
  DateTime? _dataSaida;

  bool _isEdit = false;
  String? _editingId;

  @override
  void initState() {
    super.initState();
    // Prepara controllers. Caso edição, iremos popular no didChangeDependencies.
    _dataEntradaCtrl.text = _dateFormat.format(_dataEntrada);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Checa se veio um Pet nos argumentos — se sim, estamos em edição
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && !_isEdit) {
      if (args is Pet) {
        _isEdit = true;
        _editingId = args.id;
        _nomeTutorCtrl.text = args.nomeTutor;
        _contatoCtrl.text = args.contatoTutor;
        _racaCtrl.text = args.raca;
        _especie = args.especie;
        _dataEntrada = args.dataEntrada;
        _dataEntradaCtrl.text = _dateFormat.format(_dataEntrada);
        if (args.dataSaidaPrevista != null) {
          _dataSaida = args.dataSaidaPrevista;
          _dataSaidaCtrl.text = _dateFormat.format(_dataSaida!);
        }
      }
    }
  }

  @override
  void dispose() {
    _nomeTutorCtrl.dispose();
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
          // If saída is before entrada, clear saída
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

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) {
      print('[PetFormScreen] validação falhou');
      return;
    }

    final provider = Provider.of<PetProvider>(context, listen: false);

    final id = _isEdit ? _editingId! : const Uuid().v4();

    final pet = Pet(
      id: id,
      nomeTutor: _nomeTutorCtrl.text.trim(),
      contatoTutor: _contatoCtrl.text.trim(),
      especie: _especie,
      raca: _racaCtrl.text.trim(),
      dataEntrada: DateTime(_dataEntrada.year, _dataEntrada.month, _dataEntrada.day),
      dataSaidaPrevista: _dataSaida != null ? DateTime(_dataSaida!.year, _dataSaida!.month, _dataSaida!.day) : null,
    );

    try {
      print('[PetFormScreen] salvando pet: ${pet.toJson()}');
      if (_isEdit) {
        await provider.updatePet(pet);
        print('[PetFormScreen] updatePet() concluído');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Registro atualizado')));
      } else {
        await provider.addPet(pet);
        print('[PetFormScreen] addPet() concluído');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Pet cadastrado')));
      }
      Navigator.of(context).pop();
    } catch (e, st) {
      print('[PetFormScreen] ERRO ao salvar: $e\n$st');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao salvar: $e')));
    }
  }


  String? _requiredValidator(String? v) {
    if (v == null || v.trim().isEmpty) return 'Campo obrigatório';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEdit ? 'Editar Pet' : 'Cadastrar Pet'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nomeTutorCtrl,
                  decoration: const InputDecoration(labelText: 'Nome do Tutor'),
                  validator: _requiredValidator,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _contatoCtrl,
                  decoration: const InputDecoration(labelText: 'Contato do Tutor (telefone ou e-mail)'),
                  validator: _requiredValidator,
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
                  validator: _requiredValidator,
                ),
                const SizedBox(height: 12),

                // Data de entrada - picker
                TextFormField(
                  controller: _dataEntradaCtrl,
                  readOnly: true,
                  decoration: const InputDecoration(labelText: 'Data de entrada'),
                  onTap: () => _pickDate(context, isEntrada: true),
                ),
                const SizedBox(height: 12),

                // Data de saída prevista - opcional
                TextFormField(
                  controller: _dataSaidaCtrl,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: 'Previsão de data de saída (opcional)',
                    hintText: 'Toque para selecionar',
                  ),
                  onTap: () => _pickDate(context, isEntrada: false),
                ),
                const SizedBox(height: 18),

                // Visualização de cálculo de diárias (pré-visualização)
                Builder(builder: (ctx) {
                  final entrada = DateTime(_dataEntrada.year, _dataEntrada.month, _dataEntrada.day);
                  final now = DateTime.now();
                  final diariasAteAgora = now.difference(entrada).inDays >= 0 ? now.difference(entrada).inDays : 0;
                  int? diariasTotais;
                  if (_dataSaida != null) {
                    final diff = DateTime(_dataSaida!.year, _dataSaida!.month, _dataSaida!.day).difference(entrada).inDays;
                    diariasTotais = diff >= 0 ? diff : 0;
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Diárias até o momento: $diariasAteAgora', style: textTheme.bodyLarge),
                      const SizedBox(height: 6),
                      Text('Diárias totais previstas: ${diariasTotais != null ? diariasTotais : '-'}', style: textTheme.bodyLarge),
                    ],
                  );
                }),

                const SizedBox(height: 24),

                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          print('[PetFormScreen] botão Cadastrar pressionado');
                          _save();
                        },
                        child: Text(_isEdit ? 'Salvar alterações' : 'Cadastrar'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
