class WeatherData{

  List<wData> weatherData=[];
  CityInfo? cityInfo;
  
  WeatherData.fromJson(Map<String,dynamic>json){
    json['list'].forEach((element) {
      weatherData.add(wData.fromJson(element));
    });
    cityInfo = CityInfo.fromJson(json['city']);
  }
}


class CityInfo{

  String? name;

  CityInfo.fromJson(Map<String,dynamic> json){
    name = json['name'];
  }
}



class wData{
  int? dt;
  Main? main;
  List<Weather> weather=[];
  Wind? wind;
  String? dt_txt;
  
  wData.fromJson(Map<String,dynamic> json){
    dt = json['dt'];
    main = Main.fromJson(json['main']);

    json['weather'].forEach((element){
      weather.add(Weather.fromJson(element));
    });
    
    wind = Wind.fromJson(json['wind']);
    dt_txt = json['dt_txt'];
  }

}

class Main{
  dynamic? temp;
  dynamic? feels_like;
  dynamic? temp_min;
  dynamic? temp_max;
  int? pressure;
  int? humidity;

  Main.fromJson(Map<String,dynamic> json){
   temp = json['temp'];
   feels_like = json['feels_like'];
   temp_min = json['temp_min'];
   temp_max = json['temp_max'];
   pressure = json['pressure'];
   humidity = json['humidity'];

  }

}

class Weather{
  int? id;
  String? main;
  String? description;

  Weather.fromJson(Map<String,dynamic> json){
    id = json['id'];
    main = json['main'];
    description= json['description'];
  }
}

class Wind{

  dynamic? speed;
  int? deg;

  
  Wind.fromJson(Map<String,dynamic> json){
    speed= json['speed'];
    deg = json['deg'];
  }
}