import 'package:cfdi_elements/src/elements/common/abstract_element.dart';

class CuentaPredial extends AbstractElement {
  CuentaPredial([
    super.attributes,
    super.children,
  ]);

  @override
  String getElementName() {
    return 'cfdi:CuentaPredial';
  }
}
