import 'package:flutter/material.dart';

class BotaoMenuVibra extends StatelessWidget {
  const BotaoMenuVibra({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Abrir menu',
      icon: const Icon(Icons.menu),
      onPressed: () => Scaffold.of(context).openEndDrawer(),
    );
  }
}

class MenuVibra extends StatelessWidget {
  const MenuVibra({super.key});

  static const rotaConvidados = '/convidados';

  void _navegar(BuildContext context, String destino) {
    final navigator = Navigator.of(context);
    final rotaAtual = ModalRoute.of(context)?.settings.name;
    Scaffold.of(context).closeEndDrawer();
    if (rotaAtual == destino) return;

    var destinoAberto = false;
    navigator.popUntil((rota) {
      destinoAberto = rota.settings.name == destino;
      return destinoAberto || rota.isFirst;
    });
    if (destino == rotaConvidados && !destinoAberto) {
      navigator.pushNamed<void>(destino);
    }
  }

  @override
  Widget build(BuildContext context) {
    final rota = ModalRoute.of(context)?.settings.name;
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              title: Text(
                'Eventos e festas',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              trailing: IconButton(
                tooltip: 'Fechar menu',
                icon: const Icon(Icons.close),
                onPressed: () => Scaffold.of(context).closeEndDrawer(),
              ),
            ),
            ListTile(
              selected: rota == '/',
              leading: const Icon(Icons.home_outlined),
              title: const Text('Início'),
              onTap: () => _navegar(context, '/'),
            ),
            ListTile(
              selected: rota == rotaConvidados,
              leading: const Icon(Icons.people_outline),
              title: const Text('Convidados'),
              onTap: () => _navegar(context, rotaConvidados),
            ),
          ],
        ),
      ),
    );
  }
}
