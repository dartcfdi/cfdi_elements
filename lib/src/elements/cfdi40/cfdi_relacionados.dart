import 'package:cfdi_elements/src/elements/cfdi40/cfdi_relacionado.dart';
import 'package:cfdi_elements/src/elements/common/abstract_element.dart';

class CfdiRelacionados extends AbstractElement {
  CfdiRelacionados([
    super.attributes,
    super.children,
  ]);

  @override
  String getElementName() {
    return 'cfdi:CfdiRelacionados';
  }

  CfdiRelacionado addCfdiRelacionado(Map<String, String> attributes) {
    final subject = CfdiRelacionado(attributes);
    addChild(subject);

    return subject;
  }

  void multiCfdiRelacionado([
    List<Map<String, String>> elementAttributes = const [],
  ]) {
    for (final attributes in elementAttributes) {
      addCfdiRelacionado(attributes);
    }
  }
}
