import 'package:cfdi_elements/src/elements/common/abstract_element.dart';

class RetencionP extends AbstractElement {
  RetencionP([
    super.attributes,
    super.children,
  ]);

  @override
  String getElementName() {
    return 'pago20:RetencionP';
  }
}
