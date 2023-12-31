import 'package:cfdi_elements/src/elements/common/abstract_element.dart';

class Totales extends AbstractElement {
  Totales([
    super.attributes,
    super.children,
  ]);

  @override
  String getElementName() {
    return 'pago20:Totales';
  }
}
