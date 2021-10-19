

import 'package:flutter/material.dart';

import '../screens/edit_product.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

class UserProductItem extends StatelessWidget {
  //const UserProductItem({ Key? key }) : super(key: key);
  final String title;
  final String id;
  final String imageUrl;
   
  UserProductItem(this.title, this.imageUrl, this.id);
  @override
  Widget build(BuildContext context) {
    final scaf = Scaffold.of(context);
    return Card(
      elevation: 10,
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        title: Text(title),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                onPressed: () async{
                  try{
                   await Navigator.of(context).pushNamed(EditProduct.routeName, arguments: id);
                  }
                  catch(error){
                    // ignore: deprecated_member_use
                    scaf.showSnackBar(const SnackBar(content: Text('Deleting failed!', textAlign: TextAlign.center,)));
                  }
                },
                icon: const Icon(Icons.edit),
                color: Theme.of(context).primaryColor),
            IconButton(
                onPressed: () {
                  Provider.of<Products>(context, listen: false).deleteProduct(id);
                },
                icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor),
          ],
        ),
      ),
    );
  }
}
