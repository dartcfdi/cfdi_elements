import 'package:cfdi_elements/src/nodes/attributes.dart';
import 'package:cfdi_elements/src/nodes/nodes.dart';

abstract class NodeInterface {
  String name();

  Nodes children();

  NodeInterface addChild(NodeInterface node);

  Attributes attributes();

  void addAttributes(Map<String, dynamic> attributes);

  void clear();

  String searchAttribute(List<String> searchPath);

  Nodes searchNodes(List<String> searchPath);

  NodeInterface? searchNode(List<String> searchPath);

  String value();

  void setValue(String value);

  String operator [](Object? name);

  void operator []=(String name, String? value);

  int get length;
}
