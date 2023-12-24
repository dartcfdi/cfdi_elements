import 'package:cfdi_elements/src/nodes/node.dart';
import 'package:cfdi_elements/src/nodes/node_interface.dart';
import 'package:xml/xml.dart';

class XmlNodeImporter {
  final Map<String, String> _registeredNamespaces = {};

  NodeInterface import(XmlElement element) {
    final node = Node(element.qualifiedName);
    node.setValue(_extractValue(element));
    if (element.namespacePrefix != null) {
      _registerNamespace(
        node,
        'xmlns:${element.namespacePrefix}',
        element.namespaceUri!,
      );
      _registerNamespace(
        node,
        'xmlns:xsi',
        'http://www.w3.org/2001/XMLSchema-instance',
      );
    }

    for (final attribute in element.attributes) {
      node[attribute.qualifiedName] = attribute.value;
    }

    if (element.attributes
        .where(
          (attribute) =>
              attribute.namespaceUri == 'http://www.w3.org/2000/xmlns/',
        )
        .isNotEmpty) {
      node['xmlns'] =
          element.getAttribute('*', namespace: 'http://www.w3.org/2000/xmlns/');
    }

    for (final childElement in element.children) {
      if (childElement.nodeType != XmlNodeType.ELEMENT) {
        continue;
      }

      final childNode = import(childElement as XmlElement);
      node.children().add(childNode);
    }

    return node;
  }

  void _registerNamespace(Node node, String prefix, String uri) {
    if (_registeredNamespaces.containsKey(prefix)) {
      return;
    }

    _registeredNamespaces[prefix] = uri;
    node[prefix] = uri;
  }

  String _extractValue(XmlElement element) {
    final values = <String>[];
    for (final childElement in element.children) {
      if (childElement.nodeType != XmlNodeType.TEXT) {
        continue;
      }

      values.add(childElement.value!);
    }

    return values.join();
  }
}
