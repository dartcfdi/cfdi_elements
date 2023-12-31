import 'dictionary.dart';
import 'specifications_reader.dart';
import 'structure.dart';

final class Specifications {
  final Structure _structure;

  final Dictionary _dictionary;

  Specifications(Structure structure, Dictionary dictionary)
      : _structure = structure,
        _dictionary = dictionary;

  // ignore: prefer_constructors_over_static_methods
  static Specifications makeFromFile(String specFile) {
    final specFileReader = SpecificationsReader.fromFile(specFile);
    final structure = Structure.makeFromMap(
      specFileReader.keyAsString('root-element'),
      specFileReader.keyAsMap('structure'),
    );

    final dictionary = Dictionary({
      '#prefix#': specFileReader.keyAsString('prefix'),
      '#xml-namespace#': specFileReader.keyAsString('xml-namespace'),
      '#xml-schemalocation#': specFileReader.keyAsString('xml-schemalocation'),
      '#version-attribute#': specFileReader.keyAsString('version-attribute'),
      '#version-value#': specFileReader.keyAsString('version-value'),
    });

    return Specifications(structure, dictionary);
  }

  Structure getStructure() {
    return _structure;
  }

  Dictionary getDictionary() {
    return _dictionary;
  }
}
