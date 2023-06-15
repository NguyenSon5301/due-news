class UserInfoManager {
  UserInfoManager._();
  static final _ins = UserInfoManager._();
  static UserInfoManager get ins => _ins;

  String idStudent = '';
  String tokenDevice = '';
}
