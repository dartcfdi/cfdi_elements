import 'package:cfdi_elements/src/elements/common/abstract_element.dart';
import 'package:cfdi_elements/src/elements/pagos20/retencion_p.dart';

class RetencionesP extends AbstractElement {
  RetencionesP([
    super.attributes,
    super.children,
  ]);

  @override
  String getElementName() {
    return 'pago20:RetencionesP';
  }

  RetencionP addRetencionP(Map<String, String> attributes) {
    final subject = RetencionP(attributes);
    addChild(subject);

    return subject;
  }

  void multiRetencionP([
    List<Map<String, String>> elementAttributes = const [],
  ]) {
    for (final attributes in elementAttributes) {
      addRetencionP(attributes);
    }
  }
}
