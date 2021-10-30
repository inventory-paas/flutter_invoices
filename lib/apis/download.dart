import 'dart:html';
import 'dart:convert';
import 'dart:typed_data';

void download(Uint8List bytes, String name) {
  final base64 = base64Encode(bytes);
  final anchor =
      AnchorElement(href: 'data:application/octet-stream;base64,$base64')
        ..target = 'blank';
  anchor.download = name;
  document.body!.append(anchor);
  anchor.click();
  anchor.remove();
  return;
}
