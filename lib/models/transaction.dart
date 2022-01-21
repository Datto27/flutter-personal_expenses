import "package:flutter/foundation.dart";

class Transaction {
  String id = "";
  String title = "";
  double amount = 0.0;
  DateTime date = DateTime.now();
  // this._ = default mnishvneloba
  Transaction({@required id, @required title, @required amount, @required date}) {
    this.id = id; 
    this.title = title; 
    this.amount = amount; 
    this.date = date;
  }
}


