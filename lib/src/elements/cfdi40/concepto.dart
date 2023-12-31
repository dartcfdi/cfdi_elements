import 'package:cfdi_elements/src/elements/cfdi40/a_cuenta_terceros.dart';
import 'package:cfdi_elements/src/elements/cfdi40/complemento_concepto.dart';
import 'package:cfdi_elements/src/elements/cfdi40/concepto_impuestos.dart';
import 'package:cfdi_elements/src/elements/cfdi40/cuenta_predial.dart';
import 'package:cfdi_elements/src/elements/cfdi40/informacion_aduanera.dart';
import 'package:cfdi_elements/src/elements/cfdi40/mixins/impuestos_shortcuts.dart';
import 'package:cfdi_elements/src/elements/cfdi40/parte.dart';
import 'package:cfdi_elements/src/elements/common/abstract_element.dart';
import 'package:cfdi_elements/src/nodes/node_interface.dart';

class Concepto extends AbstractElement with ImpuestosShortcuts {
  Concepto([
    super.attributes,
    super.children,
  ]);

  @override
  String getElementName() {
    return 'cfdi:Concepto';
  }

  @override
  List<String> getChildrenOrder() {
    return [
      'cfdi:Impuestos',
      'cfdi:ACuentaTerceros',
      'cfdi:InformacionAduanera',
      'cfdi:CuentaPredial',
      'cfdi:ComplementoConcepto',
      'cfdi:Parte',
    ];
  }

  @override
  ConceptoImpuestos getImpuestos() {
    return helperGetOrAdd(ConceptoImpuestos());
  }

  ConceptoImpuestos addImpuestos([Map<String, String> attributes = const {}]) {
    final subject = getImpuestos();
    subject.addAttributes(attributes);

    return subject;
  }

  ACuentaTerceros getACuentaTerceros() {
    return helperGetOrAdd(ACuentaTerceros());
  }

  ACuentaTerceros addACuentaTerceros([
    Map<String, String> attributes = const {},
  ]) {
    final subject = getACuentaTerceros();
    subject.addAttributes(attributes);

    return subject;
  }

  InformacionAduanera addInformacionAduanera(Map<String, String> attributes) {
    final subject = InformacionAduanera(attributes);
    addChild(subject);

    return subject;
  }

  void multiInformacionAduanera([
    List<Map<String, String>> elementAttributes = const [],
  ]) {
    for (final attributes in elementAttributes) {
      addInformacionAduanera(attributes);
    }
  }

  CuentaPredial addCuentaPredial(Map<String, String> attributes) {
    final subject = CuentaPredial(attributes);
    addChild(subject);

    return subject;
  }

  void multiCuentaPredial([
    List<Map<String, String>> elementAttributes = const [],
  ]) {
    for (final attributes in elementAttributes) {
      addCuentaPredial(attributes);
    }
  }

  ComplementoConcepto getComplementoConcepto() {
    return helperGetOrAdd(ComplementoConcepto());
  }

  void addComplementoConcepto(NodeInterface child) {
    getComplementoConcepto().addChild(child);
  }

  Parte addParte(Map<String, String> attributes) {
    final subject = Parte(attributes);
    addChild(subject);

    return subject;
  }

  void multiParte([List<Map<String, String>> elementAttributes = const []]) {
    for (final attributes in elementAttributes) {
      addParte(attributes);
    }
  }
}
