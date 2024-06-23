import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/Models/Cubit.dart';
import 'package:weather_app/Models/States.dart';
import 'package:weather_app/Models/WeatherData.dart';

class HomeScreen extends StatelessWidget {

  DateTime dateTime = DateTime.now();
  var cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WeatherCubit,WeatherStates>(
      builder: (BuildContext context, WeatherStates state) {
        var cubit = WeatherCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.grey[900],
          body: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(top: 5.0,bottom: 5.0,start: 10.0,end: 10.0),
                    child: TextFormField(
                      style: TextStyle(color: Colors.grey[200]),
                      keyboardType: TextInputType.text,
                      controller: cityController,
                      onFieldSubmitted: (value){

                        cubit.map={
                          0:[],
                          1:[],
                          2:[],
                          3:[],
                          4:[],
                          5:[],
                        };
                        cubit.weatherData = null;
                        cubit.cityData = null;
                        cubit.lat = 0;
                        cubit.lon = 0;
                        cubit.SelectCity(cityController.text);
                        cubit.GetCityData();

                      },
                      decoration: InputDecoration(

                        label: Text('Enter your city name',style: TextStyle(color: Colors.grey[200]),),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(20.0)
                        ),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(20.0)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(20.0)
                        ),

                      ),
                    ),
                  ),
                  ConditionalBuilder(
                    condition: cubit.map[cubit.currentInd]!.isNotEmpty,
                    builder: (BuildContext context) {
                      return BuildScreen(cubit , cubit.map[cubit.currentInd]! , dateTime , context, cityController);
                    },
                    fallback: (BuildContext context) {
                      return Center(child: CircularProgressIndicator());
                    },
                       ),
                ],
              ),
            ),
          ),
        );
      },
      listener: (BuildContext context, WeatherStates state) {  },

    );
  }
}

