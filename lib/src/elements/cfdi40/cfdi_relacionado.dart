import 'package:cfdi_elements/src/elements/common/abstract_element.dart';

class CfdiRelacionado extends AbstractElement {
  CfdiRelacionado([
    super.attributes,
    super.children,
  ]);

  @override
  String getElementName() {
    return 'cfdi:CfdiRelacionado';
  }
}
