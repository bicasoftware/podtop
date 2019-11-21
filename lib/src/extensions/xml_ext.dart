import 'package:xml/xml.dart';

extension XmlExtension on XmlElement {
  XmlElement findSafeElement(String tagName) {
    if (this.findElements(tagName).length > 0) {
      return this.findElements(tagName).first;
    } else {
      return null;
    }
  }
}
