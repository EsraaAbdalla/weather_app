// ignore_for_file: must_be_immutable, avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/cubits/weather_cubit/weather_cubit.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/services/weather_services.dart';

class SearchPage extends StatelessWidget {
  String? cityName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Color(),
        title: const Text('Search a city'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            onChanged: (data) {
              cityName = data;
            },
            onSubmitted: (data) async {
              cityName = data;
              BlocProvider.of<WeatherCubit>(context)
                  .getweather(cityName: cityName!);
              BlocProvider.of<WeatherCubit>(context).cityName = cityName;
              Navigator.pop(context);
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 35,
                horizontal: 24,
              ),
              suffixIcon: GestureDetector(
                onTap: () async {
                  WeatherServices service = WeatherServices();

                  WeatherModel? weather =
                      await service.getweather(cityName: cityName!);
                  BlocProvider.of<WeatherCubit>(context, listen: false)
                      .weatherModel = weather;
                  BlocProvider.of<WeatherCubit>(context, listen: false)
                      .cityName = cityName;

                  Navigator.pop(context);
                },
                child: const Icon(Icons.search),
              ),
              border: const OutlineInputBorder(),
              label: const Text('search'),
              hintText: 'Enter a city',
            ),
          ),
        ),
      ),
    );
  }
}
