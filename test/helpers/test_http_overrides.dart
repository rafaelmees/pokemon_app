import 'dart:async';
import 'dart:convert';
import 'dart:io';

class TestHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return _FakeHttpClient();
  }
}

class _FakeHttpClient implements HttpClient {
  @override
  Future<HttpClientRequest> getUrl(Uri url) async => _FakeHttpClientRequest();
  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeHttpClientRequest implements HttpClientRequest {
  final List<int> _buffer = <int>[];
  @override
  Encoding get encoding => utf8;
  @override
  set encoding(Encoding? _) {}
  @override
  void add(List<int> data) => _buffer.addAll(data);

  @override
  Future<HttpClientResponse> close() async {
    return _FakeHttpClientResponse(_transparent1x1Png);
  }

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeHttpClientResponse extends Stream<List<int>> implements HttpClientResponse {
  final List<int> _bytes;
  _FakeHttpClientResponse(this._bytes);

  @override
  int get statusCode => 200;

  @override
  HttpHeaders get headers => _FakeHttpHeaders();

  @override
  StreamSubscription<List<int>> listen(void Function(List<int>)? onData,
      {Function? onError, void Function()? onDone, bool? cancelOnError}) {
    final StreamController<List<int>> controller = StreamController<List<int>>();
    controller.add(_bytes);
    controller.close();
    return controller.stream.listen(onData, onError: onError, onDone: onDone);
  }

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeHttpHeaders implements HttpHeaders {
  @override
  void noFolding(String name) {}
  @override
  void add(String name, Object value, {bool preserveHeaderCase = false}) {}
  @override
  void clear() {}
  @override
  void forEach(void Function(String name, List<String> values) action) {}
  @override
  List<String>? operator [](String name) => <String>[];
  @override
  void set(String name, Object value, {bool preserveHeaderCase = false}) {}
  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

final List<int> _transparent1x1Png = <int>[
  0x89,0x50,0x4E,0x47,0x0D,0x0A,0x1A,0x0A,0x00,0x00,0x00,0x0D,
  0x49,0x48,0x44,0x52,0x00,0x00,0x00,0x01,0x00,0x00,0x00,0x01,
  0x08,0x06,0x00,0x00,0x00,0x1F,0x15,0xC4,0x89,0x00,0x00,0x00,
  0x0A,0x49,0x44,0x41,0x54,0x78,0x9C,0x63,0x00,0x01,0x00,0x00,
  0x05,0x00,0x01,0x0D,0x0A,0x2D,0xB4,0x00,0x00,0x00,0x00,0x49,
  0x45,0x4E,0x44,0xAE,0x42,0x60,0x82
];
