import 'package:cfdi_elements/src/elements/common/abstract_element.dart';

class Addenda extends AbstractElement {
  Addenda([
    super.attributes,
    super.children,
  ]);

  @override
  String getElementName() {
    return 'cfdi:Addenda';
  }
}
