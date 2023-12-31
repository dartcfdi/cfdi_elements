import 'package:cfdi_elements/src/elements/common/abstract_element.dart';

class RetencionDR extends AbstractElement {
  RetencionDR([
    super.attributes,
    super.children,
  ]);

  @override
  String getElementName() {
    return 'pago20:RetencionDR';
  }
}
