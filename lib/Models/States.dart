abstract class WeatherStates {}

class InitialState extends WeatherStates{}

class GetWeatherDataLoading extends WeatherStates {}
class GetWeatherDataSuccess extends WeatherStates {}
class GetWeatherDataError extends WeatherStates {
  String error;
  GetWeatherDataError({required this.error});
}

class GetCityDataLoading extends WeatherStates {}
class GetCityDataSuccess extends WeatherStates {}
class GetCityDataError extends WeatherStates {
  String error;
  GetCityDataError({required this.error});
}

class SelectCityState extends WeatherStates{}

class ChangeIndexState extends WeatherStates{}