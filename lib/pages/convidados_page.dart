import 'package:flutter/material.dart';

import '../database/database_helper.dart';
import '../models/convidado.dart';
import '../theme/vibra_theme.dart';
import '../widgets/card_convidado.dart';
import '../widgets/menu_vibra.dart';
import 'convidado_form_page.dart';

class ConvidadosPage extends StatefulWidget {
  const ConvidadosPage({super.key});

  @override
  State<ConvidadosPage> createState() => _ConvidadosPageState();
}

class _ConvidadosPageState extends State<ConvidadosPage> {
  late Future<List<Convidado>> _convidados;
  late Future<int> _total;

  @override
  void initState() {
    super.initState();
    _recarregar();
  }

  void _recarregar() {
    _convidados = DatabaseHelper.instance.listarConvidados();
    _total = DatabaseHelper.instance.totalPessoasConfirmadas();
  }

  Future<void> _abrirFormulario({Convidado? convidado}) async {
    final resultado = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (_) => ConvidadoFormPage(convidado: convidado?.toFormMap()),
      ),
    );
    if (!mounted || resultado == null) return;
    final registro = Convidado(
      id: convidado?.id,
      nome: resultado['nome'] as String,
      acompanhantes: resultado['acompanhantes'] as int,
      confirmado: resultado['confirmado'] as bool,
      eventoId: convidado?.eventoId,
      eventoNome: convidado?.eventoNome,
    );
    if (convidado == null) {
      await DatabaseHelper.instance.inserirConvidado(registro);
    } else {
      await DatabaseHelper.instance.atualizarConvidado(registro);
    }
    if (!mounted) return;
    setState(_recarregar);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(convidado == null
            ? 'Convidado adicionado.'
            : 'Dados do convidado atualizados.'),
      ));
  }

  Future<void> _excluir(Convidado convidado) async {
    final excluir = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Excluir convidado?'),
        content: Text('Deseja remover ${convidado.nome} da lista?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            style: VibraTema.botaoDestrutivo(context),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
    if (excluir != true || convidado.id == null) return;
    await DatabaseHelper.instance.excluirConvidado(convidado.id!);
    if (!mounted) return;
    setState(_recarregar);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${convidado.nome} foi removido da lista.')),
    );
  }

  Future<void> _alterarConfirmacao(Convidado convidado, bool confirmado) async {
    await DatabaseHelper.instance.atualizarConvidado(Convidado(
      id: convidado.id,
      nome: convidado.nome,
      acompanhantes: convidado.acompanhantes,
      confirmado: confirmado,
      eventoId: convidado.eventoId,
      eventoNome: convidado.eventoNome,
    ));
    if (mounted) setState(_recarregar);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: BarraVibra(titulo: const Text('Convidados')),
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
              child: FutureBuilder<List<Convidado>>(
                future: _convidados,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                              'Não foi possível carregar os convidados.'),
                          TextButton(
                            onPressed: () => setState(_recarregar),
                            child: const Text('Tentar novamente'),
                          ),
                        ],
                      ),
                    );
                  }
                  final convidados = snapshot.data ?? const <Convidado>[];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Sua festa começa com as pessoas.',
                                style: VibraTema.tituloSecao),
                            const SizedBox(height: 12),
                            FutureBuilder<int>(
                              future: _total,
                              builder: (context, totalSnapshot) => Text(
                                '${convidados.length} convidado(s) • ${totalSnapshot.data ?? 0} pessoa(s) confirmada(s)',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: convidados.isEmpty
                            ? Center(
                                child: SingleChildScrollView(
                                  padding: const EdgeInsets.all(24),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.people_outline,
                                          size: 64, color: VibraCores.destaque),
                                      const SizedBox(height: 16),
                                      const Text('Nenhum convidado cadastrado',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                      const SizedBox(height: 8),
                                      const Text(
                                          'Adicione o primeiro convidado para começar a organizar sua festa.',
                                          textAlign: TextAlign.center,
                                          style: VibraTema.textoSecundario),
                                      const SizedBox(height: 16),
                                      OutlinedButton(
                                          onPressed: () => _abrirFormulario(),
                                          child: const Text(
                                              'Adicionar primeiro convidado')),
                                    ],
                                  ),
                                ),
                              )
                            : ListView.builder(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 0, 20, 100),
                                itemCount: convidados.length,
                                itemBuilder: (context, index) {
                                  final convidado = convidados[index];
                                  return CardConvidado(
                                    nome: convidado.nome,
                                    acompanhantes: convidado.acompanhantes,
                                    confirmado: convidado.confirmado,
                                    onEditar: () =>
                                        _abrirFormulario(convidado: convidado),
                                    onExcluir: () => _excluir(convidado),
                                    onAlterarConfirmacao: (confirmado) =>
                                        _alterarConfirmacao(
                                            convidado, confirmado),
                                  );
                                },
                              ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      );
}

extension on Convidado {
  Map<String, dynamic> toFormMap() => {
        'id': id,
        'nome': nome,
        'acompanhantes': acompanhantes,
        'confirmado': confirmado,
      };
}
