import 'package:hive_flutter/hive_flutter.dart';

import '../models/category_model.dart';

class CategoryModelAdapter extends TypeAdapter<CategoryModel> {
  @override
  final int typeId = 14;

  @override
  CategoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return CategoryModel(
      id: fields[0] as String,
      name: fields[1] as String,
      type: fields[2] as String,
      iconCodePoint: fields[3] as int,
      colorValue: fields[4] as int,
      createdAt: fields[5] as DateTime,
      updatedAt: fields[6] as DateTime?,
      isDeleted: fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, CategoryModel obj) {
    writer.writeByte(8);
    writer.writeByte(0);
    writer.writeString(obj.id);
    writer.writeByte(1);
    writer.writeString(obj.name);
    writer.writeByte(2);
    writer.writeString(obj.type);
    writer.writeByte(3);
    writer.writeInt(obj.iconCodePoint);
    writer.writeByte(4);
    writer.writeInt(obj.colorValue);
    writer.writeByte(5);
    writer.write(obj.createdAt);
    writer.writeByte(6);
    writer.write(obj.updatedAt);
    writer.writeByte(7);
    writer.writeBool(obj.isDeleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryModelAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
