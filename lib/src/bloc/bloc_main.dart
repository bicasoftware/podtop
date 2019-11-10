import 'package:flutter/material.dart';
import 'package:podtop/src/bloc/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

class BlocMain with BaseBloc {
  BlocMain({@required this.isLight}){
    inBrightness.add(isLight ? Brightness.light : Brightness.dark);
  }

  bool isLight;

  BehaviorSubject<Brightness> _bhsBrightness = BehaviorSubject<Brightness>();
  Stream<Brightness> get outBrightness => _bhsBrightness.stream;
  Sink<Brightness> get inBrightness => _bhsBrightness.sink;

  @override
  void dispose() {
    _bhsBrightness.close();
  }

  void toggleBrightness(){
    isLight = !isLight;
    inBrightness.add(isLight ? Brightness.light : Brightness.dark);
  }
}
