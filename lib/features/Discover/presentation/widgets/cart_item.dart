import 'package:flutter/material.dart';

class CartItem {
  final String name;
  final String brand;
  final String color;
  final int size;
  final double price;
  int quantity;

  CartItem({
    required this.name,
    required this.brand,
    required this.color,
    required this.size,
    required this.price,
    required this.quantity,
  });
}

class CartItemWidget extends StatelessWidget {
  final CartItem item;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  CartItemWidget({
    required this.item,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            color: Colors.grey[200],
            // Add image widget here, for example: Image.network(item.imageUrl)
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('${item.brand} . ${item.color} . ${item.size}',
                    style: TextStyle(color: Colors.grey)),
                SizedBox(height: 4),
                Row(
                  children: [
                    Text('\$${item.price.toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                        Spacer(),
                    IconButton(
                      icon: Icon(Icons.remove_circle_outline),
                      onPressed: onDecrement,
                    ),
                    Text('${item.quantity}', style: TextStyle(fontSize: 16)),
                    IconButton(
                      icon: Icon(Icons.add_circle_outline),
                      onPressed: onIncrement,
                    ),
                  ],
                )
              ],
            ),
          ),
          Row(
            children: [],
          ),
        ],
      ),
    );
  }
}
