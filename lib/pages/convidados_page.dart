import 'package:flutter/material.dart';

import '../widgets/menu_vibra.dart';

import '../widgets/card_convidado.dart';
import 'convidado_form_page.dart';

class ConvidadosPage extends StatefulWidget {
  const ConvidadosPage({super.key, required this.convidados});
  // Estado temporário compartilhado com a página inicial durante esta sessão.
  final List<Map<String, dynamic>> convidados;

  @override
  State<ConvidadosPage> createState() => _ConvidadosPageState();
}

class _ConvidadosPageState extends State<ConvidadosPage> {
  Future<void> _abrirFormulario({int? index}) async {
    final resultado = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute<Map<String, dynamic>>(
        builder: (_) => ConvidadoFormPage(
          convidado: index == null ? null : widget.convidados[index],
        ),
      ),
    );
    if (!mounted || resultado == null) return;
    setState(() {
      if (index == null) {
        widget.convidados.add(resultado);
      } else {
        widget.convidados[index] = {...widget.convidados[index], ...resultado};
      }
    });
  }

  Future<void> _excluir(int index) async {
    final nome = widget.convidados[index]['nome'] as String;
    final excluir = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Excluir convidado?'),
        content: Text('Deseja remover $nome da lista?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Theme.of(context).colorScheme.onError,
            ),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
    if (!mounted || excluir != true) return;
    setState(() => widget.convidados.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    final total = widget.convidados
        .where((c) => c['confirmado'] == true)
        .fold<int>(0, (soma, c) => soma + 1 + (c['acompanhantes'] as int));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Convidados'),
        actions: const [BotaoMenuVibra()],
      ),
      endDrawer: const MenuVibra(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _abrirFormulario(),
        icon: const Icon(Icons.person_add_alt_1),
        label: const Text('Adicionar'),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Sua festa começa com as pessoas.',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFB794F6),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        '${widget.convidados.length} convidado(s) • $total pessoa(s) confirmada(s)',
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Prévia: os dados ficam apenas nesta sessão e não são salvos ao fechar o app.',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: widget.convidados.isEmpty
                      ? Center(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.people_outline,
                                  size: 64,
                                  color: Color(0xFFB794F6),
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  'Nenhum convidado cadastrado',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Adicione o primeiro convidado para começar a organizar sua festa.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white70),
                                ),
                                const SizedBox(height: 16),
                                OutlinedButton(
                                  onPressed: () => _abrirFormulario(),
                                  child: const Text(
                                    'Adicionar primeiro convidado',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                          itemCount: widget.convidados.length,
                          itemBuilder: (context, index) {
                            final convidado = widget.convidados[index];
                            return CardConvidado(
                              nome: convidado['nome'] as String,
                              acompanhantes: convidado['acompanhantes'] as int,
                              confirmado: convidado['confirmado'] as bool,
                              onEditar: () => _abrirFormulario(index: index),
                              onExcluir: () => _excluir(index),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
