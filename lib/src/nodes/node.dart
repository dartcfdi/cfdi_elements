import 'package:cfdi_elements/src/nodes/attributes.dart';
import 'package:cfdi_elements/src/nodes/node_interface.dart';
import 'package:cfdi_elements/src/nodes/nodes.dart';
import 'package:cfdi_elements/src/utils/xml_utils.dart';

class Node implements NodeInterface {
  late String _name;

  late Attributes _attributes;

  late Nodes _children;

  late String _value;

  Node(
    String name, [
    Map<String, dynamic> attributes = const {},
    List<NodeInterface> children = const [],
    String value = '',
  ]) {
    if (!isValidXmlName(name)) {
      throw FormatException(
        'Cannot create a node with a invalid xml name: $name',
      );
    }

    _name = name;
    _attributes = Attributes(attributes);
    _children = Nodes(children);
    _value = value;
  }

  @override
  int get length => _children.length;

  @override
  String name() {
    return _name;
  }

  @override
  Nodes children() {
    return _children;
  }

  @override
  NodeInterface addChild(NodeInterface node) {
    _children.add(node);

    return node;
  }

  @override
  Attributes attributes() {
    return _attributes;
  }

  @override
  void addAttributes(Map<String, dynamic> attributes) {
    _attributes.importMap(attributes);
  }

  @override
  void clear() {
    _attributes.clear();
    _children.clear();
  }

  @override
  String value() {
    return _value;
  }

  @override
  void setValue(String value) {
    _value = value;
  }

  @override
  String searchAttribute([List<String> searchPath = const []]) {
    if (searchPath.isEmpty) {
      return '';
    }

    final attribute = searchPath.removeLast();
    final node = searchNode(searchPath);
    if (node == null) {
      return '';
    }

    return node.attributes().get(attribute);
  }

  @override
  NodeInterface? searchNode([List<String> searchPath = const []]) {
    NodeInterface? node = this;
    for (final searchName in searchPath) {
      node = node!.children().firstNodeWithName(searchName);
      if (node == null) {
        break;
      }
    }

    return node;
  }

  @override
  Nodes searchNodes([List<String> searchPath = const []]) {
    final nodes = Nodes();
    final nodeName = searchPath.removeLast();
    final parent = searchNode(searchPath);
    if (parent != null) {
      for (final child in parent.children()) {
        if (child.name() == nodeName) {
          nodes.add(child);
        }
      }
    }

    return nodes;
  }

  @override
  String operator [](Object? name) {
    return attributes()[name];
  }

  @override
  void operator []=(String name, String? value) {
    attributes()[name] = value;
  }

  void unset(String offset) {
    attributes().remove(offset);
  }

  bool exists(String offset) {
    return attributes().exists(offset);
  }
}
