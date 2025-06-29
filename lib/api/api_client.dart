import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:retrofitsample/model/crytocurrency.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: 'https://rest.coincap.io/v3')
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET('/assets')
  Future<CryptoCurrencyResponse> getCryptoCurrencies();

  @GET('/assets/{id}')
  Future<CryptoCurrency> getCryptoCurrency(@Path('id') String id);
}
