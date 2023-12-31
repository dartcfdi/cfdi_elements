import 'package:cfdi_elements/src/elements/cfdi40/impuestos.dart';

class ConceptoImpuestos extends Impuestos {
  ConceptoImpuestos([
    super.attributes,
    super.children,
  ]);

  @override
  List<String> getChildrenOrder() {
    return [
      'cfdi:Traslados',
      'cfdi:Retenciones',
    ];
  }
}
