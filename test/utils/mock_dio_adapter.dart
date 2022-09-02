import 'dart:typed_data';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

/// USE FOR UNIT TESTING ONLY
///
/// Mocking Dio HttpClientAdapter
///
/// References:
///   https://github.com/flutterchina/dio/blob/master/dio/test/mock_adapter.dart
///
/// Usage:
///   Dio dio = Dio();
///   dio.httpClientAdapter = MockDioAdapter.success(jsonString)
///
///   dio.httpClientAdapter = MockDioAdapter.fail()
///
class MockDioAdapter extends HttpClientAdapter {
  final String _json;
  final int _code;
  final _adapter = DefaultHttpClientAdapter();

  /// Mocking success response with http status code 200
  MockDioAdapter.success(String json)
      : _json = json,
        _code = 200;

  /// Mocking fail response with http status code greater than or equal 400.
  /// The default of http status code is 400.
  MockDioAdapter.fail({code = 400, json = ''})
      : assert(code >= 400),
        _json = json,
        _code = code;

  @override
  void close({bool force = false}) {
    _adapter.close(force: force);
  }

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future? cancelFuture,
  ) async {
    return ResponseBody.fromString(
      _json,
      _code,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }
}
