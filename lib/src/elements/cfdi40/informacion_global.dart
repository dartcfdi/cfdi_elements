import 'package:cfdi_elements/src/elements/common/abstract_element.dart';

class InformacionGlobal extends AbstractElement {
  InformacionGlobal([
    super.attributes,
    super.children,
  ]);

  @override
  String getElementName() {
    return 'cfdi:InformacionGlobal';
  }
}
