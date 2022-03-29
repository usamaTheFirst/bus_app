import 'package:bus_ticket_app/models/bus_route_bag.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../exports.dart';

class EditRoute extends StatefulWidget {
  const EditRoute(
      {this.source,
      this.destination,
      this.price,
      this.time,
      this.busNumber,
      this.numberOfSeats,
      Key? key})
      : super(key: key);

  static const String routeName = '/edit-routes';

  final String? source;
  final String? destination;
  final int? price;
  final Timestamp? time;
  final String? busNumber;
  final int? numberOfSeats;

  @override
  State<EditRoute> createState() => _EditRouteState();
}

class _EditRouteState extends State<EditRoute> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController _sourceController = TextEditingController();

  final TextEditingController _destinationController = TextEditingController();

  final TextEditingController _priceController = TextEditingController();

  final TextEditingController _seatController = TextEditingController();

  final TextEditingController _busNumberController = TextEditingController();

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
              decoration: const InputDecoration(
                labelText: 'Bus Number',
              ),
              controller: _busNumberController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter bus number';
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
                    ? const Text(
                        'Select Time',
                        style: TextStyle(color: kPrimaryColor),
                      )
                    : Text(
                        _timeController.text,
                        style: const TextStyle(color: kPrimaryColor),
                      )),
            RaisedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  print(_sourceController.text);
                  print(_destinationController.text);
                  print(_priceController.text);
                  print(_busNumberController.text);
                  print(_seatController.text);
                  print(_timeController.text);

                  Provider.of<BusRouteBag>(context, listen: false).addBusRoute(
                    source: _sourceController.text,
                    destination: _destinationController.text,
                    price: int.parse(_priceController.text),
                    numberOfSeats: int.parse(_seatController.text),
                    time: Timestamp.fromDate(
                        DateTime.parse(_timeController.text)),
                    busNumber: _busNumberController.text,
                  );
                  Navigator.pop(context);
                }
              },
              child: const Text(
                'Add Route',
                style: TextStyle(color: Colors.white),
              ),
              color: kPrimaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
