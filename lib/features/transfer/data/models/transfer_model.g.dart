// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransferModelAdapter extends TypeAdapter<TransferModel> {
  @override
  final int typeId = 4;

  @override
  TransferModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransferModel(
      id: fields[0] as String,
      amount: fields[1] as double,
      fromAccount: fields[2] as String,
      toAccount: fields[3] as String,
      date: fields[4] as DateTime,
      fee: fields[5] as double,
      note: fields[6] as String?,
      createdAt: fields[7] as DateTime,
      updatedAt: fields[8] as DateTime?,
      metadata: (fields[9] as Map?)?.cast<String, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, TransferModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.fromAccount)
      ..writeByte(3)
      ..write(obj.toAccount)
      ..writeByte(4)
      ..write(obj.date)
      ..writeByte(5)
      ..write(obj.fee)
      ..writeByte(6)
      ..write(obj.note)
      ..writeByte(7)
      ..write(obj.createdAt)
      ..writeByte(8)
      ..write(obj.updatedAt)
      ..writeByte(9)
      ..write(obj.metadata);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransferModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransferModelImpl _$$TransferModelImplFromJson(Map<String, dynamic> json) =>
    _$TransferModelImpl(
      id: json['id'] as String,
      amount: (json['amount'] as num).toDouble(),
      fromAccount: json['fromAccount'] as String,
      toAccount: json['toAccount'] as String,
      date: DateTime.parse(json['date'] as String),
      fee: (json['fee'] as num?)?.toDouble() ?? 0.0,
      note: json['note'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$TransferModelImplToJson(_$TransferModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'fromAccount': instance.fromAccount,
      'toAccount': instance.toAccount,
      'date': instance.date.toIso8601String(),
      'fee': instance.fee,
      'note': instance.note,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'metadata': instance.metadata,
    };
