import 'package:cfdi_elements/cfdi_elements.dart';
import 'package:test/test.dart';

void main() {
  group('Nodes Sorter', () {
    test('construct with names', () {
      final values = ['foo', 'bar', 'baz'];
      final sorter = NodesSorter(values);
      expect(sorter.getOrder(), orderedEquals(values));
    });

    test('construct without names', () {
      final sorter = NodesSorter();
      expect(sorter.getOrder(), orderedEquals([]));
    });

    test('parse names', () {
      final sorter = NodesSorter();
      List<({int index, String value})> indexedList(List<String> values) {
        return values.indexed.map((entry) {
          return (
            index: entry.$1,
            value: entry.$2,
          );
        }).toList();
      }

      // All invalid values
      expect(sorter.parseNames([null, 0, '']), equals([]));
      // All valid values
      expect(
        sorter.parseNames(['foo', 'bar']),
        orderedEquals(indexedList(['foo', 'bar'])),
      );
      // Duplicated values
      expect(
        sorter.parseNames(['foo', 'bar', 'bar', 'foo', 'baz']),
        orderedEquals(indexedList(['foo', 'bar', 'baz'])),
      );
      // Mixed values
      expect(
        sorter.parseNames(['', 'foo', '', 'bar', 'foo']),
        orderedEquals(indexedList(['foo', 'bar'])),
      );
    });

    test('set getOrder', () {
      final sorter = NodesSorter(['foo', 'bar']);
      expect(sorter.getOrder(), equals(['foo', 'bar']));
      // It changed
      expect(sorter.setOrder(['bar', 'foo']), isTrue);
      expect(sorter.getOrder(), orderedEquals(['bar', 'foo']));
      // It did not change
      expect(sorter.setOrder(['bar', 'foo']), isFalse);
      expect(sorter.getOrder(), orderedEquals(['bar', 'foo']));
    });

    test('order', () {
      final foo1 = Node('foo');
      final foo2 = Node('foo');
      final bar = Node('bar');
      final baz = Node('baz');
      final yyy = Node('yyy');
      final order = ['baz', 'bar', 'foo'];
      final unsorted = [yyy, foo1, foo2, bar, baz];
      final expected = [baz, bar, foo1, foo2, yyy];
      final sorter = NodesSorter(order);
      final sorted = sorter.sort(unsorted);
      expect(sorted, orderedEquals(expected));
      expect(sorted, isNot(orderedEquals(unsorted)));
    });

    test('order preserve position', () {
      final list = <Node>[];
      int index = 0;
      while (index < 1000) {
        list.add(Node('foo'));
        index++;
      }

      final sorter = NodesSorter(['foo']);
      expect(sorter.sort(list), orderedEquals(list));
    });
  });
}
