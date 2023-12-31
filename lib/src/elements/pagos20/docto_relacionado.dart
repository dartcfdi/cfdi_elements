import 'package:cfdi_elements/src/elements/common/abstract_element.dart';
import 'package:cfdi_elements/src/elements/pagos20/impuestos_d_r.dart';

class DoctoRelacionado extends AbstractElement {
  DoctoRelacionado([
    super.attributes,
    super.children,
  ]);

  @override
  String getElementName() {
    return 'pago20:DoctoRelacionado';
  }

  ImpuestosDR getImpuestosDR() {
    return helperGetOrAdd(ImpuestosDR());
  }

  ImpuestosDR addImpuestosDR([Map<String, String> attributes = const {}]) {
    final subject = getImpuestosDR();
    subject.addAttributes(attributes);

    return subject;
  }
}
