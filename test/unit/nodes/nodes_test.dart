import 'package:cfdi_elements/cfdi_elements.dart';
import 'package:test/test.dart';

void main() {
  group('Nodes', () {
    test('empty nodes', () {
      final nodes = Nodes();
      expect(nodes, hasLength(0));
      expect(nodes.firstNodeWithName('non-existent'), isNull);
    });

    test('construct with nodes array', () {
      final expected = [Node('foo'), Node('bar')];
      final nodes = Nodes(expected);
      expect(nodes, hasLength(2));
      for (final (index, node) in nodes.indexed) {
        expect(expected[index], node);
      }
    });

    test('manipulate the collection', () {
      final first = Node('first');
      final second = Node('second');
      final nodes = Nodes();
      nodes.addAll([first, second]);
      expect(nodes, hasLength(2));
      expect(nodes.exists(first), isTrue);
      expect(nodes.exists(second), isTrue);

      final equalToFirst = Node('foo');
      expect(nodes.exists(equalToFirst), isFalse);

      // Add an equal node
      nodes.add(equalToFirst);
      expect(nodes, hasLength(3));

      // Add an identical node
      nodes.add(equalToFirst);
      expect(nodes, hasLength(3));

      // Remove the node
      nodes.remove(equalToFirst);
      expect(nodes, hasLength(2));

      // Remove the node again
      nodes.remove(equalToFirst);
      expect(nodes, hasLength(2));
      expect(nodes.firstNodeWithName('foo'), isNull);
      expect(nodes.firstNodeWithName('first'), equals(first));
      expect(nodes.firstNodeWithName('second'), equals(second));
    });

    test('add find remove', () {
      final root = Node('root');
      final nodes = root.children();
      final child = Node('child');
      nodes.add(child);
      expect(nodes.exists(child), isTrue);

      final found = root.searchNode(['child']);
      expect(found, equals(child));

      nodes.remove(found);
      expect(nodes.exists(child), isFalse);
    });

    test('first returns null', () {
      final nodes = Nodes();
      expect(nodes.firstOrNull, isNull);
    });

    test('import from list', () {
      final nodeOne = Node('one');
      final nodes = Nodes();
      nodes.importFromList([nodeOne, Node('two'), Node('three')]);
      expect(nodes, hasLength(3));
      expect(nodes.first, equals(nodeOne));
    });

    test('get throws exception when not found', () {
      final nodes = Nodes();
      expect(
        () => nodes.get(0),
        throwsA(
          isA<RangeError>().having(
            (e) => e.message,
            'message',
            contains('Invalid value'),
          ),
        ),
      );
    });

    test('get with existent elements', () {
      final foo = Node('foo');
      final bar = Node('bar');
      final nodes = Nodes([foo, bar]);
      expect(nodes.get(0), equals(foo));
      expect(nodes.get(1), equals(bar));

      // Get after remove
      nodes.remove(foo);
      expect(nodes.get(0), bar);
    });

    test('get nodes by name', () {
      final nodes = Nodes();
      final first = Node('children');
      final second = Node('children');
      final third = Node('children');
      nodes.importFromList([
        first,
        second,
        third,
        Node('other'),
      ]);
      expect(nodes, hasLength(4));

      final byName = nodes.getNodesByName('children');
      expect(byName, hasLength(3));
      expect(byName.exists(first), isTrue);
      expect(byName.exists(second), isTrue);
      expect(byName.exists(third), isTrue);
    });

    test('ordered children', () {
      final nodes = Nodes([
        Node('foo'),
        Node('bar'),
        Node('baz'),
      ]);
      expect(
        [nodes.get(0).name(), nodes.get(1).name(), nodes.get(2).name()],
        orderedEquals(['foo', 'bar', 'baz']),
      );

      // Sort previous values
      nodes.setOrder(['baz', '', '0', 'foo', '', 'bar', 'baz']);
      expect(nodes.getOrder(), orderedEquals(['baz', 'foo', 'bar']));
      expect(
        [nodes.get(0).name(), nodes.get(1).name(), nodes.get(2).name()],
        orderedEquals(['baz', 'foo', 'bar']),
      );

      // Add other baz (inserted at the bottom)
      nodes.add(Node('baz', {'id': 'second'}));
      expect(
        [nodes.get(0).name(), nodes.get(1).name(), nodes.get(2).name()],
        orderedEquals(['baz', 'baz', 'foo']),
      );
      expect(nodes.get(1)['id'], equals('second'));

      // Add other not listed
      final notListed = Node('yyy');
      nodes.add(notListed);
      expect(nodes.get(4), equals(notListed));
    });
  });
}
