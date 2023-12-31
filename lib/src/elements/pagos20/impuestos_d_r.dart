import 'package:cfdi_elements/src/elements/common/abstract_element.dart';
import 'package:cfdi_elements/src/elements/pagos20/retenciones_d_r.dart';
import 'package:cfdi_elements/src/elements/pagos20/traslados_d_r.dart';

class ImpuestosDR extends AbstractElement {
  ImpuestosDR([
    super.attributes,
    super.children,
  ]);

  @override
  String getElementName() {
    return 'pago20:ImpuestosDR';
  }

  @override
  List<String> getChildrenOrder() {
    return [
      'pago20:RetencionesDR',
      'pago20:TrasladosDR',
    ];
  }

  RetencionesDR getRetencionesDR() {
    return helperGetOrAdd(RetencionesDR());
  }

  RetencionesDR addRetencionesDR([Map<String, String> attributes = const {}]) {
    final subject = getRetencionesDR();
    subject.addAttributes(attributes);

    return subject;
  }

  TrasladosDR getTrasladosDR() {
    return helperGetOrAdd(TrasladosDR());
  }

  TrasladosDR addTrasladosDR([Map<String, String> attributes = const {}]) {
    final subject = getTrasladosDR();
    subject.addAttributes(attributes);

    return subject;
  }
}
