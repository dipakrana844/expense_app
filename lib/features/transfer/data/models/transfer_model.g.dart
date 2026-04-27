// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TransferModel _$TransferModelFromJson(Map<String, dynamic> json) =>
    _TransferModel(
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

Map<String, dynamic> _$TransferModelToJson(_TransferModel instance) =>
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
