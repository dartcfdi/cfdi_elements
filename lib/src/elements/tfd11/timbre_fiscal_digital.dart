import 'package:cfdi_elements/src/elements/common/abstract_element.dart';

class TimbreFiscalDigital extends AbstractElement {
  TimbreFiscalDigital([
    super.attributes,
    super.children,
  ]);

  @override
  String getElementName() {
    return 'tfd:TimbreFiscalDigital';
  }

  @override
  Map<String, String> getFixedAttributes() {
    return {
      'xmlns:tfd': 'http://www.sat.gob.mx/TimbreFiscalDigital',
      'xsi:schemaLocation':
          'http://www.sat.gob.mx/TimbreFiscalDigital http://www.sat.gob.mx/sitio_internet/cfd/TimbreFiscalDigital/TimbreFiscalDigitalv11.xsd',
      'Version': '1.1',
    };
  }
}
