import 'package:cfdi_elements/src/nodes/node_interface.dart';
import 'package:xml/xml.dart';

class XmlNodeExporter {
  XmlBuilder export(NodeInterface node, XmlBuilder builder) {
    _exportRecursive(node, builder);
    return builder;
  }

  void _exportRecursive(NodeInterface node, XmlBuilder builder) {
    builder.element(
      node.name(),
      nest: () {
        for (final entry in node.attributes().entries) {
          builder.attribute(entry.key, entry.value);
        }

        for (final child in node.children()) {
          _exportRecursive(child, builder);
        }

        if (node.value().isNotEmpty) {
          builder.text(node.value());
        }
      },
    );
  }
}
