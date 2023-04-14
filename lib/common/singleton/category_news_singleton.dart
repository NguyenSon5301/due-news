import 'package:rxdart/subjects.dart';

class CategoryNews {
  CategoryNews._();
  static final _ins = CategoryNews._();
  static CategoryNews get ins => _ins;
  BehaviorSubject<String?>? category$;
  String category = 'Nghiên cứu';
}
