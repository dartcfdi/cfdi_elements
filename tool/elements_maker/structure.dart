import 'dart:collection';

final class Structure with IterableMixin<Structure> {
  final String _name;
  final bool _multiple;
  final List<Structure> _children;

  Structure(String name, bool multiple, [List<Structure> children = const []])
      : _name = name,
        _multiple = multiple,
        _children = children;

  // ignore: prefer_constructors_over_static_methods
  static Structure makeFromMap(String name, Map<String, dynamic> data) {
    bool multiple = false;
    if (data.containsKey('multiple') && data['multiple'] is bool) {
      multiple = data['multiple'] as bool;
    }

    final children = <Structure>[];
    for (final entry in data.entries) {
      if (entry.value is Map<String, dynamic>) {
        children.add(
          Structure.makeFromMap(entry.key, entry.value as Map<String, dynamic>),
        );
      }
    }

    return Structure(name, multiple, children);
  }

  @override
  int get length => _children.length;

  String getName() {
    return _name;
  }

  bool isMultiple() {
    return _multiple;
  }

  List<Structure> getChildren() {
    return _children;
  }

  List<String> getChildrenNames(String prefix) {
    return _children
        .map((structure) => '$prefix${structure.getName()}')
        .toSet()
        .toList();
  }

  @override
  Iterator<Structure> get iterator => _children.iterator;
}
