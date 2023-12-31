import 'package:args/args.dart';
import 'package:path/path.dart';

import '../elements_maker/elements_maker.dart';

void main(List<String> args) {
  final parser = ArgParser();
  parser.addOption('spec', mandatory: true);
  parser.addOption('output', mandatory: true);

  final results = parser.parse(args);

  final specFile = join(
    current,
    'tool',
    'elements_maker',
    'specifications',
    results['spec'] as String,
  );
  final outputDir =
      join(current, 'lib', 'src', 'elements', results['output'] as String);

  final elementsMaker = ElementsMaker.make(specFile, outputDir);
  elementsMaker.write();
}
