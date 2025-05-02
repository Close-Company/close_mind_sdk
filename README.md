# 🧠 CloseMind SDK

**A Dart/Flutter SDK for interacting with the CloseMind AI API.**  
Desenvolvido para facilitar integrações robustas com inteligência artificial no seu aplicativo com poucos passos e total controle.

```

## 🚀 Features

- 🔑 Fácil inicialização com configuração via ambiente.
- 🤖 Acesso estruturado ao endpoint `think`.
- ⚙️ Suporte a múltiplos ambientes: `dev` e `prod`.
- 🛡️ Tratamento customizado de exceções e respostas da API.
- 🧪 Reset da instância para testes automatizados.

```

## 📦 Installation

Adicione o SDK ao seu `pubspec.yaml`:

```
yaml
dependencies:
  close_mind_sdk: ^any # Substitua 'any' pela versão mais recente quando publicada
```

Para desenvolvimento local:

```
yaml
dependencies:
  close_mind_sdk:
    path: /caminho/para/close_mind_sdk
```

Execute:

```
bash
dart pub get
# ou
flutter pub get
```


## ⚙️ Usage

### 1. Importação

```
dart
import 'package:close_mind_sdk/close_mind_sdk.dart';
```


### 2. Inicialização

A SDK deve ser inicializada uma única vez no início da aplicação (ex: em `main()`):

```
dart
void main() async {
  final options = CloseMindOptions(
    apiKey: 'YOUR_API_KEY_HERE',
    environment: CloseMindEnvironment.dev, // ou .prod
    projectId: 'YOUR_PROJECT_ID_HERE',
  );

  try {
    await CloseMind.initialize(options: options);
    print('✅ CloseMind SDK initialized successfully!');
  } on StateError catch (e) {
    print('⚠️ Already initialized: ${e.message}');
  } catch (e) {
    print('❌ Unexpected initialization error: $e');
  }
}
```


### 3. Chamada ao endpoint `think`

Após inicialização bem-sucedida:

```
dart
try {
  final closeMind = CloseMind.instance;

  final result = await closeMind.think(
    context: {'text': 'Exemplo de input'},
    scopes: ['memoria', 'decisao'],
    // input: {'extra': 'dados opcionais'},
    // modelName: 'model-v2',
    // language: 'pt',
  );

  print('🧠 Resultado da IA: $result');

} on StateError {
  print('❌ SDK não foi inicializada.');
} on CloseMindException catch (e) {
  print('🚨 Erro da API: ${e.message}');
  if (e.statusCode != null) print('Status: ${e.statusCode}');
} catch (e) {
  print('⚠️ Erro inesperado: $e');
}
```


## 📘 API Reference

### 🏗️ Classes Principais

| Classe              | Descrição                                                                 |
|---------------------|---------------------------------------------------------------------------|
| `CloseMind`         | Singleton principal do SDK.                                               |
| `CloseMindOptions`  | Configuração de inicialização (`apiKey`, `environment`, `projectId`).     |
| `CloseMindException`| Erros da API encapsulados com `message` e `statusCode`.                   |



### 🔍 Métodos

#### `CloseMind.initialize({required CloseMindOptions options})`
- Inicializa o SDK. Deve ser chamada apenas uma vez.

#### `CloseMind.get instance`
- Retorna a instância da SDK. Lança `StateError` se `initialize` não foi chamada.

#### `CloseMind.resetInstance()`
- Reseta o singleton da SDK. Útil para testes automatizados.

#### `think({...}) → Future<Map<String, dynamic>>`
- Envia um input contextual para a IA.

**Parâmetros:**

| Nome         | Tipo                   | Obrigatório | Descrição                                           |
|--------------|------------------------|-------------|-----------------------------------------------------|
| `context`    | `Map<String, dynamic>` | ✅          | Contexto principal da requisição                    |
| `scopes`     | `List<String>`         | ✅          | Escopos da IA a serem ativados                      |
| `input`      | `Map<String, dynamic>` | ❌          | Dados adicionais                                   |
| `modelName`  | `String`               | ❌          | Modelo específico da IA                             |
| `language`   | `String`               | ❌          | Idioma da resposta (ex: `pt`, `en`)                 |


## 💡 Exemplo Completo

Veja um exemplo funcional em:

```
text
example/lib/main.dart
```


## 🤝 Contributing

Contribuições são bem-vindas!

1. Fork o projeto
2. Crie sua feature branch: `git checkout -b feat/nome-da-feature`
3. Commit suas alterações: `git commit -m 'feat: minha nova feature'`
4. Push para a branch: `git push origin feat/nome-da-feature`
5. Abra um Pull Request


## 📄 License

Este projeto está licenciado sob a [MIT License](LICENSE).


## 🧠 Powered by CloseMind

Feito com 💥 para acelerar decisões baseadas em IA.