Widget BuildScreen (WeatherCubit cubit , List<wData> data , DateTime dateTime , context , TextEditingController c)=>


  SafeArea(
    child: Padding(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 8.0,vertical: 5.0),
      child: Column(
        children: [



          Stack(
            //alignment: AlignmentDirectional.bottomEnd,
            children: [
              Container(
                width: double.infinity,
                height: 460.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0)

                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                    child: data[0].weather[0].main! == 'Clear' && dateTime.hour >=0 && dateTime.hour < 6 ? Image.asset('Weather/Clear Night.jpg',fit: BoxFit.cover,):
                           data[0].weather[0].main! == 'Clear' && dateTime.hour >=6 && dateTime.hour < 10 ? Image.asset('Weather/Clear Evening.jpg',fit: BoxFit.cover,):
                           data[0].weather[0].main! == 'Clear' && dateTime.hour >=10 && dateTime.hour < 17 ? Image.asset('Weather/Clear Afternoon.jpg',fit: BoxFit.cover,) :
                           data[0].weather[0].main! == 'Clear' && dateTime.hour >=17 && dateTime.hour < 20 ? Image.asset('Weather/Clear mid.jpg',fit: BoxFit.cover,):
                           data[0].weather[0].main! == 'Clear' && dateTime.hour >=20 && dateTime.hour <= 23 ? Image.asset('Weather/Clear Night.jpg',fit: BoxFit.cover,):
                           data[0].weather[0].main! == 'Clouds' ? Image.asset('Weather/Clouds.png',fit: BoxFit.cover,):
                           Image.asset('Weather/Rain.png',fit: BoxFit.cover,)) ,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(start: 20.0,top: 13.0),
                    child:DropdownButton(
                      isDense: false,
                      isExpanded: false,
                      iconDisabledColor: Colors.white,
                      iconEnabledColor: Colors.white,
                      dropdownColor: Colors.grey[800],
                      style: const TextStyle(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10.0),
                      value:cubit.currentInd+dateTime.day,
                      //19 20 21 22 23 24 25
                      //0  1  2  3  4  5  6
                      onChanged: (value){
                        cubit.ChangeInd(value!-dateTime.day);
                        print(cubit.currentInd);
                      },
                      items:[
                        DropdownMenuItem(
                            value: dateTime.day,
                            child: Row(
                              children: [
                                Text('${dateTime.day} ${DateFormat('MMMM').format(dateTime)}, ',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25.0,
                                    fontWeight: FontWeight.w600
                                  ),),
                                Text('${DateFormat('EEEE').format(dateTime)}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25.0,))
                              ],
                            ) ),
                        DropdownMenuItem(
                            value: dateTime.day+1,
                            child: Row(
                              children: [
                                Text('${dateTime.day+1} ${DateFormat('MMMM').format(dateTime)}, ',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25.0,
                                    fontWeight: FontWeight.w600
                                  ),),
                                Text('${DateFormat('EEEE').format(dateTime)}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25.0,))
                              ],
                            ) ),
                        DropdownMenuItem(
                            value: dateTime.day+2,
                            child: Row(
                              children: [
                                Text('${dateTime.day+2} ${DateFormat('MMMM').format(dateTime)}, ',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25.0,
                                    fontWeight: FontWeight.w600
                                  ),),
                                Text('${DateFormat('EEEE').format(dateTime)}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25.0,))
                              ],
                            ) ),
                        DropdownMenuItem(
                            value: dateTime.day+3,
                            child: Row(
                              children: [
                                Text('${dateTime.day+3} ${DateFormat('MMMM').format(dateTime)}, ',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25.0,
                                    fontWeight: FontWeight.w600
                                  ),),
                                Text('${DateFormat('EEEE').format(dateTime)}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25.0,))

                              ],
                            ) ),
                        DropdownMenuItem(
                            value: dateTime.day+4,
                            child: Row(
                              children: [
                                Text('${dateTime.day+4} ${DateFormat('MMMM').format(dateTime)}, ',
                                  style: TextStyle(
                                      color: Colors.white,
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w600
                                  ),),
                                Text('${DateFormat('EEEE').format(dateTime)}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25.0,))

                              ],
                            ) ),
                      ],
                    ) ,
                  ),
                  Padding(
                    padding:  EdgeInsetsDirectional.only(top: 150.0,start: MediaQuery.of(context).size.width-160.0 ),
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.center,

                      children: [
                        //Text('${data[0].weather[0]!.}'),
                        Row(
                          children: [
                            data[0].weather[0].main! == 'Clear' && dateTime.hour >=0 && dateTime.hour < 6 ? Image.asset('Icons/crescent-moon.png',width: 40.0,height: 40.0,):
                            data[0].weather[0].main! == 'Clear' && dateTime.hour >=6 && dateTime.hour < 20 ? Image.asset('Icons/sun.png',width: 40.0,height: 40.0):
                            data[0].weather[0].main! == 'Clear' && dateTime.hour >=20 && dateTime.hour <= 23 ? Image.asset('Icons/crescent-moon.png',width: 30.0,height: 30.0):
                            data[0].weather[0].main! == 'Clouds' && dateTime.hour >=6 && dateTime.hour < 20? Image.asset('Icons/cloudy.png',width: 40.0,height: 40.0):
                            data[0].weather[0].main! == 'Clouds' && dateTime.hour >=0 && dateTime.hour < 6? Image.asset('Icons/moon.png',width: 40.0,height: 40.0):
                            data[0].weather[0].main! == 'Clouds' && dateTime.hour >=20 && dateTime.hour <= 23? Image.asset('Icons/moon.png',width: 40.0,height: 40.0):
                            Image.asset('Icons/raining.png',width: 40.0,height: 40.0),
                            Text('${(data[0].main!.temp-273).round()}°C',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40.0,
                                fontWeight: FontWeight.w400
                              ),),
                          ],
                        ),
                        Text('Feels like ${(data[0].main!.feels_like-273).round()}°C',
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.0,

                          ),),
                      ],
                    ),
                  ),

                  //Spacer(),


                ],
              ),

              Positioned(
                bottom: 20,
                //left: 0,
                right: 20,
                child: Text('${cubit.city.toUpperCase()}',
                    style:TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400
                    ) ,
                  ),
              ),


            ],
          ),

          SizedBox(height: 10.0,),
          Container(
            height: 150.0,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context,index)=> BuildItem(index, data),
                separatorBuilder:(context,index)=> SizedBox(width: 10.0,),
                itemCount: 3),
          ),
          SizedBox(height: 10.0,),

          Container(
            width: double.infinity,
            height:150.0 ,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadiusDirectional.circular(30.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                  itemBuilder: (context , index) {
                    DateTime dateTime1 = DateTime.parse(data[index].dt_txt!);
                      return Container(
                        width: 90.0,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(30.0)
                        ),
                        child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            dateTime1.hour >=0 && dateTime1.hour <12 ? Text('${dateTime1.hour} AM',
                              style: TextStyle(color: Colors.white),
                            ):
                          Text('${dateTime1.hour} PM',
                            style: TextStyle(color: Colors.white), ),

                            SizedBox(height:15.0 ,),

                            data[index].weather[0].main! == 'Clear' && dateTime1.hour >=0 && dateTime1.hour < 6 ? Image.asset('Icons/crescent-moon.png',width: 30.0,height: 30.0,):
                            data[index].weather[0].main! == 'Clear' && dateTime1.hour >=6 && dateTime1.hour < 20 ? Image.asset('Icons/sun.png',width: 30.0,height: 30.0):
                            data[index].weather[0].main! == 'Clear' && dateTime1.hour >=20 && dateTime1.hour <= 23 ? Image.asset('Icons/crescent-moon.png',width: 30.0,height: 30.0):
                            data[index].weather[0].main! == 'Clouds' && dateTime1.hour >=6 && dateTime1.hour < 20? Image.asset('Icons/cloudy.png',width: 30.0,height: 30.0):
                            data[index].weather[0].main! == 'Clouds' && dateTime1.hour >=0 && dateTime1.hour < 6? Image.asset('Icons/moon.png',width: 30.0,height: 30.0):
                            data[index].weather[0].main! == 'Clouds' && dateTime1.hour >=20 && dateTime1.hour <= 23? Image.asset('Icons/moon.png',width: 30.0,height: 30.0):
                            Image.asset('Icons/raining.png',width: 30.0,height: 30.0),

                            SizedBox(height:15.0 ,),

                            Text('${(data[index].main!.temp-273).round()}°C',
                            style: TextStyle(color: Colors.white),),

                          ],
                        ),

                      );},
                  separatorBuilder: (context , index)=> SizedBox(width: 10.0,),
                  itemCount: data.length),
            ),
          ),
        ],
      ),
    ),


);

