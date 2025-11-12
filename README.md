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

3. Configurar Firebase Analytics
- Baixe o arquivo `google-services.json` do console do Firebase (projeto criado para Android).
- Coloque o arquivo na pasta `android/app/`.

4. Rodar no dispositivo/emulador Android:
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
- BLOC para controle de estados, escolhido pela facilidade de utilizar cache com o HydratedBloc e pela organização e separação da regra de negócios, estados e eventos.
- Datasource que faz fetch do JSON da Pokedex (endereço usado no teste: `https://raw.githubusercontent.com/Biuni/PokemonGo-Pokedex/master/pokedex.json`).
- Testes focados em:
  - Parsing/transformação dos dados recebidos
  - Renderização de widgets importantes (lista e detalhe)
- Linter configurado (arquivo `analysis_options.yaml`) para manter padrão de código.

---

## TODO / Roadmap

- [x] Busca (search) por nome/numero
- [X] Favoritos (marcar Pokémons como favoritos e listar apenas favoritos)
  - Feito: persistência com o Hive e interação na UI.
  - Faltando: listar favoritos e performar a busca da informação de favoritos (está buscando todos os Pokémons novamente quando fecha a tela de detalhe).
- [ ] Cache local (usar `shared_preferences` ou `hive` para armazenar cache de lista e detalhes)
- [ ] Melhor cobertura de testes (unit + widget + integration)
- [ ] Workflow CI (GitHub Actions) para rodar `flutter analyze` e `flutter test`
- [ ] Otimização de imagens (usar `cached_network_image`)
- [ ] Acessibilidade (labels, roles, tamanhos de toque)
- [ ] Temas (light/dark) e preferências do usuário

#### Features divertidas / experimentais
- [ ] Jogo "Quem é esse Pokémon?" — quiz baseado em imagens e respostas múltiplas
  - Implementação sugerida:
    - Tela de jogo que escolhe aleatoriamente um Pokémon e mostra a silhueta (ou imagem desfocada)
    - Quatro alternativas (one correct + 3 distractors)
- [ ] Animações: transições entre lista e detalhe, animação ao favoritar