import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/weatherModel.dart';
import 'package:weather_app/providers/weaprovider.dart';
import 'package:weather_app/pages/searchpage.dart';


class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

  
   


class _HomePageState extends State<HomePage> {
  void updateUi() {
    setState(() {});
  }
  

  WeatherModel? weatherData;
  @override
  Widget build(BuildContext context) {
    weatherData = Provider.of<WeatherProvider>(context).weatherData;

    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(color: Color.fromARGB(47, 0, 0, 0),padding: EdgeInsets.symmetric(horizontal: 10),
            child: IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SearchFSTPage(
                    updateUi: updateUi,
                  );
                }));
              },
              icon: Icon(Icons.search),
            ),
          ),
        ],
        title: Text('Weather App'),
      ),
      body: Provider.of<WeatherProvider>(context).weatherData == null
          ? Center(
            child:CityWeatherList(),
          )
          : Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  weatherData!.getThemeColor(),
                  weatherData!.getThemeColor()[300]!,
                  weatherData!.getThemeColor()[100]!,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(
                    flex: 3,
                  ),
                  Text(
                    Provider.of<WeatherProvider>(context).cityName!,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'updated at : ${weatherData!.date.hour.toString()}:${weatherData!.date.minute.toString()}',
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(weatherData!.getImage()),
                      Text(
                        weatherData!.temp.toInt().toString(),
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Column(
                        children: [
                          Text('maxTemp :${weatherData!.maxTemp.toInt()}'),
                          Text('minTemp : ${weatherData!.minTemp.toInt()}'),
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  Text(
                    weatherData!.weatherStateName,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(
                    flex: 5,
                  ),
                ],
              ),
            ),
    );
  }
}




class CityWeatherList extends StatelessWidget {
  final List<CityWeather> cities = [
    CityWeather('Berlin', 'Overcast', 13),
    CityWeather('Paris', 'Moderate rain', 12),
    CityWeather('New York', 'Fog', 11),
    CityWeather('Tokyo', 'Sunny', 18),
      CityWeather('Alaska', 'patchy rain possible',16),

  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cities.length,
      itemBuilder: (context, index) {
        return CityWeatherCard(cities[index]);
      },
    );
  }
}

class CityWeather {
  final String name;
  final String condition;
  final int temperature;

  CityWeather(this.name, this.condition, this.temperature);
}

class CityWeatherCard extends StatelessWidget {
  final CityWeather cityWeather;

  CityWeatherCard(this.cityWeather);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(elevation:1,shadowColor: Colors.amber,clipBehavior: Clip.hardEdge,
          child: ListTile(autofocus: true,tileColor: Color.fromARGB(136, 91, 231, 150),
            title: Text(cityWeather.name),
            subtitle: Text('Bedingung: ${cityWeather.condition}\nTemperatur: ${cityWeather.temperature}°C'),
          ),
        ),
       
      ],
    );
}
  
}
