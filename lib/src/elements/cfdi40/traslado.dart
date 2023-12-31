import 'package:cfdi_elements/src/elements/common/abstract_element.dart';

class Traslado extends AbstractElement {
  Traslado([
    super.attributes,
    super.children,
  ]);

  @override
  String getElementName() {
    return 'cfdi:Traslado';
  }
}
