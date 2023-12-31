final class Dictionary {
  final Map<String, String> _values;

  Dictionary(Map<String, String> values) : _values = values;

  String get(String key) {
    return _values[key] ?? '';
  }

  Dictionary withs(String key, String value) {
    return Dictionary({
      ..._values,
      ...{key: value},
    });
  }

  Map<String, String> getValues() {
    return _values;
  }

  String interpolate(String subject) {
    String result = subject;
    _values.forEach((key, value) {
      result = result.replaceAll(key, value);
    });

    return result;
  }
}
