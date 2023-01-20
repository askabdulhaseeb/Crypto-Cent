import '../database/app_user/auth_method.dart';
import 'time_date_function.dart';

class UniqueIdFunctions {
  static String get postID => '${AuthMethods.uid}${TimeStamp.timestamp}';

  static String get offerID => '${AuthMethods.uid}${TimeStamp.timestamp}';

  static String personalChatID({required String chatWith}) {
    int isGreaterThen = AuthMethods.uid.compareTo(chatWith);
    if (isGreaterThen > 0) {
      return '${AuthMethods.uid}-chats-$chatWith';
    } else {
      return '$chatWith-chats-${AuthMethods.uid}';
    }
  }

  static String chatGroupID() {
    return '${AuthMethods.uid}-group-${TimeStamp.timestamp}';
  }

  static String productID(String pid) {
    return '${AuthMethods.uid}-product-$pid';
  }
}
