import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>{
  dynamic city = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Weather app'),
        centerTitle: true,
      ),
      body:
      Container(
        height: 750,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: NetworkImage("https://designimages.appypie.com/appbackground/appbackground-65-nature-outdoors.jpg"),
              fit: BoxFit.fill
          ),
        ),

        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    FutureBuilder(
                        future: apicall(city.text),
                        builder: (context,snapshot){
                          if(snapshot.hasData){
                            return Container(
                                margin: const EdgeInsets.all(0.0),
                                padding: const EdgeInsets.all(10.0),
                                height: 450,
                                decoration: BoxDecoration(
                                  border: Border.all(width: 5, color: Colors.white),
                                 ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 210,
                                        height: 50,
                                        child:
                                          TextField(
                                            onChanged: (text) => {},
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontFamily: 'Arial',
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                            controller: city,
                                            decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10.0),
                                                borderSide: BorderSide(width: 2, color: Colors.blueAccent),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(50.0),
                                                borderSide: BorderSide(
                                                    width: 2, color: Colors.blueAccent),
                                              ),
                                              prefixIcon: Icon(
                                                Icons.search,
                                                color: Colors.white70,
                                              ),
                                              hintText: 'Enter a city name',
                                              hintStyle:
                                                TextStyle( color: Colors.white, fontSize: 15),
                                              fillColor: Colors.blue,
                                              filled: true,
                                            ),
                                          ),
                                      ),
                                      Text('    '),
                                      ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            future:
                                            apicall(city.text);
                                          });
                                        },
                                        child: const Text(
                                          'Search',
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.black,
                                              fontFamily: 'Arial',
                                              fontWeight: FontWeight.bold),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue[50],
                                          shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                  color: Colors.blueAccent,
                                                  width: 1,
                                                  style: BorderStyle.solid),
                                              borderRadius:
                                              BorderRadius.circular(50.0)),
                                          padding: EdgeInsets.all(10.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if(snapshot.data['main'].toString() == 'Clouds' )
                                        const Icon(
                                          Icons.cloud,
                                          color: Colors.white,
                                          size: 75,
                                      )
                                      else if (snapshot.data['main'].toString() == 'Mist' || snapshot.data['main'].toString() == 'Haze' || snapshot.data['main'].toString() == 'Fog') ...[
                                        const Icon(Icons.foggy,
                                            color: Colors.white,
                                            size: 75),
                                      ]
                                      else if (snapshot.data['main']
                                            .toString() ==
                                            'Snow') ...[
                                          const Icon(Icons.cloudy_snowing,
                                              color: Colors.white, size: 80),
                                        ]
                                      else if(snapshot.data['main'] == 'Clear' || snapshot.data['main'] == 'Sunny')
                                        const Icon(
                                          Icons.sunny,
                                          color: Colors.yellowAccent,
                                          size: 75,
                                        )
                                      else if(snapshot.data['main'] == 'Smoke')
                                          const Icon(
                                            Icons.smoking_rooms_sharp,
                                            color: Colors.grey,
                                            size: 75,
                                          )
                                      else ...[
                                          const Icon(
                                            Icons.cloud,
                                            color: Colors.black38,
                                            size: 60,
                                          ),
                                            const Icon(
                                              Icons.water_drop_outlined,
                                              color: Colors.black38,
                                              size: 60,
                                            )
                                        ]
                                    ],
                                  ),
                                  Text(snapshot.data['main'].toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15,
                                  ),
                                  ),
                                  Text('_______________________________________',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if(city.text == '')
                                        Text('BANGALORE',
                                          style: TextStyle(
                                            fontSize: 35,
                                            fontFamily: 'arial',
                                            color: Colors.white,
                                          ),
                                        )
                                      else
                                        Text((city.text).toUpperCase(),
                                          style: TextStyle(

                                            fontSize: 35,
                                            fontFamily: 'arial',
                                            color: Colors.white,
                                          ),
                                        ),
                                    ],
                                  ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        // Text(
                                        //   'Temperature: ',
                                        //   style: TextStyle(
                                        //       fontSize: 20,
                                        //       fontFamily: 'arial',
                                        //       color: Colors.white,
                                        //       fontWeight: FontWeight.normal),
                                        // ),
                                        Text(
                                          (snapshot.data['temp']-273).toStringAsFixed(2)+'°C',
                                          style: TextStyle(
                                              fontSize: 30,
                                              fontFamily: 'arial',
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Feels Like: ',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: 'arial',
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        Text(
                                          (snapshot.data['feels_like']-273).toStringAsFixed(2)+'°C',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: 'arial',
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Minimum: ',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'arial',
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      Text(
                                        (snapshot.data['temp_min']-273).toStringAsFixed(2)+'°C',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'arial',
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Maximum: ',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'arial',
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      Text(
                                        (snapshot.data['temp_max']-273).toStringAsFixed(2)+'°C',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'arial',
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Pressure: ',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'arial',
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      Text(
                                        snapshot.data['pressure'].toString(),
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'arial',
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Humidity: ',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'arial',
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      Text(
                                        snapshot.data['humidity'].toString()+'%',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'arial',
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }
                          // else{
                          //   return CircularProgressIndicator();
                          // }
                          else {
                            return Expanded(
                              child: SnackBar(
                                content: Text('Invalid city name'),
                                action: SnackBarAction(
                                  label: 'Retry',
                                  onPressed: () {},
                                ),
                              ),
                            );
                          }
                        })
                ],
              ),
            ),
          ),
        ),
    );
  }
}

Future apicall(String city) async {
  if (city == '')
    city = 'bangalore';
  final url = Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=c232e1374147996efa80f08d75210b16");
  //final url = Uri.parse(host: "https://api.openweather.org",);
  final response = await http.get(url);
  print(response.body);
  final json = jsonDecode(response.body);
  print(json['weather'][0]['description']);

  final output = {
    'main' : json['weather'][0]['main'],
    'temp' : json['main']['temp'],
    'feels_like' : json['main']['feels_like'],
    'temp_min' : json['main']['temp_min'],
    'temp_max' : json['main']['temp_max'],
    'pressure' : json['main']['pressure'],
    'humidity' : json['main']['humidity']
  };
  return output;
}
