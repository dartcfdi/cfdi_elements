import 'dart:mirrors';

import 'package:cfdi_elements/src/elements/common/abstract_element.dart';
import 'package:cfdi_elements/src/nodes/node.dart';
import 'package:test/test.dart';

Matcher elementHasName(String name) => _ElementHasName(equals(name));

Matcher elementHasOrder(List<String> order) =>
    _ElementHasOrder(orderedEquals(order));

Matcher elementHasFixedAttributes(Map<String, String> attributes) =>
    _ElementHasFixedAttributes(
      pairwiseCompare(
        attributes.entries,
        (p0, MapEntry<String, String> p1) =>
            p0.key == p1.key && p0.value == p1.value,
        'Map entry is equal',
      ),
    );

Matcher elementHasChildSingle(
  Type childClass, [
  String? getter,
  String? adder,
]) =>
    _ElementHasChildSingle(childClass, getter, adder);

Matcher elementHasChildSingleAddChild(Type childClass) =>
    _ElementHasChildSingleAddChild(childClass);

Matcher elementHasChildMultiple(Type childClass) =>
    _ElementHasChildMultiple(childClass);

class _ElementHasName extends CustomMatcher {
  _ElementHasName(Object? valueOrMatcher)
      : super('Element with name is', 'name', valueOrMatcher);

  @override
  Object? featureValueOf(dynamic actual) =>
      (actual as AbstractElement).getElementName();
}

class _ElementHasOrder extends CustomMatcher {
  _ElementHasOrder(Object? valueOrMatcher)
      : super(
          'Element with children order is',
          'children->order',
          valueOrMatcher,
        );

  @override
  Object? featureValueOf(dynamic actual) =>
      (actual as AbstractElement).children().getOrder();
}

class _ElementHasFixedAttributes extends CustomMatcher {
  _ElementHasFixedAttributes(Object? valueOrMatcher)
      : super('Element with attributes is', 'attributes', valueOrMatcher);

  @override
  Object? featureValueOf(dynamic actual) =>
      (actual as AbstractElement).attributes().entries;
}

class _ElementHasChildSingle extends Matcher {
  final Type _childClass;
  final String? _getter;
  final String? _adder;

  _ElementHasChildSingle(
    this._childClass, [
    String? getter,
    String? adder,
  ])  : _getter = getter,
        _adder = adder;

  @override
  Description describe(Description description) {
    return description.add('Element has child single');
  }

  @override
  bool matches(Object? item, Map matchState) {
    if (item is! AbstractElement) {
      return false;
    }

    item.children().clear();
    final element = reflect(item);

    final getter = _getter ?? 'get$_childClass';
    final instance = element.invoke(Symbol(getter), []).reflectee;
    if (instance.runtimeType.toString() != _childClass.toString()) {
      matchState['getterInstance'] =
          'The method ${item.runtimeType}.$getter should return the an instance of $_childClass';
      return false;
    }

    if (element.invoke(Symbol(getter), []).reflectee != instance) {
      matchState['getterSameInstance'] =
          'The method ${item.runtimeType}.$getter should return always the same instance';
      return false;
    }

    final adder = _adder ?? 'add$_childClass';
    final secondInstance = element.invoke(Symbol(adder), [
      {'foo': 'bar'},
    ]).reflectee;
    if (secondInstance.runtimeType.toString() != _childClass.toString()) {
      matchState['adderInstance'] =
          'The method ${item.runtimeType}.$adder should return the an instance of $_childClass';
      return false;
    }

    if ((instance as AbstractElement)['foo'] != 'bar') {
      matchState['adderInstanceAttribute'] =
          'The method ${item.runtimeType}.$adder should write the attributes on the same instance';
      return false;
    }

    return true;
  }

  @override
  Description describeMismatch(
    Object? item,
    Description mismatchDescription,
    Map matchState,
    bool verbose,
  ) {
    if (matchState.containsKey('getterInstance')) {
      mismatchDescription.add(matchState['getterInstance'] as String);
    }

    if (matchState.containsKey('getterSameInstance')) {
      mismatchDescription.add(matchState['getterSameInstance'] as String);
    }

    if (matchState.containsKey('adderInstance')) {
      mismatchDescription.add(matchState['adderInstance'] as String);
    }

    if (matchState.containsKey('adderInstanceAttribute')) {
      mismatchDescription.add(matchState['adderInstanceAttribute'] as String);
    }

    if (mismatchDescription.length <= 0) {
      mismatchDescription.add(' is ').addDescriptionOf(item);
    }

    return mismatchDescription;
  }
}

class _ElementHasChildSingleAddChild extends Matcher {
  final Type _childClass;

  _ElementHasChildSingleAddChild(this._childClass);

  @override
  Description describe(Description description) {
    return description.add('Element has child single add child');
  }

