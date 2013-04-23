import 'dart:html';
import '../lib/delegate.dart';

void main() {

  query("#sample_text_id").text = "Click me!";

  window.onClick.listen(delegate(
    window,
    (el) => el.id == 'sample_text_id',
    (ev, el) => reverseText(ev)
  ));
}

void reverseText(MouseEvent event) {
  var text = query("#sample_text_id").text;
  var buffer = new StringBuffer();
  for (int i = text.length - 1; i >= 0; i--) {
    buffer.write(text[i]);
  }
  query("#sample_text_id").text = buffer.toString();
}
