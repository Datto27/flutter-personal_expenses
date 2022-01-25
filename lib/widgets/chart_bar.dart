import 'package:flutter/material.dart';


class ChartBar extends StatelessWidget {
  String label;
  double spendingAmount;
  double spendingPctOfTotal;  // total percentage of total sendings
  ChartBar({this.label="", this.spendingAmount=0, this.spendingPctOfTotal=0});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Column(
          children: [
            FittedBox(
              child: Text("\$ ${spendingAmount.toStringAsFixed(0)}")
            ),
            SizedBox(height: 4),
            Container(
              height: 50,
              width: 10,
              child: Stack(  // 3d widget, ertmanetze dalageba children-ebis
                children: [
                  // cariali diagrama
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      color: Color.fromRGBO(220, 220, 220, 1),  // light grey
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  // lurji ferit shevseba
                  FractionallySizedBox(  // create a box that is sized as fraction of another value 
                    heightFactor: spendingPctOfTotal,  // parent widgetis spendingPctOfTotal procentis natsili 
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10)
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 4,),
            Text(label)
          ],
        );
      }
    );
  }
}