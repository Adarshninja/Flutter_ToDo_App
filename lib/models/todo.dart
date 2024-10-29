class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<ToDo> todoList(){
    return[
      ToDo(id: '01', todoText: 'Morning Exercise', isDone: true),
      ToDo(id: '02', todoText: 'buy Groceries', isDone: true),
      ToDo(id: '03', todoText: 'Check E-mails',),
      ToDo(id: '04', todoText: 'Work on Flutter for 2 hours',),
      ToDo(id: '05', todoText: 'Team Meeting',),
      ToDo(id: '06', todoText: 'Dinner with Pizza',),

    ];
  }

}