Widget BuildItem (int ind , List<wData> data)=> Container(
  width: 125.0,
  decoration: BoxDecoration(
      gradient: LinearGradient(
         begin: Alignment.topCenter,
          end: Alignment.bottomLeft,

          colors: [
        MaterialColor(0xFF407DC5, {}),
        MaterialColor(0xFFCA95BA, {})

      ]),
      borderRadius: BorderRadius.circular(30.0)
  ),
  child:
  Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ind==0?Image.asset('Icons/wind.png',width: 30.0,height: 30.0,color: Colors.white,):ind==1 ?Image.asset('Icons/weather.png',width: 30.0,height: 30.0,color: Colors.white):Icon(Icons.water_drop_outlined,color: Colors.white,),
      SizedBox(height: 15.0,),
      ind==0?Text('Wind',style: TextStyle(color: Colors.white),):ind==1 ?Text('Pressure',style: TextStyle(color: Colors.white),):Text('Humidity',style: TextStyle(color: Colors.white),),
      SizedBox(height: 15.0,),
      ind==0?Text('${data[0].wind!.speed} KM',style: TextStyle(
        color: Colors.white
      ),)
          :ind==1 ?Text('${data[0].main!.pressure} MB',style: TextStyle(
color: Colors.white
)):Text('${data[0].main!.humidity}%',style: TextStyle(
color: Colors.white
)),



    ],
  ),

);