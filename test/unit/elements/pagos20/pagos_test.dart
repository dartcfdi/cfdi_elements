import 'package:cfdi_elements/src/elements/pagos20/docto_relacionado.dart';
import 'package:cfdi_elements/src/elements/pagos20/impuestos_d_r.dart';
import 'package:cfdi_elements/src/elements/pagos20/impuestos_p.dart';
import 'package:cfdi_elements/src/elements/pagos20/pago.dart';
import 'package:cfdi_elements/src/elements/pagos20/pagos.dart';
import 'package:cfdi_elements/src/elements/pagos20/retencion_d_r.dart';
import 'package:cfdi_elements/src/elements/pagos20/retencion_p.dart';
import 'package:cfdi_elements/src/elements/pagos20/retenciones_d_r.dart';
import 'package:cfdi_elements/src/elements/pagos20/retenciones_p.dart';
import 'package:cfdi_elements/src/elements/pagos20/totales.dart';
import 'package:cfdi_elements/src/elements/pagos20/traslado_d_r.dart';
import 'package:cfdi_elements/src/elements/pagos20/traslado_p.dart';
import 'package:cfdi_elements/src/elements/pagos20/traslados_d_r.dart';
import 'package:cfdi_elements/src/elements/pagos20/traslados_p.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../elements_matchers.dart';

void main() {
  group('Pagos20', () {
    test('Pagos', () {
      final element = Pagos();
      expect(element, elementHasName('pago20:Pagos'));
      expect(
        element,
        elementHasFixedAttributes({
          'xmlns:pago20': 'http://www.sat.gob.mx/Pagos20',
          'xsi:schemaLocation':
              'http://www.sat.gob.mx/Pagos20 http://www.sat.gob.mx/sitio_internet/cfd/Pagos/Pagos20.xsd',
          'Version': '2.0',
        }),
      );
      expect(element, elementHasChildSingle(Totales));
      expect(element, elementHasChildMultiple(Pago));
    });

    test('Totales', () {
      final element = Totales();
      expect(element, elementHasName('pago20:Totales'));
    });

    test('Pago', () {
      final element = Pago();
      expect(element, elementHasName('pago20:Pago'));
      expect(
        element,
        elementHasOrder(['pago20:DoctoRelacionado', 'pago20:ImpuestosP']),
      );
      expect(element, elementHasChildMultiple(DoctoRelacionado));
      expect(element, elementHasChildSingle(ImpuestosP));
    });

    test('DoctoRelacionado', () {
      final element = DoctoRelacionado();
      expect(element, elementHasName('pago20:DoctoRelacionado'));
      expect(element, elementHasChildSingle(ImpuestosDR));
    });

    test('ImpuestosDR', () {
      final element = ImpuestosDR();
      expect(element, elementHasName('pago20:ImpuestosDR'));
      expect(
        element,
        elementHasOrder(['pago20:RetencionesDR', 'pago20:TrasladosDR']),
      );
      expect(element, elementHasChildSingle(RetencionesDR));
      expect(element, elementHasChildSingle(TrasladosDR));
    });

    test('RetencionesDR', () {
      final element = RetencionesDR();
      expect(element, elementHasName('pago20:RetencionesDR'));
      expect(element, elementHasChildMultiple(RetencionDR));
    });

    test('RetencionDR', () {
      final element = RetencionDR();
      expect(element, elementHasName('pago20:RetencionDR'));
    });

    test('TrasladosDR', () {
      final element = TrasladosDR();
      expect(element, elementHasName('pago20:TrasladosDR'));
      expect(element, elementHasChildMultiple(TrasladoDR));
    });

    test('TrasladoDR', () {
      final element = TrasladoDR();
      expect(element, elementHasName('pago20:TrasladoDR'));
    });

    test('ImpuestosP', () {
      final element = ImpuestosP();
      expect(element, elementHasName('pago20:ImpuestosP'));
      expect(
        element,
        elementHasOrder(['pago20:RetencionesP', 'pago20:TrasladosP']),
      );
      expect(element, elementHasChildSingle(RetencionesP));
      expect(element, elementHasChildSingle(TrasladosP));
    });

    test('RetencionesP', () {
      final element = RetencionesP();
      expect(element, elementHasName('pago20:RetencionesP'));
      expect(element, elementHasChildMultiple(RetencionP));
    });

    test('RetencionP', () {
      final element = RetencionP();
      expect(element, elementHasName('pago20:RetencionP'));
    });

    test('TrasladosP', () {
      final element = TrasladosP();
      expect(element, elementHasName('pago20:TrasladosP'));
      expect(element, elementHasChildMultiple(TrasladoP));
    });

    test('TrasladoP', () {
      final element = TrasladoP();
      expect(element, elementHasName('pago20:TrasladoP'));
    });
  });
}
