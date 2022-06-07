import 'package:bus_ticket_app/exports.dart';
import 'package:bus_ticket_app/models/bus_route_bag.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectCityScreen extends StatefulWidget {
  const SelectCityScreen({Key? key}) : super(key: key);
  static const String routeName = '/select-city';

  @override
  State<SelectCityScreen> createState() => _SelectCityScreenState();
}

class _SelectCityScreenState extends State<SelectCityScreen> {
  List cities = [
    'Havelli',
  ];
  String _selected = 'Select Source City';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text('Select Destination'),
      ),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Card(
              child: DropdownButton<String>(
                hint: Text(_selected),
                items: cities.map((route) {
                  return DropdownMenuItem<String>(
                    value: route,
                    child: Text(route),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selected = value.toString();
                  });
                },
              ),
            ),
          ),
          FutureBuilder(
            future: Provider.of<BusRouteBag>(context, listen: false)
                .fetchBusRoutes(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                return Consumer<BusRouteBag>(
                  builder: (context, busRouteBag, child) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return Card(
                          child: DropdownButton<String>(
                            hint: const Text('Select Destination City'),
                            items: busRouteBag.busRoutes.map((route) {
                              return DropdownMenuItem<String>(
                                value: route.destination,
                                child: Text(route.destination),
                              );
                            }).toList(),
                            onChanged: (value) {
                              Navigator.of(context).pushNamed(
                                AvailableTicketsScreen.routeName,
                                arguments: value,
                              );
                            },
                            // title: Text(busRouteBag.busRoutes[index].destination),
                            // onTap: () {
                            //   Navigator.of(context).pushNamed(
                            //     AvailableTicketsScreen.routeName,
                            //     arguments:
                            //         busRouteBag.busRoutes[index].destination,
                            //   );
                            // },
                          ),
                        );
                      },
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
