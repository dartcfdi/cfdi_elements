import 'package:cfdi_elements/src/elements/cfdi40/concepto.dart';
import 'package:cfdi_elements/src/elements/common/abstract_element.dart';

class Conceptos extends AbstractElement {
  Conceptos([
    super.attributes,
    super.children,
  ]);

  @override
  String getElementName() {
    return 'cfdi:Conceptos';
  }

  Concepto addConcepto(Map<String, String> attributes) {
    final subject = Concepto(attributes);
    addChild(subject);

    return subject;
  }

  void multiConcepto([List<Map<String, String>> elementAttributes = const []]) {
    for (final attributes in elementAttributes) {
      addConcepto(attributes);
    }
  }
}
