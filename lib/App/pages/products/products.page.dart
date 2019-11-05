import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:course_008/App/providers/index.dart';
import 'package:course_008/App/pages/index.dart';
import 'package:course_008/App/widgets/index.dart';

class ProductsPage extends StatelessWidget {
  static const routeName = 'products';

  @override
  Widget build(BuildContext context) {
    // Fetch the products data from firebase and add them to the provider.
    Provider.of<ProductsProvider>(context, listen: false).fetch();
    // this could be done in a couple of methods but this is more clear and less awkward approach for me.
    // for stateful widgets this could be done in initState() but context is inaccessible there so
    // provider should be called with listen:false,
    // also in initState(), using Future, this can be done by using a hack like this;
    // Future.delayed(Duration.zero, (){
    //   Provider.of<ProductsProvider>(context).fetch();
    // });
    // this is working like a defer execution, this future will be executed after initState completed, so
    // inner scope can access context, but again, this feels awkward...
    // another approach wold be using didChangeDependencies(), this method runs right after the widget's initState()
    // and after every build() method that depends on an InheritedWidget/ChangeNotifier/Provider..., so we only need to fetch the data
    // when the widget initialized, for that we have to add a flag to our state and when it is true we're going to ignore the fetch block.
    // bool _isInitialized = false,
    // ...
    // void didChangeDependencies(){
    //    if(!_isIntialized){
    //      Provider.of<ProductsProvider>.of(context, listen:false).fetch();
    //       setstate((){
    //         _isInitialized = true;
    //        });
    //    }
    // }

    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Shop App'),
        actions: <Widget>[
          Consumer<CartProvider>(
            builder: (context, cart, _) => BadgeButton(
              icon: Icons.shopping_cart,
              text: '${cart.count}',
              onPressed: () {
                Navigator.of(context).pushNamed(CartPage.routeName);
              },
            ),
          ),
        ],
      ),
      body: ProductsGrid(),
    );
  }
}
