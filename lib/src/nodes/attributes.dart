import 'dart:collection';

import 'package:cfdi_elements/src/utils/xml_utils.dart';

class Attributes extends MapBase<String, String> {
  final Map<String, String> _map = {};

  Attributes([Map<String, dynamic> attributes = const {}]) {
    importMap(attributes);
  }

  String get(Object? name) {
    final value = _map[name];
    return value ?? '';
  }

  void set(String name, [String? value]) {
    if (value == null) {
      _map.remove(name);
      return;
    }

    if (!isValidXmlName(name)) {
      throw FormatException(
        'Cannot set attribute with an invalid xml name: $name',
      );
    }

    _map[name] = value;
  }

  @override
  String operator [](Object? name) {
    return get(name);
  }

  @override
  void operator []=(String name, String? value) {
    set(name, _castValueToString(name, value));
  }

  @override
  void clear() {
    _map.clear();
  }

  @override
  Iterable<String> get keys => _map.keys;

  @override
  String? remove(Object? name) {
    return _map.remove(name);
  }

  bool exists(String name) {
    return _map.keys.contains(name);
  }

  void importMap(Map<String, dynamic> attributes) {
    if (attributes.keys.isNotEmpty) {
      attributes.forEach((key, value) {
        final fixedValue = _castValueToString(key, value);
        this[key] = fixedValue;
      });
    }
  }

  Map<String, String> exportMap() {
    return _map;
  }

  String? _castValueToString(String key, dynamic value) {
    if (value == null) {
      return null;
    }

    if (value is bool || value is int || value is double || value is String) {
      return '$value';
    }

    if (value is Object && value is! List) {
      return value.toString();
    }

    throw FormatException('Cannot convert value of attribute $key to string');
  }
}
