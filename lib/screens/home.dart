import 'package:flutter/material.dart';
import 'package:to_do_app/constants/colors.dart';
import 'package:to_do_app/models/todo.dart';
import 'package:to_do_app/widgets/todo_item.dart';

class Home extends StatefulWidget {
   Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = ToDo.todoList();
  final _todoController = TextEditingController();
  List<ToDo> _foundToDo = [];


  @override
  void initState() {
    _foundToDo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
         appBar: _buildAppBar(),
         body: Stack(
           children: [
             Container(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: Column(
                children: [
                  searchBox(),
                  Expanded(
                    child: ListView(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            top: 20,
                            bottom: 20,
                            ),
                          child: Text('All ToDos', style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500),
                          ),
                        ),
// creating loop for printing the value to the screens
                   // loops for changing the value
                      for( ToDo todo in _foundToDo.reversed)
                        ToDoItem(
                          todo: todo,
                          onToDoChanged: _handleToDoChange,
                          onDeleteitem: _deleteToDoItem,
                          ),
                      ],
                    ),
                  )
                ],
              ),
             ),
             Align(
              alignment: Alignment.bottomCenter,
              child: Row(children: [
                Expanded(child: Container(
                  margin: EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                    left: 20,
                ),
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const[ BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 0.0),
                  blurRadius: 10.0,
                  spreadRadius: 0.0,
                  ),
                  ],
                  borderRadius: BorderRadius.circular(10)
                ),
                child: TextField(
                  controller: _todoController,
                  decoration: InputDecoration(
                    hintText: 'Add a new todo item',
                    border: InputBorder.none
                  ),
                ),
                ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                  ),
                  child: ElevatedButton(
                   child: Text('+', style: TextStyle(fontSize: 40,),),
                   onPressed: () {
                    _addToDoItems(_todoController.text);
                   },
                   style: ElevatedButton.styleFrom(
                    backgroundColor: tdBlue,
                    minimumSize: Size(60, 60),
                    elevation: 10,
                   ),
                   ),
                )
              ],),
             )
           ],
         ),
    );
  }

// creating function for handling the change made by user or add/deleting tasks,

void _handleToDoChange(ToDo todo) {
  setState(() {
    todo.isDone = !todo.isDone;
  });
}

void _deleteToDoItem(String id) {
setState(() {
   todosList.removeWhere((item) => item.id == id);
});
}

void _addToDoItems(String toDo){
  setState(() {
    todosList.add(
      ToDo(id: DateTime.now().millisecondsSinceEpoch.toString(),
       todoText: toDo,
       ));
  });
 _todoController.clear();
}

 void _runFilter(String enteredKeyword) {
  List<ToDo> results = [];
  if (enteredKeyword.isEmpty) {
    results = todosList;
  } else {
    results = todosList.where((item) => 
      item.todoText!.toLowerCase().contains(enteredKeyword.toLowerCase())
    ).toList();
  }

  setState(() {
    _foundToDo = results;
  });
}



 Widget searchBox(){
   return Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: TextField(
                  onChanged: (value) => _runFilter(value),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(0),
                    prefixIcon: Icon(Icons.search,color: tdBlack,size: 20,),
                    prefixIconConstraints: BoxConstraints(maxHeight: 20,minWidth: 25),
                    border: InputBorder.none,
                    hintText: 'Search',
                    hintStyle: TextStyle(color: tdGrey)
                  ),
                ),
              );
 }

  AppBar _buildAppBar() {
    return AppBar(
        backgroundColor: tdBGColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:[
          Icon(
            Icons.menu,
            color: tdBlack,
            size: 30,
            ),
            Container(
              height: 40,
              width: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset('assets/images/avatar.jpg'),
              ),
            )
        ],),
       );
  }
}