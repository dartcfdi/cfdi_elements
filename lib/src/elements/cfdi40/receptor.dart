import 'package:cfdi_elements/src/elements/common/abstract_element.dart';

class Receptor extends AbstractElement {
  Receptor([
    super.attributes,
    super.children,
  ]);

  @override
  String getElementName() {
    return 'cfdi:Receptor';
  }
}
