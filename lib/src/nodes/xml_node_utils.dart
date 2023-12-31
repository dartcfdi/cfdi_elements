import 'package:cfdi_elements/src/nodes/node_interface.dart';
import 'package:cfdi_elements/src/nodes/xml_node_exporter.dart';
import 'package:cfdi_elements/src/nodes/xml_node_importer.dart';
import 'package:cfdi_elements/src/utils/xml_utils.dart';
import 'package:xml/xml.dart';

extension NodeToXml on NodeInterface {
  XmlBuilder toXmlBuilder([XmlBuilder? builder]) {
    builder = builder ?? XmlBuilder();

    return XmlNodeExporter().export(this, builder);
  }

  String toXmlString({bool withXmlHeader = false, bool pretty = true}) {
    final builder = XmlBuilder();
    if (withXmlHeader) {
      builder.declaration(encoding: 'UTF-8');
    }

    return toXmlBuilder(builder).buildDocument().toXmlString(pretty: pretty);
  }
}

extension StringToNode on String {
  NodeInterface toNode() {
    return newDocumentContent(this).rootElement.toNode();
  }
}

extension XmlElementToNode on XmlElement {
  NodeInterface toNode() {
    return XmlNodeImporter().import(this);
  }
}
