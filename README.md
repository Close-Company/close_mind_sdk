# 🧠 CloseMind SDK for Dart

Conecte seu aplicativo à CloseMind — a inteligência centralizada de processamento contextual. Com este SDK, você pode enviar requisições com escopos e contextos definidos para serem processadas pela IA da plataforma.

---

## 🚀 Instalação

Adicione ao seu `pubspec.yaml`:

```yaml
dependencies:
  close_mind: ^1.0.0
```

🧬 Inicialização
Antes de usar o SDK, inicialize a instância com sua apiKey, o environment e o projectId:
import 'package:close_mind/close_mind.dart';

void main() {
  CloseMind.instance(
    apiKey: 'sua-api-key',
    environment: CloseMindEnvironment.prod, // ou .dev
    projectId: 'seu-project-id',
  );
}

🧠 Enviar uma requisição

final result = await CloseMind.get.ai(
  context: 'Usuário perguntou como ganhar pontos',
  scope: 'gamificacao',
);

print(result);

🌍 Ambientes disponíveis

CloseMindEnvironment.dev     // https://dev-api.closemind.ai/process
CloseMindEnvironment.prod    // https://api.closemind.ai/process

♻️ Resetar instância
Se precisar reinicializar (ex: logout, troca de projeto):
CloseMind.resetInstance();

💡 Sobre a CloseMind
CloseMind é um cérebro de execução de comandos e decisões que centraliza o raciocínio contextual de múltiplas aplicações. Cada requisição carrega um escopo e contexto, e a CloseMind responde com decisões, instruções ou dados processados.





