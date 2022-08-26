abstract class ApiConsumer {
  Future<dynamic> get({required String path, Map<String, dynamic>? query});

  Future<dynamic> post({
    required String path,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
  });

  Future<dynamic> put({
    required String path,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
  });
}
