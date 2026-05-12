import 'package:mc00_shop/constants/index.dart';
import 'package:mc00_shop/utils/DioRequest.dart';
import 'package:mc00_shop/viewmodels/user.dart';

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

Future<UserInfo> loginAPI(Map<String, dynamic> params) async {
  final response = await dioRequest.post(HttpConstants.LOGIN, params: params);
  return UserInfo.fromJSON(_extractObjectResult(response));
}

Future<UserInfo> getUserProfileAPI() async {
  final response = await dioRequest.get(HttpConstants.USER_PROFILE);
  return UserInfo.fromJSON(_extractObjectResult(response));
}
