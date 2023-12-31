import 'package:cfdi_elements/src/elements/common/abstract_element.dart';

class Retencion extends AbstractElement {
  Retencion([
    super.attributes,
    super.children,
  ]);

  @override
  String getElementName() {
    return 'cfdi:Retencion';
  }
}
