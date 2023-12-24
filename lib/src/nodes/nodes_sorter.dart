import 'package:cfdi_elements/src/nodes/node_interface.dart';

typedef NameIndexable = ({
  int index,
  String value,
});

class NodesSorter {
  Map<String, int> _order = {};

  int length;

  NodesSorter([List<String> order = const []]) : length = 0 {
    setOrder(order);
  }

  /// It takes only the unique strings names and sort using the order of appearance
  bool setOrder(List<String> names) {
    final Map<String, int> order = {
      for (final item in parseNames(names)) item.value: item.index,
    };

    if (_compareMaps(_order, order)) {
      return false;
    }

    _order = order;
    length = order.length;

    return true;
  }

  List<String> getOrder() {
    return _order.keys.toList();
  }

  List<NodeInterface> sort(List<NodeInterface> nodes) {
    List<NodeInterface> fixedNodes = nodes;
    if (length > 0) {
      fixedNodes = _stableArraySort(nodes, compareNodesByName);
    }

    return fixedNodes;
  }

  List<NodeInterface> _stableArraySort(
    List<NodeInterface> input,
    int Function(NodeInterface, NodeInterface) callable,
  ) {
    final list = input.indexed.map((e) => (item: e.$2, index: e.$1)).toList();

    list.sort((a, b) {
      int value = callable(a.item, b.item);
      if (value == 0) {
        value = (a.index - b.index).sign;
      }

      return value;
    });

    return list.map((e) => e.item).toList();
  }

  int compareNodesByName(NodeInterface a, NodeInterface b) {
    final aNumber = valueByName(a.name());
    final bNumber = valueByName(b.name());

    return (aNumber - bNumber).sign;
  }

  int valueByName(String name) {
    final getOrder = _order[name];

    return getOrder ?? length;
  }

  List<NameIndexable> parseNames(List<dynamic> names) {
    final List<String> stringNames = names
        .whereType<String>()
        .where(
          (name) => name != '0' && name != '',
        )
        .toSet()
        .toList();

    return stringNames.indexed.map((entry) {
      final idx = entry.$1;
      final value = entry.$2;

      return (
        index: idx,
        value: value,
      );
    }).toList();
  }

  bool _compareMaps(Map<dynamic, dynamic> a, Map<dynamic, dynamic> b) {
    if (a.length != b.length) {
      return false;
    }

    for (final entry in a.entries) {
      final testValue = b[entry.key];
      if (testValue != entry.value ||
          (testValue == null && !b.containsKey(entry.key))) {
        return false;
      }
    }

    return true;
  }
}
