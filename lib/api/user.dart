import 'package:mc00_shop/constants/index.dart';
import 'package:mc00_shop/utils/DioRequest.dart';
import 'package:mc00_shop/viewmodels/user.dart';

Future<UserInfo> loginAPI(Map<String, dynamic> params) async {
  final response = await dioRequest.post(HttpConstants.LOGIN, params: params);
  return UserInfo.fromJSON(response);
}
