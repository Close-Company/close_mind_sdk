enum CloseMindEnvironment {
  dev, // Desenvolvimento
  prod, // Produção
}

class CloseMindOptions {
  final String apiKey;
  final CloseMindEnvironment environment;
  final String projectId;
  String? baseUrl;

  CloseMindOptions({required this.apiKey, required this.environment, required this.projectId, this.baseUrl});

  // Opcional: Adicione um método copyWith se precisar criar opções modificadas facilmente.
  CloseMindOptions copyWith(String? apiKey, CloseMindEnvironment? environment, String? projectId, String? baseUrl) {
    return CloseMindOptions(apiKey: apiKey ?? this.apiKey, environment: environment ?? this.environment, projectId: projectId ?? this.projectId, baseUrl: baseUrl ?? this.baseUrl);
  }
}
