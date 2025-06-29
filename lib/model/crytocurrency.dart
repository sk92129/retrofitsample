import 'package:json_annotation/json_annotation.dart';

part 'crytocurrency.g.dart';

@JsonSerializable()
class CryptoCurrency {
  final String id;
  final String rank;
  final String symbol;
  final String name;
  final String supply;
  final String maxSupply;
  final String marketCapUsd;
  final String volumeUsd24Hr;
  final String priceUsd;
  final String changePercent24Hr;
  final String vwap24Hr;
  final String explorer;

  CryptoCurrency({
    required this.id,
    required this.rank,
    required this.symbol,
    required this.name,
    required this.supply,
    required this.maxSupply,
    required this.marketCapUsd,
    required this.volumeUsd24Hr,
    required this.priceUsd,
    required this.changePercent24Hr,
    required this.vwap24Hr,
    required this.explorer,
  });

  factory CryptoCurrency.fromJson(Map<String, dynamic> json) =>
      _$CryptoCurrencyFromJson(json);
  Map<String, dynamic> toJson() => _$CryptoCurrencyToJson(this);
}

@JsonSerializable()
class CryptoCurrencyResponse {
  final List<CryptoCurrency> data;
  final int timestamp;

  CryptoCurrencyResponse({required this.data, required this.timestamp});

  factory CryptoCurrencyResponse.fromJson(Map<String, dynamic> json) =>
      _$CryptoCurrencyResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CryptoCurrencyResponseToJson(this);
}
