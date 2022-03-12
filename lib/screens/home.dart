import 'package:flutter/material.dart';
import 'package:recipe/screens/drinks.dart';
import 'package:recipe/screens/food.dart';

class Home extends StatefulWidget {

  /// constructor
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final TextEditingController _searchController = TextEditingController();

  Widget _buildItemCat({required String type, required int quantity, required Function() ontap, BoxShape? boxShape,}){
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.only(right: 10, left: 30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                spreadRadius: 2,
                offset: Offset(0, 1),
              ),
            ]
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(type, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                Text("$quantity Items", style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w300))
              ],
            ),
          ),
        ),
        Positioned(
          right: 0,
          child: Container(
            width: 30,
            height: 30,
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  spreadRadius: 3,
                  offset: Offset(0, 1), // Shadow position
                ),
              ],
              shape: BoxShape.circle
            ),
            child: const Icon(Icons.arrow_right_rounded)
          ),
        ),
        Positioned(
          left: 0,
          child: InkWell(
            onTap: ontap,
            child: Container(
              width: 60,
              height: 60,
              decoration:  BoxDecoration(
                color: Colors.white,
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    spreadRadius: 3,
                    offset: Offset(0, 1), // Shadow position
                  ),
                ],
                shape: boxShape != null ? BoxShape.rectangle : BoxShape.circle,
                borderRadius:  boxShape != null ? BorderRadius.circular(20) : null
              ),
              child: const Icon(Icons.arrow_right_rounded)
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Menu", style: TextStyle(fontSize: 25, color: Colors.grey[700]),),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: (){},
            icon: const Icon(Icons.shopping_cart, color: Colors.black,)
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20),
            child:  TextField(
              controller: _searchController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[300],
                prefixIcon: const Icon(Icons.search, color: Colors.grey,),
                hintText: "Search food",
                hintStyle: const TextStyle(color: Colors.grey),
                border: const OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide.none
                )
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    width: 80,
                    height: 400,
                    decoration: const BoxDecoration(
                      color: Color(0xFFb31b1b),
                      borderRadius: BorderRadius.only(topRight: Radius.circular(30), bottomRight: Radius.circular(30))
                    ),
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: _buildItemCat(
                        type:"Food",
                        quantity: 120,
                        ontap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                            return FoodPage();
                          }));
                        },)
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: _buildItemCat(
                        type: "Beverages",
                        quantity: 220,
                        ontap:  (){
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                            return DrinksPage();
                          }));
                        },
                        boxShape: BoxShape.rectangle)
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}