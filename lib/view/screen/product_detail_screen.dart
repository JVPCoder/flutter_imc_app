import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductDetailsPage extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final nutriments = product['nutriments'] ?? {};

    return Scaffold(
      appBar: AppBar(title: Text(product['product_name'] ?? 'Produto')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nome: ${product['product_name'] ?? 'Desconhecido'}',
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            Text('Informações Nutricionais (por 100g):', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Calorias: ${nutriments['energy-kcal'] ?? 'N/A'} kcal'),
            Text('Açúcar: ${nutriments['sugars'] ?? 'N/A'} g'),
            Text('Gorduras: ${nutriments['fat'] ?? 'N/A'} g'),
            Text('Proteínas: ${nutriments['proteins'] ?? 'N/A'} g'),
            Text('Sal: ${nutriments['salt'] ?? 'N/A'} g'),
          ],
        ),
      ),
    );
  }
}
