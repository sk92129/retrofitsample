import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:retrofitsample/model/crytocurrency.dart';

part 'api_client.g.dart';

const _apiKey =
    '305ae7fa2f751acd65d11e950bbbec3f5b7608b7858b62f04b43de441e967adb';

@RestApi(baseUrl: 'https://rest.coincap.io/v3?apiKey=$_apiKey')
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET('/assets')
  Future<CryptoCurrencyResponse> getCryptoCurrencies();

  @GET('/assets/{id}')
  Future<CryptoCurrency> getCryptoCurrency(@Path('id') String id);
}
