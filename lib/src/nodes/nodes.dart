import 'dart:collection';

import 'package:cfdi_elements/src/nodes/node_interface.dart';
import 'package:cfdi_elements/src/nodes/nodes_sorter.dart';

class Nodes extends ListBase<NodeInterface> {
  List<NodeInterface> _nodes = [];
  late NodesSorter _sorter;

  Nodes([List<NodeInterface> nodes = const []]) {
    _sorter = NodesSorter();
    importFromList(nodes);
  }

  @override
  int get length => _nodes.length;

  @override
  set length(int newLength) {
    _nodes.length = newLength;
  }

  @override
  NodeInterface operator [](int index) {
    return _nodes[index];
  }

  @override
  void operator []=(int index, NodeInterface value) {
    _nodes[index] = value;
  }

  @override
  void add(NodeInterface value) {
    bool somethingChange = false;
    if (!contains(value)) {
      _nodes.add(value);
      somethingChange = true;
    }

    if (somethingChange) {
      order();
    }
  }

  @override
  void addAll(Iterable<NodeInterface> nodes) {
    bool somethingChange = false;
    for (final node in nodes) {
      if (!contains(node)) {
        _nodes.add(node);
        somethingChange = true;
      }
    }

    if (somethingChange) {
      order();
    }
  }

  void order() {
    _nodes = _sorter.sort(toList());
  }

  void setOrder(List<String> names) {
    if (_sorter.setOrder(names)) {
      order();
    }
  }

  List<String> getOrder() {
    return _sorter.getOrder();
  }

  @override
  bool remove(Object? node) {
    return _nodes.remove(node);
  }

  @override
  void clear() {
    _nodes.clear();
  }

  bool exists(NodeInterface node) {
    return _nodes.contains(node);
  }

  NodeInterface get(int position) {
    return _nodes.elementAt(position);
  }

  NodeInterface? firstNodeWithName(String nodeName) {
    return _nodes.cast<NodeInterface?>().firstWhere(
          (node) => node!.name() == nodeName,
          orElse: () => null,
        );
  }

  Nodes getNodesByName(String nodeName) {
    final nodes = Nodes();
    for (final node in _nodes) {
      if (node.name() == nodeName) {
        nodes.add(node);
      }
    }

    return nodes;
  }

  void importFromList(List<NodeInterface> nodes) {
    addAll(nodes);
  }
}
