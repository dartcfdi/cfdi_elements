import 'package:cfdi_elements/src/elements/common/abstract_element.dart';
import 'package:cfdi_elements/src/elements/pagos20/docto_relacionado.dart';
import 'package:cfdi_elements/src/elements/pagos20/impuestos_p.dart';

class Pago extends AbstractElement {
  Pago([
    super.attributes,
    super.children,
  ]);

  @override
  String getElementName() {
    return 'pago20:Pago';
  }

  @override
  List<String> getChildrenOrder() {
    return [
      'pago20:DoctoRelacionado',
      'pago20:ImpuestosP',
    ];
  }

  DoctoRelacionado addDoctoRelacionado(Map<String, String> attributes) {
    final subject = DoctoRelacionado(attributes);
    addChild(subject);

    return subject;
  }

  void multiDoctoRelacionado([
    List<Map<String, String>> elementAttributes = const [],
  ]) {
    for (final attributes in elementAttributes) {
      addDoctoRelacionado(attributes);
    }
  }

  ImpuestosP getImpuestosP() {
    return helperGetOrAdd(ImpuestosP());
  }

  ImpuestosP addImpuestosP([Map<String, String> attributes = const {}]) {
    final subject = getImpuestosP();
    subject.addAttributes(attributes);

    return subject;
  }
}
