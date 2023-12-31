import 'package:cfdi_elements/src/elements/common/abstract_element.dart';

class Complemento extends AbstractElement {
  Complemento([
    super.attributes,
    super.children,
  ]);

  @override
  String getElementName() {
    return 'cfdi:Complemento';
  }
}
