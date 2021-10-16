import 'package:flutter/material.dart';
import '../screens/edit_product.dart';

class UserProductItem extends StatelessWidget {
  //const UserProductItem({ Key? key }) : super(key: key);
  final String title;
  final String imageUrl;
  UserProductItem(this.title, this.imageUrl);
  @override
  Widget build(BuildContext context) {
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
                onPressed: () {
                   Navigator.of(context).pushNamed(EditProduct.routeName);
                },
                icon: const Icon(Icons.edit),
                color: Theme.of(context).primaryColor),
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor),
          ],
        ),
      ),
    );
  }
}
