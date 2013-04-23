

// Copyright (c) 2013, Samuel Hapak. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:unittest/unittest.dart';
import 'lib/delegate.dart';

class MockEvent {
  MockElement target;
  Map properties;
}

class MockElement {
  MockElement parent;
  Map properties;
}

void main() {

  MockElement e1 = new MockElement();
  MockElement e2 = new MockElement();
  MockElement e3 = new MockElement();
  MockElement e4 = new MockElement();
  MockElement e5 = new MockElement();

  e1
    ..properties = {'name': 1}
    ..parent = e2;
  e2
    ..properties = {'name': 2}
    ..parent = e3;
  e3
    ..properties = {'name': 3}
    ..parent = e4;
  e4
    ..properties = {'name': 4}
    ..parent = e5;
  e5.properties = {'name': 5};

  MockEvent event = new MockEvent();
  event
    ..target = e1
    ..properties = {'name': 'event'};

  test('Delegate with parent', () {
    var calls = [];
    var eventHandler = delegate(
      e4,
      (element) => element.properties['name'] > 1,
      (ev, el) => calls.addAll([ev.properties['name'], el.properties['name']])
    );

    eventHandler(event);
    expect(calls, orderedEquals(['event', 2, 'event', 3]));

  });

  test ('Delegate with null parent', () {
    var calls = [];
    var eventHandler = delegate(
      null,
      (element) => element.properties['name'] > 1,
      (ev, el) => calls.addAll([ev.properties['name'], el.properties['name']])
    );
    eventHandler(event);
    expect(calls, orderedEquals(['event', 2, 'event', 3, 'event', 4, 'event', 5]));
  });


}