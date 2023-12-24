import 'package:cfdi_elements/src/utils/xml_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Xml Utils', () {
    test('true on valid names', () {
      final names = ['First_Name', '_4-lane', 'tél', 'month-day'];
      for (final name in names) {
        expect(isValidXmlName(name), isTrue);
      }
    });

    test('false on invalid names', () {
      final names = ['Driver`s_License', 'month/day', 'first name', '4-lane'];
      for (final name in names) {
        expect(isValidXmlName(name), isFalse);
      }
    });

    test('method newDocumentContent with empty xml', () {
      const xmlEmpty = '';
      expect(
        () => newDocumentContent(xmlEmpty),
        throwsA(
          isA<FormatException>().having(
            (error) => error.message,
            'message',
            'Received xml string argument is empty',
          ),
        ),
      );
    });

    test('method newDocumentContent with invalid xml', () {
      const xmlInvalid = '<xml a="1" a="2"</xml>';
      expect(
        () => newDocumentContent(xmlInvalid),
        throwsA(
          isA<FormatException>().having(
            (error) => error.message,
            'message',
            contains('Cannot create a Document from xml string'),
          ),
        ),
      );
    });
  });
}
