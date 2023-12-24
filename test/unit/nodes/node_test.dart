import 'package:cfdi_elements/cfdi_elements.dart';
import 'package:test/test.dart';

void main() {
  group('Node', () {
    test('construct without arguments', () {
      final node = Node('name');
      expect(node.name(), 'name');
      expect(node.length, equals(0));
      expect(node.children(), hasLength(0));
      expect(node.value(), equals(''));
    });

    test('construct with arguments', () {
      final dummyNode = Node('dummy');
      final attributes = {'foo': 'bar'};
      final children = [dummyNode];
      const value = 'xee';
      final node = Node('name', attributes, children, value);
      expect(node.attributes().get('foo'), equals('bar'));
      expect(node.children().firstNodeWithName('dummy'), equals(dummyNode));
      expect(node.value(), equals(value));
    });

    test('construct with empty name', () {
      expect(
        () => Node('\n \t \n'),
        throwsA(
          isA<FormatException>().having(
            (e) => e.message,
            'message',
            contains('invalid xml name'),
          ),
        ),
      );
    });

    test('construct with untrimmed name', () {
      expect(
        () => Node(' x '),
        throwsA(
          isA<FormatException>().having(
            (e) => e.message,
            'message',
            contains('invalid xml name'),
          ),
        ),
      );
    });

    test('search attribute', () {
      final node = Node('root', {
        'level': 1,
      }, [
        Node('child', {
          'level': 2,
        }, [
          Node('grandchild', {'level': 3.1}),
          Node('grandchild', {'level': 3.2}),
        ]),
      ]);
      expect(node.searchAttribute(['level']), equals('1'));
      expect(node.searchAttribute(['child', 'level']), equals('2'));
      expect(
        node.searchAttribute(['child', 'grandchild', 'level']),
        equals('3.1'),
      );
      // Not resolvable
      expect(
        node.searchAttribute(
          ['not-found-child', 'child', 'grandchild', 'level'],
        ),
        equals(''),
      );
      expect(node.searchAttribute(['not-found-attribute']), equals(''));
    });

    test('search node', () {
      final grandChildOne = Node('grandchild', {'level': '3.1'});
      final grandChildTwo = Node('grandchild', {'level': '3.2'});
      final child = Node('child', {'level': 2}, [grandChildOne, grandChildTwo]);
      final root = Node('root', {'level': 1}, [child]);
      expect(root.searchNode(), equals(root));
      expect(root.searchNode(['child']), equals(child));
      expect(root.searchNode(['child', 'grandchild']), equals(grandChildOne));
      expect(root.searchNode(['child', 'grandchild', 'not-found']), isNull);
      expect(root.searchNode(['not-found', 'child', 'grandchild']), isNull);
      expect(root.searchNode(['not-found']), isNull);
    });

    test('search nodes', () {
      final grandChildOne = Node('grandchild', {'level': '3.1'});
      final grandChildTwo = Node('grandchild', {'level': '3.2'});
      final child = Node('child', {'level': 2}, [grandChildOne, grandChildTwo]);
      final root = Node('root', {'level': 1}, [child]);
      final nodesChild = root.searchNodes(['child']);
      expect(nodesChild, hasLength(1));
      expect(nodesChild.first, equals(child));

      final nodesGrandChild = root.searchNodes(['child', 'grandchild']);
      expect(nodesGrandChild, hasLength(2));
      expect(nodesGrandChild.get(0), equals(grandChildOne));
      expect(nodesGrandChild.get(1), equals(grandChildTwo));
      expect(
        root.searchNodes(['child', 'grandchild', 'not-found']),
        hasLength(0),
      );
      expect(
        root.searchNodes(['not-found', 'child', 'grandchild']),
        hasLength(0),
      );
      expect(root.searchNodes(['not-found']), hasLength(0));
    });

    test('array access to attributes', () {
      final node = Node('x');
      node['id'] = 'form';
      expect(node.exists('id'), isTrue);
      expect(node['id'], equals('form'));

      node['id'] = 'the-form';
      expect(node['id'], equals('the-form'));

      node.unset('id');
      expect(node.exists('id'), isFalse);
      expect(node['id'], equals(''));
    });

    test('value property', () {
      final node = Node('x');
      node.setValue('first');
      expect(node.value(), equals('first'));

      node.setValue('second');
      expect(node.value(), equals('second'));
    });

    test('add children', () {
      final node = Node('x');
      final childrenNode = Node('y');
      node.addChild(childrenNode);
      expect(node.length, equals(1));
    });

    test('add attributes', () {
      final node = Node('x');
      expect(node.attributes(), hasLength(0));

      node.addAttributes({'foo': 'foo'});
      expect(node.attributes(), hasLength(1));
    });

    test('clear all', () {
      final node = Node('x', {'foo': '1'});
      final childrenNode = Node('y');
      node.addChild(childrenNode);
      expect(node.length, equals(1));
      expect(node.attributes(), hasLength(1));

      node.clear();
      expect(node.length, equals(0));
      expect(node.attributes(), hasLength(0));
    });
  });
}
