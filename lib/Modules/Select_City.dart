import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/Models/Cubit.dart';
import 'package:weather_app/Models/States.dart';

import 'Home_Screen.dart';

class SelectCity extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var cityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WeatherCubit,WeatherStates>(
      builder: (BuildContext context, WeatherStates state) {
        var cubit = WeatherCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white10,
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Expanded(child: Image.asset("Icons/result.png",)),

                    Expanded(
                      child: Column(
                        children: [
                          TextFormField(
                            style: TextStyle(color: Colors.grey[200]),
                            keyboardType: TextInputType.text,
                            controller: cityController,

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
                          SizedBox(height: 15.0,),
                          Container(
                            width: double.infinity,

                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(20.0)
                            ),
                            child: MaterialButton(

                              onPressed: (){
                                if(formKey.currentState!.validate()){
                                  cubit.SelectCity(cityController.text);
                                  cubit.GetCityData();

                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(builder: (context)=>HomeScreen()),
                                          (route) => false);
                                }
                              },
                              child: Text("See Temprature",
                                style: TextStyle(
                                    color:
                                    Colors.white
                                ),),
                            ),
                          ),
                        ],
                      ),
                    ),
                   
                   
                    //SizedBox(height: 100,)
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
