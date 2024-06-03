import 'package:flutter/material.dart';

class CheckoutBottomSheet extends StatefulWidget {
  const CheckoutBottomSheet({ Key? key }) : super(key: key);

  @override
  _CheckoutBottomSheetState createState() => _CheckoutBottomSheetState();
}

class _CheckoutBottomSheetState extends State<CheckoutBottomSheet> {
   final TextEditingController _quantityController = TextEditingController(text: '1');

    void _incrementQuantity() {
    int currentQuantity = int.tryParse(_quantityController.text) ?? 1;
    setState(() {
      _quantityController.text = (currentQuantity + 1).toString();
    });
  }

  void _decrementQuantity() {
    int currentQuantity = int.tryParse(_quantityController.text) ?? 1;
    if (currentQuantity > 1) {
      setState(() {
        _quantityController.text = (currentQuantity - 1).toString();
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Add to cart',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: Text('Quantity')),
                
                Container(
                  width: 50,
                  child: TextField(
                    controller: _quantityController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    inputFormatters: [
                      // Only allow positive integers
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: _decrementQuantity,
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _incrementQuantity,
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('ADD TO CART (\$${235 * int.parse(_quantityController.text)})'),
            ),
          ],
        ),
      ),
    );
  }
}