// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

//  classes
import '../classes/Config.dart';
import '../classes/Utils.dart';

class ListExample1_Page extends StatefulWidget {
  // const ListExample1_Page({super.key});
  const ListExample1_Page({Key? key}) : super(key: key);

  @override
  State<ListExample1_Page> createState() => _ListExample1_PageState();
}

class _ListExample1_PageState extends State<ListExample1_Page> {
  // (this page) variables
  final String filename = 'ListExample1_Page.dart';  
  final List<int> items = List<int>.generate(30, (int index) => index);

  // (this page) methods
  void _buildTriggered() {
    Utils.log( filename, '_buildTriggered()');
  }  

 @override
  Widget build(BuildContext context) {
    
    _buildTriggered();
    
    return WillPopScope(
      onWillPop: () async {
        Utils.log( filename, 'pop()!');
        return true;  //  this allows the back button to work (if true)
      },  
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text( filename ),
            centerTitle: true,
          ), 
          body: ReorderableListView(
            children: List.generate(
              items.length,
              (index) => ListTile(
                key: ValueKey(index),
                title: Text( 'Item ${items[index]}'),
                trailing: const Icon(Icons.drag_handle_sharp),
                shape: Border(
                  bottom: BorderSide(),
                ),                
              ),
              
            ),
            onReorder : (int oldIndex, int newIndex) {
              setState(() {
                if( oldIndex < newIndex ) {
                  newIndex -= -1;
                }
                final int item = items.removeAt(oldIndex);
                items.insert(newIndex, item);                
              });              
            },
          ),
        ),
      ),
    );
  }
}