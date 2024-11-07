class ServerException implements Exception {
  final String message;

  ServerException({
    required this.message,
  });

  factory ServerException.fromJson(String e) {
    return ServerException(
      message: e,
    );
  }
}

class NoInternetException implements Exception {}

class CacheException implements Exception {
  final String message;

  CacheException({required this.message});

  @override
  String toString() {
    return message;
  }
}

class MultipleOrdersException implements Exception {
  MultipleOrdersException();
}

class BrokerSessions {
  final String? createAt;
  final String? id;
  final String? userAgent;

  BrokerSessions({
    required this.id,
    required this.userAgent,
    required this.createAt,
  });
}
