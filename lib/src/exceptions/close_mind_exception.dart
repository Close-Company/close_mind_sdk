class CloseMindException implements Exception {
  final String message;
  final int? statusCode;
  final String? body;

  CloseMindException(this.message, {this.statusCode, this.body});

  @override
  String toString() {
    var buffer = StringBuffer('CloseMindException: $message');
    if (statusCode != null) {
      buffer.write(' (Status: $statusCode)');
    }
    if (body != null && body!.isNotEmpty) {
      final bodyPreview = body!.length > 150 ? '${body!.substring(0, 150)}...' : body;
      buffer.write(' Body: $bodyPreview');
    }
    return buffer.toString();
  }
}
