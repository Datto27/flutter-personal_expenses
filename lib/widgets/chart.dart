import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import './chart_bar.dart';


class Chart extends StatelessWidget {
  final List recentTransactions;
  Chart(this.recentTransactions);

  // transactions dalageba dgeebis mixedvit
  List<Map> get groupedTransactionValues {
    // ganvlili shvidi dgis sia da misi monacemebi
    return List.generate(7, (index) {  // 7 elementiani listis shemqmna
      final weekDay = DateTime.now().subtract(Duration(days: index));  // dgeebi, 
      var totalSum = 0.0;
      // transactions-shi gavla da im im transaction-is amount-is tsamogeba romelic emtxveva shesabamis dges
      for (var i=0; i<recentTransactions.length; i++) { 
        // print("Compare dates: ${recentTransactions[i].date.day} ${weekDay.day}");
        if (recentTransactions[i].date.day == weekDay.day && 
            recentTransactions[i].date.month == weekDay.month && 
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      
      return {"day": DateFormat.E().format(weekDay), "amount": totalSum};
    
    }).reversed.toList();
  }

  double get totalSpending {
    // print("grouped list: ${groupedTransactionValues}");

    return groupedTransactionValues.fold(0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(groupedTransactionValues);

    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Container(
        height: 110,
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: groupedTransactionValues.map((data) {
            return ChartBar(
              label: data["day"], 
              spendingAmount: data["amount"], 
              spendingPctOfTotal: totalSpending == 0.0 ? 0.0 : data["amount"] / totalSpending
            );
          }).toList(),
        ),
      ),
    );
  }
}