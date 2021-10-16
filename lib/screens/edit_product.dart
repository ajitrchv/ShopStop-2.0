import 'package:flutter/material.dart';

class EditProduct extends StatefulWidget {
  static const routeName = '/edit_product';
  //const EditProduct({Key? key}) : super(key: key);

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final _priceFocusNode = FocusNode();
  final _descFocusNode = FocusNode();
  
  @override
  void dispose(){
    _priceFocusNode.dispose();
    _descFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            child: ListView(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                  labelText: 'Title', 
                  fillColor: Colors.blueGrey),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_){
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                  labelText: 'Price', 
                  fillColor: Colors.blueGrey),
                  textInputAction: TextInputAction.next,
                  keyboardType: const TextInputType.numberWithOptions(),
                  focusNode: _priceFocusNode,
                  onFieldSubmitted: (_){
                    FocusScope.of(context).requestFocus(_descFocusNode);
                  },
                ),

                TextFormField(
                  decoration: const InputDecoration(
                  labelText: 'Description', 
                  hintMaxLines: 100,
                  fillColor: Colors.blueGrey),
                  maxLines: 5,
                  focusNode: _descFocusNode,
                ),

              ],
            ),
          ),
        ));
  }
}
