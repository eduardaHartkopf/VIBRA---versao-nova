import 'package:flutter/material.dart';

import '../widgets/menu_vibra.dart';

class ConvidadoFormPage extends StatefulWidget {
  const ConvidadoFormPage({super.key, this.convidado, this.evento});

  final String? evento;
  final Map<String, dynamic>? convidado;

  @override
  State<ConvidadoFormPage> createState() => _ConvidadoFormPageState();
}

class _ConvidadoFormPageState extends State<ConvidadoFormPage> {
  static final _letrasEspacos = RegExp(r'^[\p{L}\p{M} ]+$', unicode: true);

  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _acompanhantesController = TextEditingController();
  bool _confirmado = false;
  bool get _editando => widget.convidado != null;

  @override
  void initState() {
    super.initState();
    final convidado = widget.convidado;
    _nomeController.text = convidado?['nome'] as String? ?? '';
    _acompanhantesController.text = '${convidado?['acompanhantes'] ?? 0}';
    _confirmado = convidado?['confirmado'] as bool? ?? false;
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _acompanhantesController.dispose();
    super.dispose();
  }

  void _salvar() {
    if (!_formKey.currentState!.validate()) return;
    // Retorna os dados para a lista, sem gravar em banco.
    Navigator.pop(context, <String, dynamic>{
      'nome': _nomeController.text.trim(),
      'acompanhantes': int.parse(_acompanhantesController.text.trim()),
      'confirmado': widget.evento != null || _confirmado,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const MenuVibra(),
      appBar: AppBar(
        actions: const [BotaoMenuVibra()],
        title: Text(
          widget.evento != null
              ? 'Inscrição no evento'
              : _editando
              ? 'Editar convidado'
              : 'Novo convidado',
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  const Text(
                    'Quem vai à festa?',
                    style: TextStyle(
                      color: Color(0xFFB794F6),
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (widget.evento case final evento?)
                    Text(
                      evento,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  const SizedBox(height: 8),
                  const Text(
                    'Preencha os dados e indique se a presença já foi confirmada.',
                    style: TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _nomeController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textCapitalization: TextCapitalization.words,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: 'Nome do convidado',
                      prefixIcon: Icon(Icons.person_outline),
                      errorMaxLines: 2,
                      border: OutlineInputBorder(),
                    ),
                    validator: (valor) {
                      final nome = valor?.trim() ?? '';
                      if (nome.isEmpty) return 'Informe o nome do convidado.';
                      if (!_letrasEspacos.hasMatch(nome)) {
                        return 'Digite o nome da pessoa. Use apenas letras e espaços.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _acompanhantesController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Quantidade de acompanhantes',
                      helperText: 'Use 0 se o convidado for sozinho.',
                      prefixIcon: Icon(Icons.group_outlined),
                      errorMaxLines: 2,
                      border: OutlineInputBorder(),
                    ),
                    validator: (valor) {
                      final texto = valor?.trim() ?? '';
                      if (!RegExp(r'^\d+$').hasMatch(texto) ||
                          int.tryParse(texto) == null) {
                        return 'Use apenas números inteiros (0 ou mais).';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  if (widget.evento == null)
                    SwitchListTile(
                      tileColor: const Color(0xFF211B2C),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      activeThumbColor: Colors.black,
                      activeTrackColor: const Color(0xFFB794F6),
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: const Color(0xFF50465D),
                      title: const Text('Presença confirmada'),
                      subtitle: const Text(
                        'Inclui o convidado e seus acompanhantes no total.',
                      ),
                      value: _confirmado,
                      onChanged: (valor) => setState(() => _confirmado = valor),
                    ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: _salvar,
                    icon: const Icon(Icons.check),
                    label: Text(
                      widget.evento != null
                          ? 'Confirmar inscrição'
                          : _editando
                          ? 'Salvar alterações'
                          : 'Adicionar convidado',
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancelar'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
