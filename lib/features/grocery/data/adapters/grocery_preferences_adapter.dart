import 'package:hive_flutter/hive_flutter.dart';

import '../models/grocery_preferences.dart';

class GroceryPreferencesAdapter extends TypeAdapter<GroceryPreferences> {
  @override
  final int typeId = 10;

  @override
  GroceryPreferences read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return GroceryPreferences(
      lastStoreName: fields[0] as String?,
      frequentItems: fields[1] as List<String>,
      maxFrequentItems: fields[2] as int,
      saveLastStore: fields[3] as bool,
      showSuggestions: fields[4] as bool,
      clearOnExit: fields[5] as bool,
      confirmSubmit: fields[6] as bool,
      lastUpdated: fields[7] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, GroceryPreferences obj) {
    writer.writeByte(8);
    writer.writeByte(0);
    writer.write(obj.lastStoreName);
    writer.writeByte(1);
    writer.write(obj.frequentItems);
    writer.writeByte(2);
    writer.writeInt(obj.maxFrequentItems);
    writer.writeByte(3);
    writer.writeBool(obj.saveLastStore);
    writer.writeByte(4);
    writer.writeBool(obj.showSuggestions);
    writer.writeByte(5);
    writer.writeBool(obj.clearOnExit);
    writer.writeByte(6);
    writer.writeBool(obj.confirmSubmit);
    writer.writeByte(7);
    writer.write(obj.lastUpdated);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GroceryPreferencesAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
