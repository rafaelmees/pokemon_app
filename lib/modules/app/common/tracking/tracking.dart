import 'dart:convert';
import 'dart:developer' as developer;

class Tracking {
  static Future<void> event({
    required String name,
    Map<String, dynamic>? parameters,
  }) async {
    developer.log(
      '$name${parameters != null ? ' | ${jsonEncode(parameters)}' : ''}',
      name: 'LogEvent',
    );
  }

  static void error(
    String message, {
    required Object? error,
    String? method,
    required String module,
    StackTrace? stackTrace,
  }) {
    developer.log(
      message,
      name: '$module${method != null ? '.$method' : ''} | ${DateTime.now().toIso8601String()}',
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void log(
    String message, {
    String? method,
    required String module,
    Map<String, dynamic>? parameters,
  }) {
    developer.log(
      '$message${parameters != null ? ' | ${jsonEncode(parameters)}' : ''}',
      name: '$module${method != null ? '.$method' : ''} | ${DateTime.now().toIso8601String()}',
    );
  }
}

Map<String, dynamic>? _convertMappedBoolToString(Map<String, dynamic>? input) {
  if (input != null) {
    return input.map((String key, dynamic value) {
      if (value is bool) {
        return MapEntry<String, dynamic>(key, value ? 'true' : 'false');
      }
      if (value is Map) {
        return MapEntry<String, dynamic>(key, _convertMappedBoolToString(value as Map<String, dynamic>));
      }
      if (value is List) {
        return MapEntry<String, dynamic>(key, _convertListedBoolToString(value));
      }
      return MapEntry<String, dynamic>(key, value);
    });
  }
  return input;
}

List<dynamic>? _convertListedBoolToString(List<dynamic>? input) {
  if (input != null) {
    return input.map((dynamic value) {
      if (value is bool) {
        return value ? 'true' : 'false';
      }
      if (value is Map) {
        return _convertMappedBoolToString(value as Map<String, dynamic>);
      }
      if (value is List) {
        return _convertListedBoolToString(value);
      }
      return value;
    }).toList();
  }
  return input;
}

Map<String, dynamic>? _convertMappedNullToString(Map<String, dynamic>? input) {
  if (input != null) {
    return input.map((String key, dynamic value) {
      if (value == null) {
        return MapEntry<String, dynamic>(key, 'null');
      }
      if (value is Map) {
        return MapEntry<String, dynamic>(key, _convertMappedNullToString(value as Map<String, dynamic>));
      }
      if (value is List) {
        return MapEntry<String, dynamic>(key, _convertListedNullToString(value));
      }
      return MapEntry<String, dynamic>(key, value);
    });
  }
  return input;
}

List<dynamic>? _convertListedNullToString(List<dynamic>? input) {
  if (input != null) {
    return input.map((dynamic value) {
      if (value == null) {
        return 'null';
      }
      if (value is Map) {
        return _convertMappedNullToString(value as Map<String, dynamic>);
      }
      if (value is List) {
        return _convertListedNullToString(value);
      }
      return value;
    }).toList();
  }
  return input;
}
