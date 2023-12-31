import 'package:cfdi_elements/src/elements/cfdi40/impuestos.dart';
import 'package:cfdi_elements/src/elements/cfdi40/retencion.dart';
import 'package:cfdi_elements/src/elements/cfdi40/traslado.dart';

abstract mixin class ImpuestosShortcuts {
  Impuestos getImpuestos();

  Traslado addTraslado(Map<String, String> attributes) {
    return getImpuestos().getTraslados().addTraslado(attributes);
  }

  void multiTraslado([
    List<Map<String, String>> elementAttributes = const [],
  ]) {
    getImpuestos().getTraslados().multiTraslado(elementAttributes);
  }

  Retencion addRetencion(Map<String, String> attributes) {
    return getImpuestos().getRetenciones().addRetencion(attributes);
  }

  void multiRetencion([
    List<Map<String, String>> elementAttributes = const [],
  ]) {
    getImpuestos().getRetenciones().multiRetencion(elementAttributes);
  }
}
