//基于dio进行二次封装
import 'package:dio/dio.dart';
import 'package:mc00_shop/constants/index.dart';

class DioRequest {
  final _dio = Dio();
  //配置基础地址拦截器
  DioRequest() {
    _dio.options.baseUrl = GlobalConstants.BASE_URL;
    _dio.options.connectTimeout = Duration(seconds: GlobalConstants.TIME_OUT);
    _dio.options
      ..sendTimeout = Duration(seconds: GlobalConstants.TIME_OUT)
      ..receiveTimeout = Duration(seconds: GlobalConstants.TIME_OUT);
    _addInterceptor();
  }
  void _addInterceptor() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (requestOptions, handler) {
          handler.next(requestOptions);
        },
        onResponse: (response, handler) {
          //http状态码 200-300
          if (response.statusCode! >= 200 && response.statusCode! <= 300) {
            handler.next(response);
            return;
          }
          handler.reject(DioException(requestOptions: response.requestOptions));
        },

        onError: (error, handler) {
          handler.reject(error);
        },
      ),
    );
  }

  _handelResponse(Future<Response<dynamic>> task) async {
    //接受的不是数据，是还未完成的请求
    try {
      Response<dynamic> res = await task;
      final data = res.data as Map<String, dynamic>; //data才是真实的接口返回的数据
      if (data["code"] == GlobalConstants.SUCCESS_CODE) {
        return data["result"]; //真正的数据
      }
      //抛出异常，交给外部去处理
      throw Exception(data["message"] ?? "请求失败");
    } catch (e) {
      //不是我怎么错的
      throw Exception("请求失败：$e");
    }
  } //笨蛋腐竹忘记try了

  get(String url, {Map<String, dynamic>? params}) async {
    return await _handelResponse(_dio.get(url, queryParameters: params));
  }

  //进一步返回处理函数
}

final dioRequest = DioRequest();//单例对象.


//Dio 工具返回的数据是 Resopnse<dynamic>.data
//把所有的接口的data解构出来，拿到真正的数据，然后拿到业务状态码，如果等于一就会开始方向，否则直接Reject掉，抛出异常，交给外部去处理.