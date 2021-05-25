import 'dart:io';

import 'package:appreposteria/src/model/user_model.dart';

abstract class MyUserRepositoryBase {
  Future<MyUser?> getMyUser();

  Future<void> saveMyUser(MyUser user, File? image);
}