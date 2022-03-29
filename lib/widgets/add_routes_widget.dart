import 'package:bus_ticket_app/models/bus_route_bag.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/bus_route.dart';

class AddRoute extends StatefulWidget {
  const AddRoute({Key? key}) : super(key: key);

  static const String routeName = '/add-routes';

  @override
  State<AddRoute> createState() => _AddRouteState();
}

class _AddRouteState extends State<AddRoute> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController _sourceController = TextEditingController();

  final TextEditingController _destinationController = TextEditingController();

  final TextEditingController _priceController = TextEditingController();

  final TextEditingController _seatController = TextEditingController();

  final TextEditingController _timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Source',
              ),
              controller: _sourceController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter source';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Destination',
              ),
              controller: _destinationController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter destination';
                }
                return null;
              },
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Price',
              ),
              controller: _priceController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter price';
                }
                return null;
              },
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'No. of Seats',
              ),
              controller: _seatController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter seats';
                }
                return null;
              },
            ),
            TextButton(
                onPressed: () {
                  showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2101),
                          initialDate: DateTime.now())
                      .then(
                    (value) {
                      setState(() {
                        _timeController.text = value.toString();
                      });
                    },
                  );
                },
                child: _timeController.text.isEmpty
                    ? const Text('Select Time')
                    : Text(_timeController.text)),
            RaisedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  print(_sourceController.text);
                  print(_destinationController.text);
                  print(_priceController.text);
                  print(_seatController.text);
                  print(_timeController.text);

                  Provider.of<BusRouteBag>(context, listen: false).addBusRoute(
                    source: _sourceController.text,
                    destination: _destinationController.text,
                    price: int.parse(_priceController.text),
                    numberOfSeats: int.parse(_seatController.text),
                    time: DateTime.parse(_timeController.text),
                    busNumber: 're',
                  );
                  Navigator.pop(context);
                }
              },
              child: const Text('Add Route'),
            ),
          ],
        ),
      ),
    );
  }
}
