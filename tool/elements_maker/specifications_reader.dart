import 'dart:convert';
import 'dart:io';

final class SpecificationsReader {
  final Map<String, dynamic> _data;

  SpecificationsReader(Map<String, dynamic> data) : _data = data;

  static SpecificationsReader fromFile(String specFile) {
    if (!File(specFile).existsSync()) {
      throw FormatException('Specification file "$specFile" does not exists');
    }

    final specContents = File(specFile).readAsStringSync();
    return SpecificationsReader.fromJsonString(specContents);
  }

  static SpecificationsReader fromJsonString(String specContents) {
    try {
      final Map<String, dynamic> data =
          json.decode(specContents) as Map<String, dynamic>;
      return SpecificationsReader(data);
    } catch (e) {
      throw FormatException('Unable to parse the JSON specification', e);
    }
  }

  String keyAsString(String name) {
    if (_data[name] == null) {
      return '';
    }

    if (_data[name] is! String) {
      return '';
    }

    return _data[name] as String;
  }

  Map<String, dynamic> keyAsMap(String name) {
    if (_data[name] == null) {
      return {};
    }

    if (_data[name] is! Map<String, dynamic>) {
      return {};
    }

    return _data[name] as Map<String, dynamic>;
  }
}
