import 'package:cfdi_elements/src/nodes/node_interface.dart';

abstract class ElementInterface extends NodeInterface {
  String getElementName();

  Map<String, String> getFixedAttributes();

  List<String> getChildrenOrder();
}
