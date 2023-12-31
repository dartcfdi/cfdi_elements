import 'package:cfdi_elements/src/elements/common/abstract_element.dart';

class ACuentaTerceros extends AbstractElement {
  ACuentaTerceros([
    super.attributes,
    super.children,
  ]);

  @override
  String getElementName() {
    return 'cfdi:ACuentaTerceros';
  }
}
