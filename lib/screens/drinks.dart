import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:recipe/model/model_food.dart';

class DrinksPage extends StatefulWidget {
  DrinksPage({Key? key}) : super(key: key);

  @override
  State<DrinksPage> createState() => _DrinksPageState();
}

class _DrinksPageState extends State<DrinksPage> {
  late List<Widget> _categoryList = [];

  @override
  void initState() {
    super.initState();
  }

  Future<List<Food>> _getData() async {
      final response = await http.get(Uri.parse('https://www.themealdb.com/api/json/v1/1/categories.php'));

      if (response.statusCode == 200) {
        final parsed = json.decode(response.body)["categories"].cast<Map<String, dynamic>>();

        return parsed.map<Food>((json) => Food.fromMap(json)).toList();
      } else {
        throw Exception('Failed to load album');
      }
  }


  void _buildListCategory(List<Food> food){

    for (var i = 0; i < food.length; i++) {
      _categoryList.add(
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Column(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[300]
                ),
                child: Image.network(food[i].thumbnailUrl),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(food[i].title),
              )
            ],
          ),
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Good Morning Akila!", style: TextStyle(fontSize: 25, color: Colors.grey[700]),),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: (){},
            icon: const Icon(Icons.shopping_cart, color: Colors.black,)
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text("Delivering to", style: TextStyle(fontSize: 12, color: Colors.grey),),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text("Current Location", style: TextStyle(fontSize: 18, color: Colors.grey[700]),),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child:  TextField(
                //controller: _searchController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[300],
                  prefixIcon: const Icon(Icons.search, color: Colors.grey,),
                  hintText: "Search Drink",
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: const OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide.none
                  )
                ),
              ),
            ),
            SizedBox(
              height: 150,
              child: FutureBuilder<List<Food>>(
                future: _getData(),
                builder: (context, AsyncSnapshot<List<Food>> snapshot) {
                  if (snapshot.hasData) {
                    _buildListCategory(snapshot.data!);
                    return ListView(
                      scrollDirection: Axis.horizontal,
                      children: _categoryList,
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            )
          ],
        ),
      )
    );
  }
}