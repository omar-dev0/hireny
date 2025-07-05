// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 22;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      id: fields[0] as num?,
      firstName: fields[1] as String?,
      lastName: fields[2] as String?,
      email: fields[3] as String?,
      phone: fields[4] as String?,
      role: fields[5] as String?,
      country: fields[6] as String?,
      city: fields[7] as String?,
      links: (fields[8] as List?)?.cast<UserLink?>(),
      updatesToEmail: fields[9] as bool?,
      photo: fields[10] as String?,
    )
      ..accessToken = fields[11] as String?
      ..refreshToken = fields[12] as String?;
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.phone)
      ..writeByte(5)
      ..write(obj.role)
      ..writeByte(6)
      ..write(obj.country)
      ..writeByte(7)
      ..write(obj.city)
      ..writeByte(8)
      ..write(obj.links)
      ..writeByte(9)
      ..write(obj.updatesToEmail)
      ..writeByte(10)
      ..write(obj.photo)
      ..writeByte(11)
      ..write(obj.accessToken)
      ..writeByte(12)
      ..write(obj.refreshToken);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
