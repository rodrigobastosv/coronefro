import 'package:coronefro/model/with_label.dart';

class Opcao implements WithLabel {
  Opcao(this.value);

  String value;

  @override
  String get label => value;
}
