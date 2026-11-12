# VIBRA

Aplicativo Flutter de eventos e festas desenvolvido para o trabalho final de Programação para Dispositivos Móveis.

## O que está pronto

- Tema preto, logo VIBRA, menu lateral e linha branca abaixo do cabeçalho.
- Três banners com passagem automática a cada quatro segundos, setas e indicadores.
- Título e subtítulo centralizados.
- Cards de eventos com detalhes, busca, mapa e inscrição de convidados.
- Cadastro, edição, exclusão e confirmação de convidados persistidos em SQLite.

Os eventos são definidos no código Dart e não dependem do banco de dados. O SQLite armazena os convidados em uma única tabela (`convidados`), incluindo nome, acompanhantes, confirmação e dados opcionais do evento escolhido.

## Executar

Abra esta pasta no VS Code e execute no terminal:

```powershell
flutter pub get
flutter run -d windows
```

Para Android, inicie o emulador, consulte `flutter devices` e use `flutter run -d ID_DO_DISPOSITIVO`.

Para compilar para Windows, o computador precisa das ferramentas de desenvolvimento para desktop com C++ do Visual Studio.

## Organização do código

```text
lib/
  main.dart                       Inicialização e tema do VIBRA
  pages/
    inicio_page.dart              Cabeçalho, menu e apresentação
    lana_exemplo_page.dart        Detalhes e inscrição em eventos
    convidados_page.dart          CRUD e resumo de convidados
  database/
    database_helper.dart          Persistência SQLite e migração
  models/
    evento.dart                   Dados dos eventos mantidos em Dart
    convidado.dart                Modelo persistido de convidado
  widgets/
    banners_carrossel.dart        Carrossel de imagens
    lista_eventos.dart            Dados de exemplo e navegação dos cards
    card_evento.dart              Aparência de cada card
assets/images/                    Logo, banners e fotos dos eventos
android/                          Arquivos necessários para executar no Android
windows/                          Arquivos necessários para executar no Windows
```

## Bibliotecas

- Flutter Material: componentes, tema, ícones e navegação.
- carousel_slider: carrossel com troca automática.
- sqflite: persistência SQLite no Android.
- sqflite_common_ffi: persistência SQLite no Windows Desktop.

Os eventos são definidos em Dart e não dependem do banco. A persistência usa somente a tabela `convidados`, com `sqflite` no Android e `sqflite_common_ffi` no Windows. Ao atualizar uma instalação antiga, a migração remove a tabela legada `eventos` e mantém linhas de convidados caso a tabela antiga contenha os respectivos campos.

## Antes de compactar ou enviar

```powershell
flutter clean
```

Inclua código, assets e arquivos de configuração. Não inclua `build`, `.dart_tool` nem um repositório `.git` de outro projeto. O `.gitignore` já ignora os principais arquivos gerados.
