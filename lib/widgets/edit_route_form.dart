import 'package:bus_ticket_app/models/bus_route_bag.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../exports.dart';

class EditRoute extends StatefulWidget {
  EditRoute(
      {this.source,
      this.destination,
      this.price,
      this.time,
      this.busNumber,
      this.numberOfSeats,
      Key? key,
      this.id})
      : super(key: key);

  static const String routeName = '/edit-routes';

  late String? source;
  late String? destination;
  late int? price;
  late Timestamp? time;
  late String? busNumber;
  late int? numberOfSeats;
  late String? id;

  @override
  State<EditRoute> createState() => _EditRouteState();
}

class _EditRouteState extends State<EditRoute> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              initialValue: widget.source,
              decoration: const InputDecoration(
                labelText: 'Source',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter source';
                }
                return null;
              },
              onSaved: (value) {
                widget.source = value;
              },
            ),
            TextFormField(
              initialValue: widget.destination,
              decoration: const InputDecoration(
                labelText: 'Destination',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter destination';
                }
                return null;
              },
              onSaved: (value) {
                widget.destination = value;
              },
            ),
            TextFormField(
              initialValue: widget.price?.toString(),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Price',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter price';
                }
                return null;
              },
              onSaved: (value) {
                widget.price = int.parse(value!);
              },
            ),
            TextFormField(
              initialValue: widget.busNumber,
              decoration: const InputDecoration(
                labelText: 'Bus Number',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter bus number';
                }
                return null;
              },
              onSaved: (value) {
                widget.busNumber = value;
              },
            ),
            TextFormField(
              initialValue: widget.numberOfSeats?.toString(),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'No. of Seats',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter seats';
                }
                return null;
              },
              onSaved: (value) {
                widget.numberOfSeats = int.parse(value!);
              },
            ),
            TextButton(
                onPressed: () {
                  showDatePicker(
                          context: context,
                          lastDate: DateTime(2101),
                          initialDate: DateTime.fromMillisecondsSinceEpoch(
                              widget.time!.millisecondsSinceEpoch),
                          firstDate: DateTime.fromMillisecondsSinceEpoch(
                              widget.time!.millisecondsSinceEpoch))
                      .then(
                    (value) {
                      setState(() {
                        widget.time = Timestamp.fromDate(value!);
                      });
                    },
                  );
                },
                child: Text(
                  widget.time.toString(),
                  style: const TextStyle(color: kPrimaryColor),
                )),
            RaisedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  Provider.of<BusRouteBag>(context, listen: false)
                      .updateBusRoute(
                    source: widget.source.toString(),
                    destination: widget.destination.toString(),
                    price: int.parse(widget.price.toString()),
                    numberOfSeats: int.parse(widget.numberOfSeats.toString()),
                    time: Timestamp.fromDate(widget.time!.toDate()),
                    busNumber: widget.busNumber.toString(),
                    routeId: widget.id.toString(),
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
