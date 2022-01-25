import "package:flutter/material.dart";
import 'package:intl/intl.dart';


class NewTransaction extends StatefulWidget {
  final Function addTransaction;
  NewTransaction(this.addTransaction);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  // // state-is controli
  // String titleInput = "";
  // String amountInput = ""; 
  // onChange()-is shemcvlelebi
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  var _selectedDate = null;

  void submitData() { // add transaction
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate==null) {
      return;
    }
    // widget daemata mas shemdeg rac gadavida statful-shi
    // amd dros mshoblida tsamogebuli function definicirdeba zeda class-shi
    widget.addTransaction(_titleController.text, double.parse(_amountController.text), _selectedDate);
    // showModalBottomSheet-is daxurva  
    Navigator.of(context).pop();
  }

  void _presentDatePicker(ctx) {
    showDatePicker(
      context: ctx, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(2021),
      lastDate: DateTime.now()
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {  // for update build
        _selectedDate = pickedDate;
      });
      print("${_selectedDate}");
    });
    print("...");
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        // margin: EdgeInsets.all(10),
        padding: EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom + 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Title"),
              // onChanged: (val) => titleInput = val,
              controller: _titleController,
              onSubmitted: (_) => submitData, 
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount"),
              // onChanged: (val) => amountInput = val,
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData,
            ),
            Container(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_selectedDate == null ? 
                    "No date choosen!" :
                    DateFormat.yMd().format(_selectedDate).toString()
                  ),
                  RaisedButton(
                    child: Text("Choose Date", style: TextStyle(fontWeight: FontWeight.bold),),
                    textColor: Theme.of(context).primaryColor,
                    onPressed: () => _presentDatePicker(context),
                  )
                ],
              ),
            ),
            FlatButton(
              child: Text("Add Transaction", style: TextStyle(fontWeight: FontWeight.bold),),
              textColor: Colors.white,
              color: Theme.of(context).primaryColor,
              onPressed: submitData,
              // () {
              //   // print("${titleInput} ${amountInput}");
              //   // print("${titleController.text} ${amountController.text}");
              //   addTransaction(titleController.text, double.parse(amountController.text));
              // },
            )
          ],
        )
      ),
    );
  }
}