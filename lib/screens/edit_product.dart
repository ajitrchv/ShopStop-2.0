import 'package:flutter/material.dart';
import '../providers/product.dart';

class EditProduct extends StatefulWidget {
  static const routeName = '/edit_product';
  //const EditProduct({Key? key}) : super(key: key);

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final _priceFocusNode = FocusNode();
  final _descFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  String _enteredText = '';
  var _editedProduct =
      Product(id: '', title: '', description: '', price: 0, imageUrl: '');

  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descFocusNode.dispose();
    _imageUrlFocusNode.dispose();

    super.dispose();
  }

  _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
    if(((!_imageUrlController.text.startsWith('http') 
                    && !_imageUrlController.text.startsWith('https')))) {
      return;
    }
    setState(() {});
    }
  }

  void _saveform() {
    final isValid = _form.currentState!.validate();
    if(isValid) {
    _form.currentState!.save();
    print(_editedProduct.title);
    print(_editedProduct.description);
    print(_editedProduct.price);
    print(_editedProduct.imageUrl);
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit'),
        actions: [
          Row(
            children: [
              const Text('Save'),
              IconButton(
                onPressed: _saveform,
                icon: Icon(
                  Icons.save,
                  color: Theme.of(context).primaryColorLight,
                ),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Title', fillColor: Colors.blueGrey),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                onSaved: (value)
                {
                  _editedProduct = Product(
                    id: '', 
                    title: value as String, 
                    description: _editedProduct.description, 
                    price: _editedProduct.price, 
                    imageUrl: _editedProduct.imageUrl
                    );
                },
                validator: (value) {
                  if(value!.isEmpty){
                    return 'Please provide a value.';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Price', fillColor: Colors.blueGrey),
                textInputAction: TextInputAction.next,
                keyboardType: const TextInputType.numberWithOptions(),
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descFocusNode);
                },
                onSaved: (value)
                {
                  _editedProduct = Product(
                    id: '', 
                    title:  _editedProduct.title, 
                    description: _editedProduct.description, 
                    price: double.parse(value!), 
                    imageUrl: _editedProduct.imageUrl
                    );
                },
                validator: (value) {
                  if(value!.isEmpty){
                    return 'Please provide the Amount Details.';
                  }
                  if(double.tryParse(value) == null){
                    return 'Price entered is invalid.';
                  }
                  if(double.parse(value)<=0) {
                    return 'Please enter a price greater than zero.';
                  }
                  return null;
                },
              ),
              TextFormField(
                onChanged: (value) {setState(() {
                  _enteredText= value;

                });
                } ,
                maxLines: 5,
                focusNode: _descFocusNode,
                onSaved: (value)
                {
                  _editedProduct = Product(
                    id: '', 
                    title:  _editedProduct.title, 
                    description: value as String, 
                    price: _editedProduct.price, 
                    imageUrl: _editedProduct.imageUrl,
                    );
                },
                decoration:  InputDecoration(
                    labelText: 'Description',
                    hintMaxLines: 100,
                    fillColor: Colors.blueGrey,
                    counterText: '${_enteredText.length.toString()} charecters.'
                    ),
                
                validator: (value) {
                  if(value!.isEmpty){
                    return 'Please provide any Description.';
                  }
                  if(value.length<10){
                    return 'The description should contain atleast 10 Charecters.';
                  }
                  return null;
                },
                
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.grey,
                        ),
                      ),
                      child: Container(
                        child: _imageUrlController.text.isEmpty
                            ? Text('Enter a URL',
                                style: Theme.of(context).textTheme.headline6)
                            : FittedBox(
                                child: Image.network(
                                  _imageUrlController.text,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Image URL'),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller: _imageUrlController,
                        focusNode: _imageUrlFocusNode,
                        onFieldSubmitted: (_) => _saveform(),
                        onEditingComplete: () {
                          setState(() {});
                        },
                        onSaved: (value)
                {
                  _editedProduct = Product(
                    id: '', 
                    title:  _editedProduct.title, 
                    description: _editedProduct.description, 
                    price: _editedProduct.price, 
                    imageUrl: value as String,
                    );
                },
                validator: (value) {
                  if(value!.isEmpty){
                    return 'Please paste an image URL.';
                  }
                  if(!value.startsWith('http') 
                    && !value.startsWith('https')) {
                    return 'Please enter a valid URL';
                  }
                  return null;
                },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
