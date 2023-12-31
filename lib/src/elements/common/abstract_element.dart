import 'package:cfdi_elements/src/elements/common/element_interface.dart';
import 'package:cfdi_elements/src/nodes/node.dart';
import 'package:cfdi_elements/src/nodes/node_interface.dart';

abstract class AbstractElement extends Node implements ElementInterface {
  AbstractElement([
    Map<String, String> attributes = const {},
    List<NodeInterface> children = const [],
  ]) : super('cfdi') {
    super.init(
      getElementName(),
      {...getFixedAttributes(), ...attributes},
      children,
    );

    this.children().setOrder(getChildrenOrder());
  }

  @override
  Map<String, String> getFixedAttributes() {
    return {};
  }

  @override
  List<String> getChildrenOrder() {
    return [];
  }

  T helperGetOrAdd<T extends NodeInterface>(ElementInterface element) {
    final retrieved = searchNode([element.getElementName()]);
    if (retrieved != null) {
      return retrieved as T;
    }

    addChild(element);

    return element as T;
  }
}
