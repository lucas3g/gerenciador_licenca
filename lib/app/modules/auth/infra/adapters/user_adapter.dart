import 'package:gerenciador_licenca/app/modules/auth/domain/entities/user_entity.dart';

class UserAdapter {
  static UserEntity fromMap(dynamic map) {
    return UserEntity(id: map['id'], name: map['name']);
  }
}
