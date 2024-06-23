class CityData{

  List<Data> data=[];

  CityData.fromJson(List<dynamic> json){
   json.forEach((element) {
     data.add(Data.fromJson(element));
   });
  }
}

class Data{
  String? name;
  double? lat;
  double? lon;
  String? country;
  String? state;

  Data.fromJson(Map<String,dynamic> json){
    name= json['name'];
    lat = json['lat'];
    lon = json['lon'];
    country = json['country'];
    state = json['state'];
  }
}