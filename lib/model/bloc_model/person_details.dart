import 'package:equatable/equatable.dart';

class PersonDetails extends Equatable {
  final String name;
  final String age;
  PersonDetails({required this.name, required this.age});

  @override
  List<Object?> get props => [name, age];
}
