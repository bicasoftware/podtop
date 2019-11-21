import 'package:flutter/widgets.dart';
import 'package:podtop/src/bloc/state_main.dart';
import 'package:podtop/src/podtop.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    PodTop(state: await StateMain().build()),
  );
}