  @override
  bool matches(Object? item, Map matchState) {
    if (item is! AbstractElement) {
      return false;
    }

    item.children().clear();
    final element = reflect(item);

    final getter = 'get$_childClass';
    final instance = element.invoke(Symbol(getter), []).reflectee;
    if (instance.runtimeType.toString() != _childClass.toString()) {
      matchState['getterInstance'] =
          'The method ${item.runtimeType}.$getter should return the an instance of $_childClass';
      return false;
    }

    if (element.invoke(Symbol(getter), []).reflectee != instance) {
      matchState['getterSameInstance'] =
          'The method ${item.runtimeType}.$getter should return always the same instance';
      return false;
    }

    final adder = 'add$_childClass';
    final firstChild = Node('child1');
    final returnOnAdder = element
      ..invoke(Symbol(adder), [
        firstChild,
      ]).reflectee;
    if (returnOnAdder != element) {
      matchState['adderInstance'] =
          'The method ${item.runtimeType}.$adder should return always the element instance';
      return false;
    }

    if ((instance as AbstractElement).children().first != firstChild) {
      matchState['adderFirstChild'] =
          "The first child should be added to the element's children";
      return false;
    }

    final secondChild = Node('child2');
    element.invoke(Symbol(adder), [secondChild]).reflectee;
    if (instance.children().get(0) != firstChild ||
        instance.children().get(1) != secondChild) {
      matchState['adderSecondChild'] =
          "The second child should be added to the element's children";
      return false;
    }

    return true;
  }

  @override
  Description describeMismatch(
    Object? item,
    Description mismatchDescription,
    Map matchState,
    bool verbose,
  ) {
    if (matchState.containsKey('getterInstance')) {
      mismatchDescription.add(matchState['getterInstance'] as String);
    }

    if (matchState.containsKey('getterSameInstance')) {
      mismatchDescription.add(matchState['getterSameInstance'] as String);
    }

    if (matchState.containsKey('adderInstance')) {
      mismatchDescription.add(matchState['adderInstance'] as String);
    }

    if (matchState.containsKey('adderFirstChild')) {
      mismatchDescription.add(matchState['adderFirstChild'] as String);
    }

    if (matchState.containsKey('adderSecondChild')) {
      mismatchDescription.add(matchState['adderSecondChild'] as String);
    }

    if (mismatchDescription.length <= 0) {
      mismatchDescription.add(' is ').addDescriptionOf(item);
    }

    return mismatchDescription;
  }
}

class _ElementHasChildMultiple extends Matcher {
  final Type _childClass;

  _ElementHasChildMultiple(this._childClass);

  @override
  Description describe(Description description) {
    return description.add('Element has child multiple');
  }

  @override
  bool matches(Object? item, Map matchState) {
    if (item is! AbstractElement) {
      return false;
    }

    item.children().clear();
    final element = reflect(item);

    // First: add should return specific instance and added
    final adder = 'add$_childClass';
    final first = element.invoke(Symbol(adder), [
      {'id': 'first'},
    ]).reflectee;
    if (first.runtimeType.toString() != _childClass.toString()) {
      matchState['adderInstance'] =
          'The method ${item.runtimeType}.$adder should return the an instance of $_childClass';
      return false;
    }

    if ((first as AbstractElement)['id'] != 'first') {
      matchState['adderInstanceAttributes'] =
          'The method ${item.runtimeType}.$adder should write the attributes';
      return false;
    }

    if (item.children().length != 1) {
      matchState['adderInstanceLength'] =
          'Children length is one, actually is ${item.children().length}';
      return false;
    }

    // Second: add should return other instance different from first but added
    final second = element.invoke(Symbol(adder), [
      {'id': 'second'},
    ]).reflectee;
    if (first == (second as AbstractElement)) {
      matchState['adderSecondNewInstance'] =
          'The method ${item.runtimeType}.$adder should return a new instance of $_childClass';
      return false;
    }

    if (second['id'] != 'second') {
      matchState['adderSecondInstanceAttributes'] =
          'The method ${item.runtimeType}.$adder should write the attributes';
      return false;
    }

    if (item.children().length != 2) {
      matchState['adderInstanceLengthUpdate'] =
          'Children length is two, actually is ${item.children().length}';
      return false;
    }

    // Multiple: add should return other instance different from first but added
    final multi = 'multi$_childClass';
    final sameAsElement = element
      ..invoke(Symbol(multi), [
        [
          {'id': 'third'},
          {'id': 'fourth'},
        ],
      ]).reflectee;
    if (element != sameAsElement) {
      matchState['adderMultiSameInstance'] =
          'The method ${item.runtimeType}.$multi should return the same element as the instance contained';
      return false;
    }

    return true;
  }

  @override
  Description describeMismatch(
    Object? item,
    Description mismatchDescription,
    Map matchState,
    bool verbose,
  ) {
    if (matchState.containsKey('adderInstance')) {
      mismatchDescription.add(matchState['adderInstance'] as String);
    }

    if (matchState.containsKey('adderInstanceAttributes')) {
      mismatchDescription.add(matchState['adderInstanceAttributes'] as String);
    }

    if (matchState.containsKey('adderInstanceLength')) {
      mismatchDescription.add(matchState['adderInstanceLength'] as String);
    }

    if (matchState.containsKey('adderSecondNewInstance')) {
      mismatchDescription.add(matchState['adderSecondNewInstance'] as String);
    }

    if (matchState.containsKey('adderSecondInstanceAttributes')) {
      mismatchDescription
          .add(matchState['adderSecondInstanceAttributes'] as String);
    }

    if (matchState.containsKey('adderInstanceLengthUpdate')) {
      mismatchDescription
          .add(matchState['adderInstanceLengthUpdate'] as String);
    }

    if (matchState.containsKey('adderMultiSameInstance')) {
      mismatchDescription.add(matchState['adderMultiSameInstance'] as String);
    }

    if (mismatchDescription.length <= 0) {
      mismatchDescription.add(' is ').addDescriptionOf(item);
    }

    return mismatchDescription;
  }
}
