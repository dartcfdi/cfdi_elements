import 'package:xml/xml.dart';

bool isValidXmlName(String name) {
  if (name.isEmpty || name.trim().isEmpty) {
    return false;
  }

  return RegExp(r'^[\p{L}_:][\p{L}\d_:.-]*$', unicode: true).hasMatch(name);
}

XmlDocument newDocument([XmlDocument? document]) {
  if (document == null) {
    return XmlDocument();
  }

  return document;
}

XmlDocument newDocumentContent(String content) {
  if (content.isEmpty || content.trim().isEmpty) {
    throw const FormatException('Received xml string argument is empty');
  }

  try {
    final documentParse = XmlDocument.parse(content);
    return newDocument(documentParse);
  } on Exception catch (e) {
    throw FormatException(
      'Cannot create a Document from xml string, error: $e',
    );
  }
}
