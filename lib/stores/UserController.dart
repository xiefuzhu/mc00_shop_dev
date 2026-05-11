import 'package:get/get.dart';
import 'package:mc00_shop/viewmodels/user.dart';

class Usercontroller extends GetxController {
  var user = UserInfo.fromJSON({}).obs; //user对象被监听了
  //想要取值的话需要user.value
  updateUserInfo(UserInfo newUser) {
    user.value = newUser; //更新user对象的值
  }
}
