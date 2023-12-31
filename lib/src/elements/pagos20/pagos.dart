import 'package:cfdi_elements/src/elements/common/abstract_element.dart';
import 'package:cfdi_elements/src/elements/pagos20/pago.dart';
import 'package:cfdi_elements/src/elements/pagos20/totales.dart';

class Pagos extends AbstractElement {
  Pagos([
    super.attributes,
    super.children,
  ]);

  @override
  String getElementName() {
    return 'pago20:Pagos';
  }

  @override
  List<String> getChildrenOrder() {
    return [
      'pago20:Totales',
      'pago20:Pago',
    ];
  }

  @override
  Map<String, String> getFixedAttributes() {
    return {
      'xmlns:pago20': 'http://www.sat.gob.mx/Pagos20',
      'xsi:schemaLocation':
          'http://www.sat.gob.mx/Pagos20 http://www.sat.gob.mx/sitio_internet/cfd/Pagos/Pagos20.xsd',
      'Version': '2.0',
    };
  }

  Totales getTotales() {
    return helperGetOrAdd(Totales());
  }

  Totales addTotales([Map<String, String> attributes = const {}]) {
    final subject = getTotales();
    subject.addAttributes(attributes);

    return subject;
  }

  Pago addPago(Map<String, String> attributes) {
    final subject = Pago(attributes);
    addChild(subject);

    return subject;
  }

  void multiPago([List<Map<String, String>> elementAttributes = const []]) {
    for (final attributes in elementAttributes) {
      addPago(attributes);
    }
  }
}
