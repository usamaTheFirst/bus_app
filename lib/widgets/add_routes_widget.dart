import 'package:bus_ticket_app/models/bus_route_bag.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../exports.dart';

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

  final TextEditingController _busNumberController = TextEditingController();

  final TextEditingController _timeController = TextEditingController();

  DateTime? dateTime;
  DateTime? date;

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
                        //_timeController.text = value.toString();
                        date = DateTime(value!.year, value.month, value.day);
                      });
                    },
                  );
                },
                child: date == null
                    ? const Text(
                        'Select Date',
                        style: TextStyle(color: kPrimaryColor),
                      )
                    : Text(
                        DateFormat("dd-MM-yyyy").format(date!).toString(),
                        style: const TextStyle(color: kPrimaryColor),
                      )),
            TextButton(
                onPressed: () {
                  showTimePicker(context: context, initialTime: TimeOfDay.now())
                      .then(
                    (value) {
                      setState(() {
                        dateTime = DateTime(date!.year, date!.month, date!.day,
                            value!.hour, value.minute);
                      });
                    },
                  );
                },
                child: dateTime == null
                    ? const Text(
                        'Select Time',
                        style: TextStyle(color: kPrimaryColor),
                      )
                    : Text(
                        DateFormat.jm().format(dateTime!).toString(),
                        style: const TextStyle(color: kPrimaryColor),
                      )),
            RaisedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  print(_sourceController.text);
                  print(_destinationController.text);
                  print(_priceController.text);
                  print(_seatController.text);
                  print(_busNumberController.text);
                  print(DateFormat.yMd().add_jm().format(date!).toString());

                  Provider.of<BusRouteBag>(context, listen: false).addBusRoute(
                    source: _sourceController.text,
                    destination: _destinationController.text,
                    price: int.parse(_priceController.text),
                    numberOfSeats: int.parse(_seatController.text),
                    time: Timestamp.fromDate(dateTime!),
                    busNumber: _priceController.text,
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
