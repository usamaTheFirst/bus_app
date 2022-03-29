class TripHistory {
  String source, destination, date, price;

  TripHistory(
      {required this.source,
      required this.destination,
      required this.date,
      required this.price});

  factory TripHistory.fromJSON(Map<String, dynamic> json) => TripHistory(
      source: json['source'],
      destination: json['destination'],
      date: json['date'].toString(),
      price: json['price'].toString());
}
