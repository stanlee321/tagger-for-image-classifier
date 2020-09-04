  class UserData {
    static final UserData _appData = new UserData._internal();
    
    String uid;
    String email;
    String name;
    String imgUrl;
    
    factory UserData() {
      return _appData;
    }
    UserData._internal();
  }
final userDataSingleton = UserData();
