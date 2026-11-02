# VIBRA

Aplicativo Flutter de eventos e festas desenvolvido para o trabalho final de Programação para Dispositivos Móveis.

## O que está pronto

- Tema preto, logo VIBRA, menu lateral e linha branca abaixo do cabeçalho.
- Três banners com passagem automática a cada quatro segundos, setas e indicadores.
- Título e subtítulo centralizados.
- Três cards de eventos com fotos, nomes e espaços para local e data.
- Navegação do card da Lana Del Rey para uma página de exemplo com contador e retorno.

Os eventos são exemplos visuais. Local, data e horário ainda estão a definir. A página da Lana Del Rey é uma demonstração da navegação. Cadastro de convidados, confirmação, resumo e SQLite ainda precisam ser implementados para atender ao trabalho final.

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
    lana_exemplo_page.dart        Página de exemplo com contador
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

## Antes de compactar ou enviar

```powershell
flutter clean
```

Inclua código, assets e arquivos de configuração. Não inclua `build`, `.dart_tool` nem um repositório `.git` de outro projeto. O `.gitignore` já ignora os principais arquivos gerados.
