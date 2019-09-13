import 'package:flutter_tdd_architecture/features/number_trivia/data/models/number_trivia_model.dart';

abstract class NumberTriviaRemoveDataSource {
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);

  Future<NumberTriviaModel> getRandomNumberTrivia();
}
