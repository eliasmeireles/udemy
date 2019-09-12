import 'package:built_collection/built_collection.dart';
import 'package:chopper/chopper.dart';
import 'package:maximilian_schwarzmuller/model/built_post.dart';

import 'built_value_converter.dart';

part 'post_api_service.chopper.dart';

@ChopperApi(baseUrl: "/posts")
abstract class PostApiService extends ChopperService {
  @Get()
  Future<Response<BuiltList<BuiltPost>>> getPosts();

  @Get(path: "/{id}")
  Future<Response<BuiltPost>> getPost(@Path("id") int id);

  @Post()
  Future<Response<BuiltPost>> postPost(
    @Body() BuiltPost body,
  );

  static PostApiService create() {
    final client = ChopperClient(
        baseUrl: "https://jsonplaceholder.typicode.com",
        services: [
          _$PostApiService(),
        ],
        converter: BuiltValueConverter(),
        interceptors: [
          HttpLoggingInterceptor()


//          HeadersInterceptor({"Cache-Control": "no-cache"}),
          //HttpLoggingInterceptor(),
          //CurlInterceptor(),
//      (Request request) async {
//          if(request.method == HttpMethod.Get) {
//            chopperLogger.info("Performed a Get quest");
//            chopperLogger.info(request.baseUrl + request.url);
//          }
//          return request;
//      }
//          (Response response) async {
//            if (response.statusCode == HttpStatus.ok) {
//              chopperLogger.info("Request susscceful");
//              chopperLogger.info(response.base.request.url);
//              chopperLogger.info(response.bodyString);
//            }
//            return response;
//          },
//          MobileDataInterceptor(),
        ]);
    return _$PostApiService(client);
  }
}
