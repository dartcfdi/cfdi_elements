import 'package:cfdi_elements/src/elements/cfdi40/traslado.dart';
import 'package:cfdi_elements/src/elements/common/abstract_element.dart';

class Traslados extends AbstractElement {
  Traslados([
    super.attributes,
    super.children,
  ]);

  @override
  String getElementName() {
    return 'cfdi:Traslados';
  }

  Traslado addTraslado(Map<String, String> attributes) {
    final subject = Traslado(attributes);
    addChild(subject);

    return subject;
  }

  void multiTraslado([List<Map<String, String>> elementAttributes = const []]) {
    for (final attributes in elementAttributes) {
      addTraslado(attributes);
    }
  }
}
