// example/lib/main.dart
import 'package:close_mind_sdk/src/close-mind-sdk.dart';

// Make sure you have added http to the dependencies section
// of the pubspec.yaml file in YOUR EXAMPLE PROJECT (the one in the 'example' folder):
// dependencies:
//   close_mind_sdk:
//     path: ../ # Or the version of your package, if published
//   http: ^1.1.0 # Use the latest compatible version

void main() async {
  // 1. Define the configuration options for the SDK.
  // REPLACE THE VALUES BELOW with your REAL or TEST credentials.
  // In a real application, avoid putting sensitive credentials directly in source code.
  // Use environment variables, build configurations, or secure storage.
  final options = CloseMindOptions(
    apiKey: 'YOUR_API_KEY_HERE', // <<< REPLACE THIS KEY
    environment: CloseMindEnvironment.dev, // Choose .dev or .prod
    projectId: 'YOUR_PROJECT_ID_HERE', // <<< REPLACE THIS ID
  );

  try {
    // 2. Initialize the SDK a single time at the start of your application.
    // This call configures the SDK. It's typically done in 'main()'
    // or an initial setup function of your app.
    print('Attempting to initialize CloseMind SDK...');
    await CloseMind.initialize(options: options);
    print('CloseMind SDK initialized successfully!');

    // 3. Now you can get the instance of the SDK from anywhere in your code.
    // Use the static 'instance' getter.
    final closeMind = CloseMind.instance;
    print('CloseMind SDK instance obtained.');

    // 4. Use the API methods through the obtained instance.
    // The 'think' method requires a Map for context and a List<String> for scopes,
    // and accepts optional input, modelName, and language parameters.
    print('Calling the think API method...');
    try {
      final result = await closeMind.think(
        // 'context' is now a Map
        context: {'text': 'Analyze the sentiment of the phrase: "Adorei o novo filme, foi incrível!"'},
        // 'scopes' is now a List of Strings
        scopes: ['sentiment', 'keywords'], // Example scopes
        // Optional parameters:
        // input: {'user_input': 'More data'},
        // modelName: 'gpt-4',
        // language: 'en',
      );

      print('\n--- Think API Result ---');
      print('Response Received:');
      // The result is a Map<String, dynamic>
      print(result);
      print('------------------------\n');
    } on CloseMindException catch (e) {
      // Catch and handle specific exceptions from your CloseMind SDK (like HTTP API errors)
      print('--- CloseMind SDK Specific Error ---');
      print('Message: ${e.message}');
      if (e.statusCode != null) {
        print('HTTP Status Code: ${e.statusCode}');
      }
      if (e.body != null) {
        // Be cautious printing potentially large or sensitive body content in production
        print('Error Response Body: ${e.body}');
      }
      print('-------------------------------------\n');
    } catch (e) {
      // Catch any other errors that might occur (e.g., network issues)
      print('--- An Unexpected Error Occurred During Think API Call ---');
      print('Error: $e');
      print('---------------------------------------------------------\n');
    }

    // Example of how to access the instance again later in another function/file:
    // final anotherInstance = CloseMind.instance; // This works after initialization

    // Example of how resetInstance would be used (typically ONLY in unit tests):
    // print('Resetting the SDK instance (primarily for use in testing)...');
    // CloseMind.resetInstance();
    // try {
    //   // Accessing the instance after reset will throw an error
    //   final instanceAfterReset = CloseMind.instance;
    // } on StateError catch (e) {
    //   print('✅ Success: Accessing instance after reset throws StateError: ${e.message}');
    // }
  } on StateError catch (e) {
    // Catch the error if 'initialize' is called more than once.
    print('--- Initialization Error (StateError) ---');
    print('Message: ${e.message}');
    print('This error typically indicates that CloseMind.initialize() was called twice.');
    print('---------------------------------------\n');
  } catch (e) {
    // Catch any other errors that might occur during the initialization process.
    print('--- An Unexpected Error Occurred During Initialization ---');
    print('Error: $e');
    print('-----------------------------------------------------\n');
  }
}
