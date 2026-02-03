// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grocery_preferences.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

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
      frequentItems: (fields[1] as List).cast<String>(),
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
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.lastStoreName)
      ..writeByte(1)
      ..write(obj.frequentItems)
      ..writeByte(2)
      ..write(obj.maxFrequentItems)
      ..writeByte(3)
      ..write(obj.saveLastStore)
      ..writeByte(4)
      ..write(obj.showSuggestions)
      ..writeByte(5)
      ..write(obj.clearOnExit)
      ..writeByte(6)
      ..write(obj.confirmSubmit)
      ..writeByte(7)
      ..write(obj.lastUpdated);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GroceryPreferencesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GroceryPreferencesImpl _$$GroceryPreferencesImplFromJson(
        Map<String, dynamic> json) =>
    _$GroceryPreferencesImpl(
      lastStoreName: json['lastStoreName'] as String?,
      frequentItems: (json['frequentItems'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      maxFrequentItems: (json['maxFrequentItems'] as num?)?.toInt() ?? 20,
      saveLastStore: json['saveLastStore'] as bool? ?? true,
      showSuggestions: json['showSuggestions'] as bool? ?? true,
      clearOnExit: json['clearOnExit'] as bool? ?? false,
      confirmSubmit: json['confirmSubmit'] as bool? ?? true,
      lastUpdated: json['lastUpdated'] == null
          ? null
          : DateTime.parse(json['lastUpdated'] as String),
    );

Map<String, dynamic> _$$GroceryPreferencesImplToJson(
        _$GroceryPreferencesImpl instance) =>
    <String, dynamic>{
      'lastStoreName': instance.lastStoreName,
      'frequentItems': instance.frequentItems,
      'maxFrequentItems': instance.maxFrequentItems,
      'saveLastStore': instance.saveLastStore,
      'showSuggestions': instance.showSuggestions,
      'clearOnExit': instance.clearOnExit,
      'confirmSubmit': instance.confirmSubmit,
      'lastUpdated': instance.lastUpdated?.toIso8601String(),
    };
