import 'dart:convert';

import 'package:close_mind_sdk/src/close_mind_options.dart';
import 'package:close_mind_sdk/src/exceptions/close_mind_exception.dart';
import 'package:http/http.dart' as http;

class CloseMind {
  static CloseMind? _instance;

  final String apiKey;
  final CloseMindEnvironment environment;
  final String projectId;
  late final String baseUrl; // Inicializado no construtor privado

  CloseMind._internal({required this.apiKey, required this.environment, required this.projectId, required this.baseUrl});

  static Future<void> init({required CloseMindOptions options}) async {
    if (_instance != null) {
      throw StateError('CloseMind SDK já foi inicializado.');
    }

    final resolvedBaseUrl = options.baseUrl ?? _resolveBaseUrl(options.environment);

    _instance = CloseMind._internal(
      apiKey: options.apiKey,
      environment: options.environment,
      projectId: options.projectId,
      baseUrl: resolvedBaseUrl, // Passa a URL resolvida
    );
  }

  static CloseMind get instance {
    if (_instance == null) {
      throw StateError('CloseMind SDK não foi inicializado. Chame CloseMind.initialize(...) antes de acessar a instância.');
    }
    return _instance!; // O '!' afirma que não é nulo neste ponto
  }

  static String _resolveBaseUrl(CloseMindEnvironment env) {
    switch (env) {
      case CloseMindEnvironment.dev:
        return 'https://dev-api.closemind.ai:3000/process';
      case CloseMindEnvironment.prod:
        return 'https://api.closemind.ai:3000/process';
    }
  }

  static void resetInstance() {
    _instance = null;
  }

  Future<Map<String, dynamic>> think({required Map<String, dynamic> context, required List<String> scopes, Map<String, dynamic>? input, String? modelName, String? language}) async {
    final url = Uri.parse(baseUrl); // Usa a baseUrl da instância
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey', // Usa a apiKey da instância
      'X-Project-ID': projectId, // Usa o projectId da instância
    };
    final body = jsonEncode({'context': context, 'scopes': scopes, 'input': input, 'modelName': modelName, 'language': language});

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonDecode(response.body);
      } else {
        return {'return': CloseMindResponses.fail.name};
      }
    } catch (e) {
      if (e is CloseMindException) {
        return {'return': CloseMindResponses.error.name};
      }
      return {'return': CloseMindResponses.error.name};
    }
  }
}

enum CloseMindResponses { success, error, fail }
