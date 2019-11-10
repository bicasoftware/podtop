import 'dart:convert';

import 'package:http/http.dart';

extension httpHelper on Response {
  Map<String, dynamic> getAsJson() {
    return json.decode(this.body) as Map<String, dynamic>;
  }
}
