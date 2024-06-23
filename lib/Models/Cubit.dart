import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/Models/CityData.dart';
import 'package:weather_app/Models/States.dart';
import 'package:weather_app/Models/WeatherData.dart';
import 'package:weather_app/Shared/Dio_Helper.dart';

class WeatherCubit extends Cubit<WeatherStates>{
  WeatherCubit(): super(InitialState());

  static WeatherCubit get(context) =>BlocProvider.of(context);
String city = "cairo";
  WeatherData? weatherData;
  CityData? cityData;
  double lat = 30.0443879;
  double lon = 31.2357257;

  Map<int,List<wData>> map={
    0:[],
    1:[],
    2:[],
    3:[],
    4:[],
    5:[],
  };

  void GetWeatherData() {
    emit(GetWeatherDataLoading());
    DioHelper.GetData(
        url: 'data/2.5/forecast',
        query: {
          'lat': lat,
          'lon' :lon,
          'appid':'583dd6f5691daf685cb7e21b8eb1a397'
        }).then((value) {
          weatherData = WeatherData.fromJson(value.data);
          print(weatherData!.weatherData[1].dt_txt);
          DateTime date = DateTime.now();

          weatherData!.weatherData.forEach((element) {
            DateTime dateTime = DateTime.parse(element.dt_txt!);
            if(date.day == dateTime.day)
            {
              print('iam here');
              map[0]!.add(element);
              print(map[0]![0].dt_txt);
            }
            else if(date.day+1 == dateTime.day)
            {
              map[1]!.add(element);
            }
            else if(date.day+2 == dateTime.day)
            {
              map[2]!.add(element);
            }
            else if(date.day+3 == dateTime.day)
            {
              map[3]!.add(element);
            }
            else if(date.day+4 == dateTime.day)
            {
              map[4]!.add(element);
            }
            else if(date.day+5 == dateTime.day)
            {
              map[5]!.add(element);
            }
          });

          print(map[0]![0].weather[0].main);


          emit(GetWeatherDataSuccess());

    }).catchError((onError){
      print(onError.toString());

      emit(GetWeatherDataError(error: onError.toString()));
    });
}

  void GetCityData(){
    emit(GetCityDataLoading());
    DioHelper.GetData(
        url: 'geo/1.0/direct',
        query: {
          'q':city,
          'appid':'583dd6f5691daf685cb7e21b8eb1a397'
        }).then((value) {
      cityData = CityData.fromJson(value.data);
      lat = cityData!.data[0].lat!;
      lon = cityData!.data[0].lon!;
      // print(cityData!.data[0].name);
      // print(cityData!.data[0].lat);
      // print(cityData!.data[0].lon);
      GetWeatherData();

      emit(GetCityDataSuccess());
    }).catchError((onError){
      print(onError.toString());
      emit(GetCityDataError(error: onError.toString()));
    });
  }

  void SelectCity(String c){
    city = c ;
    emit(SelectCityState());
  }
  int currentInd = 0;
  void ChangeInd (int ind){
    currentInd = ind ;
    emit(ChangeIndexState());
  }
}