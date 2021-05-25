import 'dart:io';

import 'package:appreposteria/src/model/user_model.dart';
import 'package:appreposteria/src/provider/firebase_provider.dart';
import '../my_user_repository.dart';

class MyItemRepository extends MyUserRepositoryBase {
  final provider = FirebaseProvider();

  @override
  Future<MyUser?> getMyUser() => provider.getMyUser();

  @override
  Future<void> saveMyUser(MyUser user, File? image) => provider.saveMyUser(user, image);
}