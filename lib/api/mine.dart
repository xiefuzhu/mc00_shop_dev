import 'package:mc00_shop/constants/index.dart';
import 'package:mc00_shop/utils/DioRequest.dart';
import 'package:mc00_shop/viewmodels/home.dart';

Future<GoodsDetailItems> getGoodsDetailItemsAPI(
  Map<String, dynamic> params,
) async {
  return GoodsDetailItems.fromJson(
    await dioRequest.get(HttpConstants.GUESS_LIST, params: params),
  );
}
