//返回业务的数据结构
import 'package:mc00_shop/constants/index.dart';
import 'package:mc00_shop/utils/DioRequest.dart';
import 'package:mc00_shop/viewmodels/home.dart';

List<dynamic> _extractListResult(dynamic response) {
  if (response is List) {
    return response;
  }
  if (response is Map<String, dynamic>) {
    final result = response['result'];
    if (result is List) {
      return result;
    }
  }
  return const [];
}

Map<String, dynamic> _extractObjectResult(dynamic response) {
  if (response is Map<String, dynamic>) {
    final result = response['result'];
    if (result is Map<String, dynamic>) {
      return result;
    }
    return response;
  }
  return const {};
}

Future<List<BannerItem>> getBannerListAPI() async {
  final response = await dioRequest.get(HttpConstants.BANNER_LIST);
  return _extractListResult(response).map((item) {
    return BannerItem.fromJson(item as Map<String, dynamic>);
  }).toList();
}

//分类列表
Future<List<CategoryItem>> getCategoryListAPI() async {
  final response = await dioRequest.get(HttpConstants.CATEGORY_LIST);
  return _extractListResult(response).map((item) {
    return CategoryItem.fromJson(item as Map<String, dynamic>);
  }).toList();
}

//推荐列表
Future<List<RecommendItem>> getProductListAPI() async {
  final response = await dioRequest.get(HttpConstants.PRODUCT_LIST);
  return _extractListResult(response).map((item) {
    return RecommendItem.fromJson(item as Map<String, dynamic>);
  }).toList();
}

//爆款推荐列表
Future<ResultData> getInVogueListAPI() async {
  final response = await dioRequest.get(HttpConstants.IN_VOGUE_LIST);
  return ResultData.fromJson(_extractObjectResult(response));
}

//一站式推荐
Future<ResultData> getOneStopListAPI() async {
  final response = await dioRequest.get(HttpConstants.ONE_STOP_LIST);
  return ResultData.fromJson(_extractObjectResult(response));
}

//推荐列表
Future<List<RecommendItem>> getRecommendListAPI() async {
  final response = await dioRequest.get(HttpConstants.RECOMMEND_LIST);
  return _extractListResult(response).map((item) {
    return RecommendItem.fromJson(item as Map<String, dynamic>);
  }).toList();
}
