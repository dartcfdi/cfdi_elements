import 'dart:io';

import 'package:cfdi_elements/cfdi_elements.dart';
import 'package:test/test.dart';

import '../../test_case.dart';

void main() {
  group('XmlNodeUtils Extensions', () {
    test('node to xml string xml header', () {
      final node = Node('book', {}, [
        Node('chapter', {'toc': '1'}),
        Node('chapter', {'toc': '2'}),
      ]);

      String xmlString = node.toXmlString(withXmlHeader: true);
      expect(xmlString, startsWith('<?xml version="1.0" encoding="UTF-8"?>'));

      xmlString = node.toXmlString();
      expect(xmlString, startsWith('<book>'));
    });
  });

  test('export from file and export again', () {
    final paths = [
      utilAsset('nodes/sample.xml'),
      utilAsset('nodes/sample-with-texts.xml'),
      utilAsset('cfdi33.xml'),
    ];

    for (final path in paths) {
      final source = File(path).readAsStringSync();
      // Remove trailing new line
      final xmlSource = source.substring(0, source.length - 1);
      final document = newDocumentContent(xmlSource);

      // Create node from element
      final node = document.rootElement.toNode();

      // Create builder from node
      final builder = node.toXmlBuilder();
      final xmlString = node.toXmlString();

      expect(
        builder.buildDocument().toXmlString(
              pretty: true,
            ),
        equals(xmlSource),
      );
      expect(xmlString, equals(xmlSource));
    }
  });

  test('import xml with namespace without prefix', () {
    final file = utilAsset('xml-with-namespace-definitions-at-child-level.xml');
    final node = File(file).readAsStringSync().toNode();
    final inspected = node.searchNode(['base:Third', 'innerNS']);
    if (inspected == null) {
      fail('The specimen does not have the required test case');
    }

    expect(inspected['xmlns'], equals('http://external.com/inner'));
  });

  test('xml with value with special chars', () {
    const expectedValue = 'ampersand: &';
    const content = '<root>ampersand: &amp;</root>';
    final node = content.toNode();

    expect(node.value(), equals(expectedValue));
    expect(node.toXmlString(), equals(content));
  });

  test('xml with value with inner comment', () {
    const expectedValue = 'ampersand: &';
    const content = '<root>ampersand: <!-- comment -->&amp;</root>';
    const expectedContent = '<root>ampersand: &amp;</root>';
    final node = content.toNode();

    expect(node.value(), equals(expectedValue));
    expect(node.toXmlString(), equals(expectedContent));
  });

  test('xml with value with inner white space', () {
    const expectedValue =
        '\n\nfirst line\n\tsecond line\n\t third line \t\nfourth line\n\n';
    const content = '<root>$expectedValue</root>';
    final node = content.toNode();

    expect(node.value(), equals(expectedValue));
    expect(node.toXmlString(pretty: false), equals(content));
  });

  test('xml with value with inner element', () {
    const expectedValue = 'ampersand: &';
    const content = '<root>ampersand: <inner/>&amp;</root>';
    const expectedContent = '<root><inner/>ampersand: &amp;</root>';
    final node = content.toNode();

    expect(node.value(), equals(expectedValue));
    expect(node.toXmlString(pretty: false), equals(expectedContent));
  });
}
