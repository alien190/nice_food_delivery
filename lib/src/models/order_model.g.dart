// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map json) {
  return OrderModel(
    cardSum: json['cardSum'] == null
        ? null
        : CardSumModel.fromJson((json['cardSum'] as Map)?.map(
            (k, e) => MapEntry(k as String, e),
          )),
    dateTime: json['dateTime'] as int,
    items: (json['items'] as List)
        ?.map((e) => e == null
            ? null
            : CardItemModel.fromJson((e as Map)?.map(
                (k, e) => MapEntry(k as String, e),
              )))
        ?.toList(),
    status: _$enumDecodeNullable(_$OrderStatusEnumMap, json['status']),
    lon: (json['lon'] as num)?.toDouble(),
    lat: (json['lat'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'items': instance.items?.map((e) => e?.toJson())?.toList(),
      'cardSum': instance.cardSum?.toJson(),
      'dateTime': instance.dateTime,
      'status': _$OrderStatusEnumMap[instance.status],
      'lon': instance.lon,
      'lat': instance.lat,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$OrderStatusEnumMap = {
  OrderStatus.Placed: 'Placed',
  OrderStatus.InProgress: 'InProgress',
  OrderStatus.Done: 'Done',
};
