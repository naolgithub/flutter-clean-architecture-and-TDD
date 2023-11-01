import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:weather_clean_architecture_tdd/data/data_sources/remote_data_source.dart';
import 'package:weather_clean_architecture_tdd/domain/repository/weather_repository.dart';
import 'package:weather_clean_architecture_tdd/domain/usecases/get_current_weather.dart';
//To create a mock weather repository we
//must use the generate mocks annotation
//from the mockito package

@GenerateMocks(
  [
    //we are entering the name of the class
    //we wanna mock
    WeatherRepository,
    WeatherRemoteDataSource,
    GetCurrentWeatherUseCase
  ],
  customMocks: [
    //There is also a mock for the http library
    //so that it can simulate requests to the api during test
    //and we can add as the follows:

    MockSpec<http.Client>(as: #MockHttpClient)
  ],
)
void main() {}
