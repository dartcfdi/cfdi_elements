import 'package:cfdi_elements/src/elements/common/abstract_element.dart';
import 'package:cfdi_elements/src/elements/pagos20/traslado_p.dart';

class TrasladosP extends AbstractElement {
  TrasladosP([
    super.attributes,
    super.children,
  ]);

  @override
  String getElementName() {
    return 'pago20:TrasladosP';
  }

  TrasladoP addTrasladoP(Map<String, String> attributes) {
    final subject = TrasladoP(attributes);
    addChild(subject);

    return subject;
  }

  void multiTrasladoP([
    List<Map<String, String>> elementAttributes = const [],
  ]) {
    for (final attributes in elementAttributes) {
      addTrasladoP(attributes);
    }
  }
}
