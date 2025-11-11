# Pokémon App - Desafio Técnico (Flutter)

Aplicativo de exemplo em Flutter que consome uma Pokedex JSON e exibe:
- Lista de Pokémons
- Tela de detalhe de cada Pokémon

> Observação: este projeto foi desenvolvido e testado com Flutter 3.35.7. Hoje (2025-11-11) está configurado para rodar somente em Android.

---

## Status
- Flutter: 3.35.7 (última usada)
- Plataformas suportadas: Android (somente)
- Funcionalidades implementadas:
  - Listagem de Pokémons (fetch da API / JSON)
  - Tela de detalhe do Pokémon
  - Datasource para obter dados da web
  - Tests: testes para datasource e alguns widget tests

---

## Requisitos (pré-requisitos)
- Flutter 3.35.7
- Android SDK (com dispositivo/emulador Android configurado)
- Git

Verifique sua versão do Flutter:
```bash
flutter --version
# deve retornar algo compatível com 3.35.7
```

---

## Como executar (Android)
1. Clone o repositório:
```bash
git clone https://github.com/rafaelmees/pokemon_app.git
cd pokemon_app
```

2. Obtenha dependências:
```bash
flutter pub get
```

3. Rodar no dispositivo/emulador Android:
```bash
flutter run
```
ou escolha um dispositivo específico:
```bash
flutter run -d <device-id>
```

Observação: o projeto foi desenvolvido e testado apenas no Android. Caso ocorra algum erro ao abrir no iOS ou web, provavelmente precisará de ajustes (entitlements, pods, etc).

---

## Testes
Para executar a suíte de testes (unit + widget tests):
```bash
flutter test
```

Rodar análise estática:
```bash
flutter analyze
```

---

## Arquitetura e decisões técnicas
- Adotado o Clean Architecture para separação de camadas e responsabilidades.
- Datasource que faz fetch do JSON da Pokedex (endereço usado no teste: `https://raw.githubusercontent.com/Biuni/PokemonGo-Pokedex/master/pokedex.json`).
- Testes focados em:
  - Parsing/transformação dos dados recebidos
  - Renderização de widgets importantes (lista e detalhe)
- Linter configurado (arquivo `analysis_options.yaml`) para manter padrão de código.
