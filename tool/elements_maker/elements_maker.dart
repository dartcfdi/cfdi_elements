import 'dart:io';

import 'package:path/path.dart';
import 'package:recase/recase.dart';

import 'dictionary.dart';
import 'specifications.dart';
import 'structure.dart';

final class ElementsMaker {
  final Specifications _specs;

  final String _outputDir;

  final Map<String, String> _templates = {};

  ElementsMaker(Specifications specs, String outputDir)
      : _specs = specs,
        _outputDir = outputDir;

  ElementsMaker.make(String specFile, String outputDir)
      : _specs = Specifications.makeFromFile(specFile),
        _outputDir = outputDir;

  void write() {
    createElement(_specs.getStructure(), _specs.getDictionary(), true);
  }

  void createElement(
    Structure structure,
    Dictionary dictionary, [
    bool isRoot = false,
  ]) {
    final prefix = dictionary.get('#prefix#');
    final fixedDictionary =
        dictionary.withs('#element-name#', structure.getName());
    final sectionsContent = [];
    final orderElements = structure.getChildrenNames('$prefix:');
    if (orderElements.length > 1) {
      sectionsContent.add(
        _template(
          'get-children-order',
          Dictionary(
            {'#elements#': _elementsToString(orderElements)},
          ),
        ),
      );
    }

    if (isRoot) {
      sectionsContent.add(_template('get-fixed-attributes', fixedDictionary));
    }

    for (final child in structure) {
      final childTemplate =
          child.isMultiple() ? 'child-multiple' : 'child-single';
      sectionsContent.add(
        _template(childTemplate, Dictionary({'#child-name#': child.getName()})),
      );
      createElement(child, fixedDictionary);
    }

    final contents = _template(
      'element',
      fixedDictionary.withs('#sections#', sectionsContent.join()),
    );
    final outputFile = _buildOutputFile(structure.getName());
    File(outputFile).writeAsStringSync(contents);
  }

  String _template(String templateName, Dictionary dictionary) {
    if (!_templates.containsKey(templateName)) {
      final filename = join(
        current,
        'tool',
        'elements_maker',
        'templates',
        '$templateName.template',
      );
      final templateContent = File(filename).readAsStringSync();
      _templates[templateName] = templateContent;
    }

    return dictionary.interpolate(_templates[templateName]!);
  }

  String _buildOutputFile(String elementName) {
    final snakeCase = ReCase(elementName).snakeCase;

    return join(_outputDir, '$snakeCase.dart');
  }

  String _elementsToString(List<String> array) {
    final parts = <String>[];
    for (final value in array) {
      parts.add(value);
    }

    return '[\n${parts.map((part) => "'$part'").join(',\n')},\n]';
  }
}
