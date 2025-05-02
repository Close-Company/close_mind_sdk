import 'package:close_mind_sdk/close_mind_sdk.dart';

void main() async {
  final brain = CloseMind.instance(apiKey: 'xxx', environment: CloseMindEnvironment.prod, projectId: 'meu-app');

  final response = await brain.ai(context: 'context', scope: 'scope');
  print(response);
}
