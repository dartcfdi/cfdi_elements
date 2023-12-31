import 'package:cfdi_elements/src/elements/common/abstract_element.dart';
import 'package:cfdi_elements/src/elements/pagos20/traslado_d_r.dart';

class TrasladosDR extends AbstractElement {
  TrasladosDR([
    super.attributes,
    super.children,
  ]);

  @override
  String getElementName() {
    return 'pago20:TrasladosDR';
  }

  TrasladoDR addTrasladoDR(Map<String, String> attributes) {
    final subject = TrasladoDR(attributes);
    addChild(subject);

    return subject;
  }

  void multiTrasladoDR([
    List<Map<String, String>> elementAttributes = const [],
  ]) {
    for (final attributes in elementAttributes) {
      addTrasladoDR(attributes);
    }
  }
}
