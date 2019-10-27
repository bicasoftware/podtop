import 'package:podtop/src/bloc/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

class BlocMain with BaseBloc {
  BlocMain({this.nome}){
    inNome.add(nome);
  }

  String nome;

  BehaviorSubject<String> _bhsNome = BehaviorSubject<String>();
  Stream<String> get outNome => _bhsNome.stream;
  Sink<String> get inNome => _bhsNome.sink;

  @override
  void dispose() {
    _bhsNome.close();
  }
}
