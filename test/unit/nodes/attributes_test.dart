import 'package:cfdi_elements/cfdi_elements.dart';
import 'package:test/test.dart';

import '../../helpers/anonymous_class.dart';

void main() {
  group('Attributes', () {
    test('construct without arguments', () {
      final attributes = Attributes();
      expect(attributes.length, equals(0));
    });

    test('construct with members', () {
      final data = {
        'id': 'sample',
        'foo': 'bar',
      };
      final attributes = Attributes(data);
      expect(attributes.length, equals(2));
      for (final entry in attributes.entries) {
        expect(attributes.exists(entry.key), isTrue);
        expect(attributes.get(entry.key), equals(entry.value));
      }
    });

    test('set method with invalid name', () {
      final invalidNames = ['', '    '];
      for (final invalidName in invalidNames) {
        final attributes = Attributes();
        expect(() => attributes.set(invalidName, ''), throwsFormatException);
      }
    });

    test('set method', () {
      final attributes = Attributes();
      // First
      attributes.set('foo', 'bar');
      expect(attributes.length, equals(1));
      expect(attributes.get('foo'), equals('bar'));

      //Second
      attributes.set('lorem', 'ipsum');
      expect(attributes.length, equals(2));
      expect(attributes.get('lorem'), equals('ipsum'));

      // Override
      attributes.set('foo', 'BAR');
      expect(attributes.length, equals(2));
      expect(attributes.get('foo'), equals('BAR'));
    });

    test('set with invalid names', () {
      final invalidNames = ['', ' ', '0', '0-foo', '-', '-x', 'foo bar'];
      for (final invalidName in invalidNames) {
        final attributes = Attributes();
        expect(
          () => attributes.set(invalidName, ''),
          throwsA(
            isA<FormatException>().having(
              (error) => error.message,
              'message',
              contains('invalid xml name'),
            ),
          ),
        );
      }
    });

    test('get method on non existent', () {
      final attributes = Attributes();
      expect(attributes.get('foo'), equals(''));
    });

    test('remove', () {
      final attributes = Attributes();
      attributes.set('foo', 'bar');
      attributes.remove('bar');
      expect(attributes.length, equals(1));

      attributes.remove('foo');
      expect(attributes.length, equals(0));
    });

    test('array access', () {
      final attributes = Attributes();
      attributes['id'] = 'sample';
      attributes['foo'] = 'foo foo foo';
      // Override
      attributes['foo'] = 'bar';
      attributes['empty'] = '';
      expect(attributes, hasLength(3));
      // Existent
      expect(attributes['empty'], isNotNull);
      expect(attributes['id'], isNotNull);
      expect(attributes['id'], equals('sample'));
      expect(attributes['foo'], equals('bar'));
      // Non Existent
      expect(attributes.exists('non-existent'), isFalse);
      expect(attributes['non-existent'], equals(''));

      // Remove and check
      attributes.remove('foo');
      expect(attributes['foo'], equals(''));
    });

    test('iterator', () {
      final data = {
        'foo': 'bar',
        'lorem': 'ipsum',
      };
      final created = <String, String>{};
      final attributes = Attributes(data);
      for (final entry in attributes.entries) {
        created[entry.key] = entry.value;
      }

      expect(created, equals(data));
    });

    test('set to null perform remove', () {
      final attributes = Attributes(
        {
          'foo': 'bar',
          'bar': 'foo',
        },
      );
      expect(attributes.exists('foo'), isTrue);
      expect(attributes.exists('bar'), isTrue);

      attributes.set('foo');
      expect(attributes.exists('foo'), isFalse);

      attributes.set('bar');
      expect(attributes.exists('bar'), isFalse);
    });

    test('import with empty', () {
      final attributes = Attributes({
        'foo': 'bar',
        'bar': 'foo',
      });
      expect(attributes.length, equals(2));

      attributes.importMap({});
      expect(attributes.length, equals(2));

      attributes.importMap({'another': 'another'});
      expect(attributes.length, equals(3));
    });

    test('import with null perform remove', () {
      final attributes = Attributes({
        'set': '1',
        'importArray': '1',
        'offsetSet': '1',
        'constructor': null,
        'empty': null,
      });
      expect(attributes.length, equals(3));
      expect(attributes.exists('constructor'), isFalse);
      expect(attributes.exists('empty'), isFalse);
      expect(attributes.length, equals(3));

      attributes.set('set');
      expect(attributes.exists('set'), isFalse);
      expect(attributes.length, equals(2));

      attributes.importMap({'importArray': null});
      expect(attributes.exists('importArray'), isFalse);
      expect(attributes.length, equals(1));

      attributes['offsetSet'] = null;
      expect(attributes.exists('offsetSet'), isFalse);
      expect(attributes.length, equals(0));
    });

    test('import with invalid value', () {
      expect(
        () => Attributes({'foo': []}),
        throwsA(
          isA<FormatException>().having(
            (e) => e.message,
            'message',
            contains('Cannot convert value of attribute foo to string'),
          ),
        ),
      );
    });

    test('set with object to string', () {
      const expectedValue = 'foo';
      final toStringObject = AnonymousClass('foo');
      final attributes = Attributes({
        'constructor': toStringObject,
      });
      attributes.set('offsetSet', '$toStringObject');
      attributes.set('set', '$toStringObject');
      attributes.importMap({
        'importArray': toStringObject,
      });

      expect(attributes.get('constructor'), equals(expectedValue));
      expect(attributes.get('offsetSet'), equals(expectedValue));
      expect(attributes.get('set'), equals(expectedValue));
      expect(attributes.get('importArray'), equals(expectedValue));
    });

    test('export map', () {
      final attributes = Attributes();
      attributes.set('foo', 'bar');
      expect(
        attributes.exportMap(),
        equals({
          'foo': 'bar',
        }),
      );
    });
  });
}
