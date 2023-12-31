import 'package:cfdi_elements/src/elements/cfdi40/informacion_aduanera.dart';
import 'package:cfdi_elements/src/elements/common/abstract_element.dart';

class Parte extends AbstractElement {
  Parte([
    super.attributes,
    super.children,
  ]);

  @override
  String getElementName() {
    return 'cfdi:Parte';
  }

  InformacionAduanera addInformacionAduanera(Map<String, String> attributes) {
    final subject = InformacionAduanera(attributes);
    addChild(subject);

    return subject;
  }

  void multiInformacionAduanera([
    List<Map<String, String>> elementAttributes = const [],
  ]) {
    for (final attributes in elementAttributes) {
      addInformacionAduanera(attributes);
    }
  }
}
