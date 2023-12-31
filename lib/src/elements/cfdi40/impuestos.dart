import 'package:cfdi_elements/src/elements/cfdi40/mixins/impuestos_shortcuts.dart';
import 'package:cfdi_elements/src/elements/cfdi40/retenciones.dart';
import 'package:cfdi_elements/src/elements/cfdi40/traslados.dart';
import 'package:cfdi_elements/src/elements/common/abstract_element.dart';

class Impuestos extends AbstractElement with ImpuestosShortcuts {
  Impuestos([
    super.attributes,
    super.children,
  ]);

  @override
  Impuestos getImpuestos() {
    return this;
  }

  @override
  String getElementName() {
    return 'cfdi:Impuestos';
  }

  @override
  List<String> getChildrenOrder() {
    return [
      'cfdi:Retenciones',
      'cfdi:Traslados',
    ];
  }

  Traslados getTraslados() {
    return helperGetOrAdd(Traslados());
  }

  Traslados addTraslados([Map<String, String> attributes = const {}]) {
    final subject = getTraslados();
    subject.addAttributes(attributes);

    return subject;
  }

  Retenciones getRetenciones() {
    return helperGetOrAdd(Retenciones());
  }

  Retenciones addRetenciones([Map<String, String> attributes = const {}]) {
    final subject = getRetenciones();
    subject.addAttributes(attributes);

    return subject;
  }
}
