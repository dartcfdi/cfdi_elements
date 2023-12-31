import 'package:cfdi_elements/src/elements/cfdi40/retencion.dart';
import 'package:cfdi_elements/src/elements/common/abstract_element.dart';

class Retenciones extends AbstractElement {
  Retenciones([
    super.attributes,
    super.children,
  ]);

  @override
  String getElementName() {
    return 'cfdi:Retenciones';
  }

  Retencion addRetencion(Map<String, String> attributes) {
    final subject = Retencion(attributes);
    addChild(subject);

    return subject;
  }

  void multiRetencion([
    List<Map<String, String>> elementAttributes = const [],
  ]) {
    for (final attributes in elementAttributes) {
      addRetencion(attributes);
    }
  }
}
