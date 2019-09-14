import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_tdd_architecture/core/error/failures.dart';
import 'package:flutter_tdd_architecture/core/platform/network_info.dart';
import 'package:flutter_tdd_architecture/features/number_trivia/data/datasource/number_trivia_local_data_source.dart';
import 'package:flutter_tdd_architecture/features/number_trivia/data/datasource/number_trivia_remote_data_source.dart';
import 'package:flutter_tdd_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_tdd_architecture/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number) {
    // TODO: implement getConcreteNumberTrivia
    return null;
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() {
    // TODO: implement getRandomNumberTrivia
    return null;
  }
}
