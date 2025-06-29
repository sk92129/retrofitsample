// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crytocurrency.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CryptoCurrency _$CryptoCurrencyFromJson(Map<String, dynamic> json) =>
    CryptoCurrency(
      id: json['id'] as String,
      rank: json['rank'] as String,
      symbol: json['symbol'] as String,
      name: json['name'] as String,
      supply: json['supply'] as String,
      maxSupply: json['maxSupply'] as String,
      marketCapUsd: json['marketCapUsd'] as String,
      volumeUsd24Hr: json['volumeUsd24Hr'] as String,
      priceUsd: json['priceUsd'] as String,
      changePercent24Hr: json['changePercent24Hr'] as String,
      vwap24Hr: json['vwap24Hr'] as String,
      explorer: json['explorer'] as String,
    );

Map<String, dynamic> _$CryptoCurrencyToJson(CryptoCurrency instance) =>
    <String, dynamic>{
      'id': instance.id,
      'rank': instance.rank,
      'symbol': instance.symbol,
      'name': instance.name,
      'supply': instance.supply,
      'maxSupply': instance.maxSupply,
      'marketCapUsd': instance.marketCapUsd,
      'volumeUsd24Hr': instance.volumeUsd24Hr,
      'priceUsd': instance.priceUsd,
      'changePercent24Hr': instance.changePercent24Hr,
      'vwap24Hr': instance.vwap24Hr,
      'explorer': instance.explorer,
    };

CryptoCurrencyResponse _$CryptoCurrencyResponseFromJson(
        Map<String, dynamic> json) =>
    CryptoCurrencyResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => CryptoCurrency.fromJson(e as Map<String, dynamic>))
          .toList(),
      timestamp: (json['timestamp'] as num).toInt(),
    );

Map<String, dynamic> _$CryptoCurrencyResponseToJson(
        CryptoCurrencyResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'timestamp': instance.timestamp,
    };
