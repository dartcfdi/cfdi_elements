import 'package:cfdi_elements/src/elements/common/abstract_element.dart';
import 'package:cfdi_elements/src/elements/pagos20/retenciones_p.dart';
import 'package:cfdi_elements/src/elements/pagos20/traslados_p.dart';

class ImpuestosP extends AbstractElement {
  ImpuestosP([
    super.attributes,
    super.children,
  ]);

  @override
  String getElementName() {
    return 'pago20:ImpuestosP';
  }

  @override
  List<String> getChildrenOrder() {
    return [
      'pago20:RetencionesP',
      'pago20:TrasladosP',
    ];
  }

  RetencionesP getRetencionesP() {
    return helperGetOrAdd(RetencionesP());
  }

  RetencionesP addRetencionesP([Map<String, String> attributes = const {}]) {
    final subject = getRetencionesP();
    subject.addAttributes(attributes);

    return subject;
  }

  TrasladosP getTrasladosP() {
    return helperGetOrAdd(TrasladosP());
  }

  TrasladosP addTrasladosP([Map<String, String> attributes = const {}]) {
    final subject = getTrasladosP();
    subject.addAttributes(attributes);

    return subject;
  }
}
