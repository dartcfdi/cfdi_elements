import 'package:cfdi_elements/src/elements/common/abstract_element.dart';
import 'package:cfdi_elements/src/elements/pagos20/retencion_d_r.dart';

class RetencionesDR extends AbstractElement {
  RetencionesDR([
    super.attributes,
    super.children,
  ]);

  @override
  String getElementName() {
    return 'pago20:RetencionesDR';
  }

  RetencionDR addRetencionDR(Map<String, String> attributes) {
    final subject = RetencionDR(attributes);
    addChild(subject);

    return subject;
  }

  void multiRetencionDR([
    List<Map<String, String>> elementAttributes = const [],
  ]) {
    for (final attributes in elementAttributes) {
      addRetencionDR(attributes);
    }
  }
}
