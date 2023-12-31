import 'package:cfdi_elements/src/elements/tfd11/timbre_fiscal_digital.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../elements_matchers.dart';

void main() {
  group('Tfd11', () {
    test('TimbreFiscalDigital', () {
      final element = TimbreFiscalDigital();
      expect(element, elementHasName('tfd:TimbreFiscalDigital'));
      expect(
        element,
        elementHasFixedAttributes({
          'xmlns:tfd': 'http://www.sat.gob.mx/TimbreFiscalDigital',
          'xsi:schemaLocation':
              'http://www.sat.gob.mx/TimbreFiscalDigital http://www.sat.gob.mx/sitio_internet/cfd/TimbreFiscalDigital/TimbreFiscalDigitalv11.xsd',
          'Version': '1.1',
        }),
      );
    });
  });
}
