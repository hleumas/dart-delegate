// Copyright (c) 2013, Samuel Hapak. All rights reserved. Use of this source
// code is governed by a BSD-style license that can be found in the LICENSE
// file.

library vacuum.delegate;
import "dart:core";

/**
 * Returns delegated event handler.
 *
 * Example usage:
 *
 *     window.onClick.listen(delegate(
 *       window,
 *       (el) => el is AnchorElement,
 *       (ev, el) => window.alert(el.href)
 *     ));
 */
delegate(parent, condition, handler) {
  return (event) {
    var element = event.target;
    while (element != parent && element != null) {
      if (condition(element)) {
        handler(event, element);
      }
      element = element.parent;
    }
  };
}

/**
 * Attaches delegated event handler to [parent].
 */
delegateOn(parent, String eventType, condition, handler) {
  parent.on[eventType].listen(delegate(parent, condition, handler));
}