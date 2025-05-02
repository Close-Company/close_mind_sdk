/// Support for doing something awesome.
///
/// More dartdocs go here.
library;

export 'src/close_mind_sdk_base.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

enum CloseMindEnvironment { dev, prod }

class CloseMind {
  static CloseMind? _instance;

  final String apiKey;
  final CloseMindEnvironment environment;
  final String projectId;
  final bool isTestInstance;
  late final String baseUrl;

  CloseMind._internal({required this.apiKey, required this.environment, required this.projectId, this.isTestInstance = false}) {
    baseUrl = _resolveBaseUrl(environment);
  }

  /// Cria a instância principal do SDK (singleton)
  static CloseMind instance({required String apiKey, required CloseMindEnvironment environment, required String projectId}) {
    _instance ??= CloseMind._internal(apiKey: apiKey, environment: environment, projectId: projectId);
    return _instance!;
  }

  /// Cria uma instância mockada para testes
  static CloseMind testInstance({String apiKey = 'test-api-key', CloseMindEnvironment environment = CloseMindEnvironment.dev, String projectId = 'test-project'}) {
    _instance = CloseMind._internal(apiKey: apiKey, environment: environment, projectId: projectId, isTestInstance: true);
    return _instance!;
  }

  /// Recupera a instância ativa
  static CloseMind get get {
    if (_instance == null) {
      throw Exception('CloseMind não foi inicializado. Use CloseMind.instance(...) ou CloseMind.testInstance(...) antes.');
    }
    return _instance!;
  }

  /// Reinicia a instância atual
  static void resetInstance() {
    _instance = null;
  }

  String _resolveBaseUrl(CloseMindEnvironment env) {
    if (isTestInstance) return 'https://mock.closemind.local/test';

    switch (env) {
      case CloseMindEnvironment.dev:
        return 'https://dev-api.closemind.ai/process';
      case CloseMindEnvironment.prod:
        return 'https://api.closemind.ai/process';
    }
  }

  Future<Map<String, dynamic>> ai({required String context, required String scope}) async {
    final response = await http.post(Uri.parse(baseUrl), headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $apiKey', 'X-Project-ID': projectId}, body: jsonEncode({'context': context, 'scope': scope}));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Erro ${response.statusCode}: ${response.body}');
    }
  }
}
