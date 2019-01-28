import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:sink/redux/actions.dart';
import 'package:sink/redux/state.dart';

class CategoryForm extends StatefulWidget {
  @override
  CategoryFormState createState() {
    return new CategoryFormState();
  }
}

class CategoryFormState extends State<CategoryForm> {
  String category;

  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      converter: _CategoryFormViewModel.fromState,
      builder: (context, vm) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).backgroundColor,
            title: Text('New Category'),
            actions: <Widget>[
              IconButton(
                iconSize: 28.0,
                icon: Icon(Icons.check),
                onPressed: () {
                  vm.onSave(category);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          body: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  //TODO: create a custom component with clear icon on the right
                  onChanged: (value) {
                    setState(() {
                      category = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Category name",
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                  maxLength: 24,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CategoryFormViewModel {
  final Function(String) onSave;

  _CategoryFormViewModel({@required this.onSave});

  static _CategoryFormViewModel fromState(Store<AppState> store) {
    return _CategoryFormViewModel(onSave: (category) {
      store.dispatch(CreateCategory(category));
    });
  }
}