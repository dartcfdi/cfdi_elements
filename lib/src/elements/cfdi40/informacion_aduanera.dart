import 'package:cfdi_elements/src/elements/common/abstract_element.dart';

class InformacionAduanera extends AbstractElement {
  InformacionAduanera([
    super.attributes,
    super.children,
  ]);

  @override
  String getElementName() {
    return 'cfdi:InformacionAduanera';
  }
}
