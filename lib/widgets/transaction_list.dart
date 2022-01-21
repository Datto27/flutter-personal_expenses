import 'dart:js';

import 'package:flutter/material.dart';
import "package:intl/intl.dart";
import "../models/transaction.dart";


class TransactionList extends StatelessWidget {
  // get passed argument from user_transactions
  final List transactions;
  final Function deleteTr;
  TransactionList(this.transactions, this.deleteTr);
  

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 500,  // imisatvis rom listView-ze ar daerorrdes aucilebelia simaglis gatsera
      // conditional rendering
      child: transactions.isEmpty ? 
        Container(
          height: 400,
          width: double.infinity,
          child: Text("charts not defaind yet!"),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/horror_japanese.jpg"),
              fit: BoxFit.cover,
            )
          ),
        )
      : 
        ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (context, i) {
            return Card(  // single transaction
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(  // marcxena mxare
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).primaryColor, 
                        width: 2
                      )
                    ),
                    child: Text(
                      '\$ ${transactions[i].amount.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  Column(  // marjvena mxare
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transactions[i].title,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        DateFormat().format(transactions[i].date),
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    color: Theme.of(context).errorColor,
                    onPressed: () => deleteTr(transactions[i].id),
                  )
                ],
              ),
            );
          }
        ),
    );
  }
}