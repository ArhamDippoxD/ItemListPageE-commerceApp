import 'package:flutter/material.dart';
import 'package:ecommerce/product.dart';

class ItemListPage extends StatefulWidget {
  const ItemListPage({Key? key}) : super(key: key);

  @override
  State<ItemListPage> createState() => _ItemListPageState();
}

class _ItemListPageState extends State<ItemListPage> {
  List<Product> products = [
    Product(name: 'T-shirt', price: 25.0, image: "assets/images/shirtx.jpg", imageWidth: 125, imageHeight: 125, color:'White' ,size: 'M'),
    Product(name: 'Shoes', price: 50.0, image: 'assets/images/shoex.jpg', imageWidth: 125, imageHeight: 125, color: 'Yellow', size: 'S'),
    Product(name: 'Pants', price: 35.0, image: 'assets/images/pantx.jpg', imageWidth: 125, imageHeight: 125, color:'Grey' , size: 'XL'),
  ];

  int totalAmount = 0;

  void _updateTotalAmount(int index, int change) {
    setState(() {
      products[index].quantity = (products[index].quantity + change).clamp(0, double.infinity).toInt();
      totalAmount = products.fold(0, (sum, product) => sum + (product.price * product.quantity).toInt());
    });
  }

  void _showCheckOutDialog() {
    List<String> productDetails = [];

    products.forEach((product) {
      if (product.quantity > 0) {
        productDetails.add('${product.name} (${product.size}): ${product.quantity}');
      }
    });

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(child: const Text('Congratulations!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Text('Proceed to checkout with $totalAmount?')),
              const SizedBox(height: 16),
              Center(child: Text('Product Details:')),
            Center(
              child: Wrap(
                children: [
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: productDetails.map((detail) => Text(detail)).toList(),
                  ),
                ],
              ),
            ),
            ],
          ),
          actions: [
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                    child: const Text("Check Out", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bag', style: TextStyle(fontWeight: FontWeight.bold),),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Container(
        child:
        ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        child: AspectRatio(
                          aspectRatio: 1, // Square shape
                          child: Image.asset(
                            product.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(product.name,style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),

                                PopupMenuButton<String>(
                                  icon: Icon(Icons.more_vert),
                                  onSelected: (value) {
                                    // Handle the selected option
                                    print(value);
                                  },
                                  itemBuilder: (BuildContext context) {
                                    return [
                                      PopupMenuItem<String>(
                                        value: 'option1',
                                        child: Text('Option 1'),
                                      ),
                                      PopupMenuItem<String>(
                                        value: 'option2',
                                        child: Text('Option 2'),
                                      ),
                                      PopupMenuItem<String>(
                                        value: 'option3',
                                        child: Text('Option 3'),
                                      ),
                                    ];
                                  },
                                ),
                              ],
                            ),Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                  children: [
                                    Text(
                                      'Color: ',
                                      style: TextStyle(color: Colors.grey,fontSize: 17),
                                    ),
                                    Text('${product.color}',style: TextStyle(fontSize: 17),),
                                    Text(
                                      '     Size: ',
                                      style: TextStyle(color: Colors.grey,fontSize: 17),
                                    ),
                                    Text('${product.size}',style: TextStyle(fontSize: 17),),

                                  ],
                                ),

                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () => _updateTotalAmount(index, -1),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red.withOpacity(0.8),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: const Icon(Icons.remove, color: Colors.white),
                                    ),
                                  ),
                                ),
                                Text('${product.quantity}', style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold),),
                                InkWell(
                                  onTap: () => _updateTotalAmount(index, 1),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red.withOpacity(0.8),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: const Icon(Icons.add, color: Colors.white),
                                    ),
                                  ),
                                ),

                                Text("${product.price}",style: TextStyle(fontSize: 16),)
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),

      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text('      Total Amount:', style: TextStyle(color: Colors.grey, fontSize: 20),),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('\$$totalAmount', style: TextStyle(color: Colors.black, fontSize: 18),),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            child: ElevatedButton(
              onPressed: _showCheckOutDialog,
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 14),

                child: Text("Check Out", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),
              ),
            ),
          ),
        ],
      ),
    );
  }
}