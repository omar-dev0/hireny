// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seeker.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SeekerAdapter extends TypeAdapter<Seeker> {
  @override
  final int typeId = 0;

  @override
  Seeker read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Seeker(
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
      dob: fields[13] as String?,
      gender: fields[14] as String?,
      title: fields[15] as String?,
      nationality: fields[16] as String?,
      careerLevel: fields[17] as String?,
      employmentStatus: fields[18] as String?,
      brief: fields[19] as String?,
      immediateStart: fields[20] as bool?,
      cv: fields[21] as String?,
    )
      ..accessToken = fields[11] as String?
      ..refreshToken = fields[12] as String?;
  }

  @override
  void write(BinaryWriter writer, Seeker obj) {
    writer
      ..writeByte(22)
      ..writeByte(13)
      ..write(obj.dob)
      ..writeByte(14)
      ..write(obj.gender)
      ..writeByte(15)
      ..write(obj.title)
      ..writeByte(16)
      ..write(obj.nationality)
      ..writeByte(17)
      ..write(obj.careerLevel)
      ..writeByte(18)
      ..write(obj.employmentStatus)
      ..writeByte(19)
      ..write(obj.brief)
      ..writeByte(20)
      ..write(obj.immediateStart)
      ..writeByte(21)
      ..write(obj.cv)
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
      other is SeekerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
