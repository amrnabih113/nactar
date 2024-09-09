import 'package:flutter/material.dart';

class ProductPrice extends StatefulWidget {
  ProductPrice({
    super.key,
    required this.quantity,
    required this.price,
    required this.onQuantityChanged,
  });
  int quantity;
  double price;
  final ValueChanged<int> onQuantityChanged;

  @override
  State<ProductPrice> createState() => _ProductPriceState();
}

class _ProductPriceState extends State<ProductPrice> {
  // Method to calculate the total price
  double getTotalPrice() {
    return widget.price * widget.quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 25, left: 15, top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    if (widget.quantity > 1) {
                      widget.quantity--;
                      widget.onQuantityChanged(widget.quantity);
                    }
                  });
                },
                icon: const Icon(Icons.remove),
              ),
              Container(
                width: 45.67,
                height: 45.67,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(17),
                  border: Border.all(
                    width: 2,
                    style: BorderStyle.solid,
                    color: const Color(0xffE2E2E2),
                  ),
                ),
                child: Center(
                  child: Text(
                    "${widget.quantity}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    widget.quantity++;
                    widget.onQuantityChanged(widget.quantity);
                  });
                },
                icon: const Icon(
                  Icons.add,
                  color: Color(0xff53B175),
                ),
              ),
            ],
          ),
          Text(
            "\$${getTotalPrice().toStringAsFixed(2)}",
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
