import 'models/user.dart';

class UserHolder {
  Map<String, User> users = {};

  void registerUser(String name, String phone, String email) {
    User user = User(name: name, phone: phone, email: email);

    if (!users.containsKey(user.login)) {
      users[user.login] = user;
    } else {
      throw Exception("A user with this name already exists!");
    }
  }

  User getUserByLogin(String login) {
    if (users.containsKey(login)) {
      return users[login];
    }
  }

  User registerUserByEmail(String fullName, String email) {
    User user = User(name: fullName, email: email);

    if (!users.containsKey(user.login)) {
      users[user.login] = user;
    } else {
      throw Exception("A user with this email already exists");
    }

    return user;
  }

  User registerUserByPhone(String fullName, String phone) {
    User user = User(name: fullName, phone: phone);

    if (!users.containsKey(user.login)) {
      users[user.login] = user;
    } else {
      throw Exception("A user with this phone already exists");
    }

    return user;
  }

  void setFriends(String login, List<User> friends) {
    users[login].friends.addAll(friends);
  }

  User findUserInFriends(String login, User friend) =>
      users[login].friends.contains(friend) ? friend : throw Exception('');

  List<User> importUsers(List<String> list) => list
      .map((lines) => lines
      .split(';')
      .map((line) => line.trim())
      .where((element) => element.isNotEmpty)
      .toList())
      .map((lines) => User(name: lines[0], email: lines[1], phone: lines[2]))
      .toList();
}
