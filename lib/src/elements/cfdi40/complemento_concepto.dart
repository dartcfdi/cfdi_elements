import 'package:cfdi_elements/src/elements/common/abstract_element.dart';

class ComplementoConcepto extends AbstractElement {
  ComplementoConcepto([
    super.attributes,
    super.children,
  ]);

  @override
  String getElementName() {
    return 'cfdi:ComplementoConcepto';
  }
}
