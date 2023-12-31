import 'package:cfdi_elements/src/elements/cfdi40/addenda.dart';
import 'package:cfdi_elements/src/elements/cfdi40/cfdi_relacionados.dart';
import 'package:cfdi_elements/src/elements/cfdi40/complemento.dart';
import 'package:cfdi_elements/src/elements/cfdi40/concepto.dart';
import 'package:cfdi_elements/src/elements/cfdi40/conceptos.dart';
import 'package:cfdi_elements/src/elements/cfdi40/emisor.dart';
import 'package:cfdi_elements/src/elements/cfdi40/impuestos.dart';
import 'package:cfdi_elements/src/elements/cfdi40/informacion_global.dart';
import 'package:cfdi_elements/src/elements/cfdi40/mixins/impuestos_shortcuts.dart';
import 'package:cfdi_elements/src/elements/cfdi40/receptor.dart';
import 'package:cfdi_elements/src/elements/common/abstract_element.dart';
import 'package:cfdi_elements/src/nodes/node_interface.dart';

class Comprobante extends AbstractElement with ImpuestosShortcuts {
  Comprobante([
    super.attributes,
    super.children,
  ]);

  @override
  String getElementName() {
    return 'cfdi:Comprobante';
  }

  @override
  List<String> getChildrenOrder() {
    return [
      'cfdi:InformacionGlobal',
      'cfdi:CfdiRelacionados',
      'cfdi:Emisor',
      'cfdi:Receptor',
      'cfdi:Conceptos',
      'cfdi:Impuestos',
      'cfdi:Complemento',
      'cfdi:Addenda',
    ];
  }

  @override
  Map<String, String> getFixedAttributes() {
    return {
      'xmlns:cfdi': 'http://www.sat.gob.mx/cfd/4',
      'xmlns:xsi': 'http://www.w3.org/2001/XMLSchema-instance',
      'xsi:schemaLocation':
          'http://www.sat.gob.mx/cfd/4 http://www.sat.gob.mx/sitio_internet/cfd/4/cfdv40.xsd',
      'Version': '4.0',
    };
  }

  InformacionGlobal getInformacionGlobal() {
    return helperGetOrAdd(InformacionGlobal());
  }

  InformacionGlobal addInformacionGlobal([
    Map<String, String> attributes = const {},
  ]) {
    final subject = getInformacionGlobal();
    subject.addAttributes(attributes);

    return subject;
  }

  CfdiRelacionados addCfdiRelacionados(Map<String, String> attributes) {
    final subject = CfdiRelacionados(attributes);
    addChild(subject);

    return subject;
  }

  void multiCfdiRelacionados([
    List<Map<String, String>> elementAttributes = const [],
  ]) {
    for (final attributes in elementAttributes) {
      addCfdiRelacionados(attributes);
    }
  }

  Emisor getEmisor() {
    return helperGetOrAdd(Emisor());
  }

  Emisor addEmisor([Map<String, String> attributes = const {}]) {
    final subject = getEmisor();
    subject.addAttributes(attributes);

    return subject;
  }

  Receptor getReceptor() {
    return helperGetOrAdd(Receptor());
  }

  Receptor addReceptor([Map<String, String> attributes = const {}]) {
    final subject = getReceptor();
    subject.addAttributes(attributes);

    return subject;
  }

  Conceptos getConceptos() {
    return helperGetOrAdd(Conceptos());
  }

  Conceptos addConceptos([Map<String, String> attributes = const {}]) {
    final subject = getConceptos();
    subject.addAttributes(attributes);

    return subject;
  }

  @override
  Impuestos getImpuestos() {
    return helperGetOrAdd(Impuestos());
  }

  Impuestos addImpuestos([Map<String, String> attributes = const {}]) {
    final subject = getImpuestos();
    subject.addAttributes(attributes);

    return subject;
  }

  Complemento getComplemento() {
    return helperGetOrAdd(Complemento());
  }

  void addComplemento(NodeInterface node) {
    getComplemento().addChild(node);
  }

  Addenda getAddenda() {
    return helperGetOrAdd(Addenda());
  }

  void addAddenda(NodeInterface node) {
    getAddenda().addChild(node);
  }

  Concepto addConcepto([Map<String, String> attributes = const {}]) {
    return getConceptos().addConcepto(attributes);
  }
}
