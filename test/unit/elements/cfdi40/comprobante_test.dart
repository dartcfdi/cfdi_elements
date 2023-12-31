import 'package:cfdi_elements/src/elements/cfdi40/a_cuenta_terceros.dart';
import 'package:cfdi_elements/src/elements/cfdi40/addenda.dart';
import 'package:cfdi_elements/src/elements/cfdi40/cfdi_relacionado.dart';
import 'package:cfdi_elements/src/elements/cfdi40/cfdi_relacionados.dart';
import 'package:cfdi_elements/src/elements/cfdi40/complemento.dart';
import 'package:cfdi_elements/src/elements/cfdi40/complemento_concepto.dart';
import 'package:cfdi_elements/src/elements/cfdi40/comprobante.dart';
import 'package:cfdi_elements/src/elements/cfdi40/concepto.dart';
import 'package:cfdi_elements/src/elements/cfdi40/concepto_impuestos.dart';
import 'package:cfdi_elements/src/elements/cfdi40/conceptos.dart';
import 'package:cfdi_elements/src/elements/cfdi40/cuenta_predial.dart';
import 'package:cfdi_elements/src/elements/cfdi40/emisor.dart';
import 'package:cfdi_elements/src/elements/cfdi40/impuestos.dart';
import 'package:cfdi_elements/src/elements/cfdi40/informacion_aduanera.dart';
import 'package:cfdi_elements/src/elements/cfdi40/informacion_global.dart';
import 'package:cfdi_elements/src/elements/cfdi40/parte.dart';
import 'package:cfdi_elements/src/elements/cfdi40/receptor.dart';
import 'package:cfdi_elements/src/elements/cfdi40/retencion.dart';
import 'package:cfdi_elements/src/elements/cfdi40/retenciones.dart';
import 'package:cfdi_elements/src/elements/cfdi40/traslado.dart';
import 'package:cfdi_elements/src/elements/cfdi40/traslados.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../elements_matchers.dart';

void main() {
  group('Cfdi40', () {
    test('Comprobante', () {
      final element = Comprobante();

      expect(element, elementHasName('cfdi:Comprobante'));
      expect(
        element,
        elementHasOrder([
          'cfdi:InformacionGlobal',
          'cfdi:CfdiRelacionados',
          'cfdi:Emisor',
          'cfdi:Receptor',
          'cfdi:Conceptos',
          'cfdi:Impuestos',
          'cfdi:Complemento',
          'cfdi:Addenda',
        ]),
      );
      expect(
        element,
        elementHasFixedAttributes({
          'xmlns:cfdi': 'http://www.sat.gob.mx/cfd/4',
          'xmlns:xsi': 'http://www.w3.org/2001/XMLSchema-instance',
          'xsi:schemaLocation':
              'http://www.sat.gob.mx/cfd/4 http://www.sat.gob.mx/sitio_internet/cfd/4/cfdv40.xsd',
          'Version': '4.0',
        }),
      );
      expect(element, elementHasChildSingle(InformacionGlobal));
      expect(element, elementHasChildMultiple(CfdiRelacionados));
      expect(element, elementHasChildSingle(Emisor));
      expect(element, elementHasChildSingle(Receptor));
      expect(element, elementHasChildSingle(Conceptos));
      expect(element, elementHasChildSingle(Impuestos));
      expect(element, elementHasChildSingleAddChild(Complemento));
      expect(element, elementHasChildSingleAddChild(Addenda));
    });

    test('Informacion Global', () {
      final element = InformacionGlobal();
      expect(element, elementHasName('cfdi:InformacionGlobal'));
    });

    test('CfdiRelacionados', () {
      final element = CfdiRelacionados();
      expect(element, elementHasName('cfdi:CfdiRelacionados'));
      expect(element, elementHasChildMultiple(CfdiRelacionado));
    });

    test('CfdiRelacionado', () {
      final element = CfdiRelacionado();
      expect(element, elementHasName('cfdi:CfdiRelacionado'));
    });

    test('Emisor', () {
      final element = Emisor();
      expect(element, elementHasName('cfdi:Emisor'));
    });

    test('Receptor', () {
      final element = Receptor();
      expect(element, elementHasName('cfdi:Receptor'));
    });

    test('Conceptos', () {
      final element = Conceptos();
      expect(element, elementHasName('cfdi:Conceptos'));
      expect(element, elementHasChildMultiple(Concepto));
    });

    test('Concepto', () {
      final element = Concepto();
      expect(element, elementHasName('cfdi:Concepto'));
      expect(
        element,
        elementHasOrder(
          [
            'cfdi:Impuestos',
            'cfdi:ACuentaTerceros',
            'cfdi:InformacionAduanera',
            'cfdi:CuentaPredial',
            'cfdi:ComplementoConcepto',
            'cfdi:Parte',
          ],
        ),
      );
      expect(
        element,
        elementHasChildSingle(
          ConceptoImpuestos,
          'getImpuestos',
          'addImpuestos',
        ),
      );
      expect(element, elementHasChildSingle(ACuentaTerceros));
      expect(element, elementHasChildMultiple(InformacionAduanera));
      expect(element, elementHasChildMultiple(CuentaPredial));
      expect(element, elementHasChildSingleAddChild(ComplementoConcepto));
      expect(element, elementHasChildMultiple(Parte));
    });

    test('ConceptoImpuestos', () {
      final element = ConceptoImpuestos();
      expect(element, elementHasName('cfdi:Impuestos'));
      expect(element, elementHasOrder(['cfdi:Traslados', 'cfdi:Retenciones']));
      expect(element, elementHasChildSingle(Traslados));
      expect(element, elementHasChildSingle(Retenciones));
    });

    test('Traslados', () {
      final element = Traslados();
      expect(element, elementHasName('cfdi:Traslados'));
      expect(element, elementHasChildMultiple(Traslado));
    });

    test('Traslado', () {
      final element = Traslado();
      expect(element, elementHasName('cfdi:Traslado'));
    });

    test('Retenciones', () {
      final element = Retenciones();
      expect(element, elementHasName('cfdi:Retenciones'));
      expect(element, elementHasChildMultiple(Retencion));
    });

    test('Retencion', () {
      final element = Retencion();
      expect(element, elementHasName('cfdi:Retencion'));
    });

    test('ACuentaTerceros', () {
      final element = ACuentaTerceros();
      expect(element, elementHasName('cfdi:ACuentaTerceros'));
    });

    test('InformacionAduanera', () {
      final element = InformacionAduanera();
      expect(element, elementHasName('cfdi:InformacionAduanera'));
    });

    test('CuentaPredial', () {
      final element = CuentaPredial();
      expect(element, elementHasName('cfdi:CuentaPredial'));
    });

    test('ComplementoConcepto', () {
      final element = ComplementoConcepto();
      expect(element, elementHasName('cfdi:ComplementoConcepto'));
    });

    test('Parte', () {
      final element = Parte();
      expect(element, elementHasName('cfdi:Parte'));
      expect(element, elementHasChildMultiple(InformacionAduanera));
    });

    test('Impuestos', () {
      final element = Impuestos();
      expect(element, elementHasName('cfdi:Impuestos'));
      expect(element, elementHasOrder(['cfdi:Retenciones', 'cfdi:Traslados']));
      expect(element, elementHasChildSingle(Retenciones));
      expect(element, elementHasChildSingle(Traslados));
    });

    test('Complemento', () {
      final element = Complemento();
      expect(element, elementHasName('cfdi:Complemento'));
    });

    test('Addenda', () {
      final element = Addenda();
      expect(element, elementHasName('cfdi:Addenda'));
    });
  });
}
