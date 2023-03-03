import 'package:immich_mobile/shared/models/album.dart';
import 'package:immich_mobile/utils/hash.dart';
import 'package:isar/isar.dart';
import 'package:openapi/api.dart';

part 'user.g.dart';

@Collection(inheritance: false)
class User {
  User({
    required this.id,
    required this.updatedAt,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.isAdmin,
  });

  Id get isarId => fastHash(id);

  User.fromDto(UserResponseDto dto)
      : id = dto.id,
        updatedAt = dto.updatedAt != null
            ? DateTime.parse(dto.updatedAt!).toUtc()
            : DateTime.now().toUtc(),
        email = dto.email,
        firstName = dto.firstName,
        lastName = dto.lastName,
        isAdmin = dto.isAdmin;

  @Index(unique: true, replace: false, type: IndexType.hash)
  String id;
  DateTime updatedAt;
  String email;
  String firstName;
  String lastName;
  bool isAdmin;
  @Backlink(to: 'owner')
  final IsarLinks<Album> albums = IsarLinks<Album>();
  @Backlink(to: 'sharedUsers')
  final IsarLinks<Album> sharedAlbums = IsarLinks<Album>();

  @override
  bool operator ==(other) {
    if (other is! User) return false;
    return id == other.id &&
        updatedAt == other.updatedAt &&
        email == other.email &&
        firstName == other.firstName &&
        lastName == other.lastName &&
        isAdmin == other.isAdmin;
  }

  @override
  @ignore
  int get hashCode =>
      id.hashCode ^
      updatedAt.hashCode ^
      email.hashCode ^
      firstName.hashCode ^
      lastName.hashCode ^
      isAdmin.hashCode;
}
