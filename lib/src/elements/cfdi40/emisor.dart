import 'package:cfdi_elements/src/elements/common/abstract_element.dart';

class Emisor extends AbstractElement {
  Emisor([
    super.attributes,
    super.children,
  ]);

  @override
  String getElementName() {
    return 'cfdi:Emisor';
  }
}
