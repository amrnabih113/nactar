import 'package:flutter/material.dart';
import 'package:nectar/screens/ordersuccess.dart';
import 'package:nectar/services/providermodel.dart';
import 'package:nectar/widgets/Custombutton.dart';
import 'package:provider/provider.dart';

class CheckoutBottomSheet extends StatelessWidget {
  const CheckoutBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 1, // Adjust this factor to control the height
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Checkout',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // List of options
              _buildOptionRow(
                  'Delivery', 'Select Method', Icons.arrow_forward_ios),
              const Divider(),
              _buildOptionRow('Payment', '', Icons.payment),
              const Divider(),
              _buildOptionRow(
                  'Promo Code', 'Pick discount', Icons.arrow_forward_ios),
              const Divider(),
              _buildOptionRow('Total Cost', '\$13.97', Icons.arrow_forward_ios),
              const SizedBox(height: 20),
              // Terms and Conditions
              const Text(
                'By placing an order you agree to our',
                style: TextStyle(color: Colors.grey),
              ),
              GestureDetector(
                onTap: () {
                  // Handle T&C tap
                },
                child: const Text(
                  'Terms and Conditions',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Consumer<Model>(builder: (context, model, child) {
                    return Custombutton(
                        title: "Place Order",
                        theme: "theme1",
                        onPressed: () {
                          model.clearCart();
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const OrderSuccess()),
                          );
                        });
                  }))
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build each option row
  Widget _buildOptionRow(String title, String trailingText, IconData icon) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailingText.isNotEmpty)
            Text(
              trailingText,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          const SizedBox(width: 10),
          Icon(icon, size: 16),
        ],
      ),
      onTap: () {
        // Handle navigation
      },
    );
  }
}
