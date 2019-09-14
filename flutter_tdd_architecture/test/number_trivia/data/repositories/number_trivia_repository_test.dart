import 'package:flutter_tdd_architecture/core/platform/network_info.dart';
import 'package:flutter_tdd_architecture/features/number_trivia/data/datasource/number_trivia_local_data_source.dart';
import 'package:flutter_tdd_architecture/features/number_trivia/data/datasource/number_trivia_remote_data_source.dart';
import 'package:flutter_tdd_architecture/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:flutter_tdd_architecture/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRemoteDataSource extends Mock implements NumberTriviaRemoteDataSource {

}

class MockLocalDataSource extends Mock implements NumberTriviaLocalDataSource {

}

class MockNetworkInfo extends Mock implements NetworkInfo {
}
void main() {
  NumberTriviaRepositoryImpl repositoryImpl;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo networkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    networkInfo = MockNetworkInfo();
    repositoryImpl = NumberTriviaRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: networkInfo
    );
  });
}