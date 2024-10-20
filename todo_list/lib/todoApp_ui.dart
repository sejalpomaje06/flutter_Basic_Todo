import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/todoApp_model.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  ///Controllers
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  ///List To fill the Object using the Model Class
  List<TodoModel> todocards = [];

  ///List of Colors
  List<Color> listofColors = [
    const Color.fromRGBO(250, 232, 232, 1),
    const Color.fromRGBO(232, 237, 250, 1),
    const Color.fromRGBO(250, 249, 232, 1),
    const Color.fromRGBO(250, 232, 250, 1),
  ];

  ///Submit Logic
  void submit(bool doEdit, [TodoModel? todoObj]) {
    ///todoObj is a optinal parameter in which object is fill in this and used for edit logic
    ///bool doEdit is true when after edit clicking submit button

    ///condition if textfill is not empty
    if (titleController.text.trim().isNotEmpty &&
        descriptionController.text.trim().isNotEmpty &&
        dateController.text.trim().isNotEmpty) {
      if (doEdit) {
        ///EDIT
        ///edit kelela textfield madhe jo data ahe object madhe fill karaycha
        todoObj!.title = titleController.text;
        todoObj.description = descriptionController.text;
        todoObj.date = dateController.text;
      } else {
        ///NEW CARD
        ///Object madhe new Card data textfiled madhala fill karaycha
        todocards.add(TodoModel(
            title: titleController.text,
            description: descriptionController.text,
            date: dateController.text));
      }
    }

    ///Bottom sheet pop
    Navigator.of(context).pop();

    ///All Controllers Clear
    clearControllers();
    setState(() {});
  }

  void clearControllers() {
    titleController.clear();
    descriptionController.clear();
    dateController.clear();
  }

  ///SHOW BOTTOM SHEET

  void showBottomSheet(bool doEdit, [TodoModel? todoObj]) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(

                ///TextField and KeyBoard overlap hou naye mhanun viewInsets use kelay
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 12,
                right: 12,
                top: 12),
            child: Column(
              ///Jitka Data Enter Karu BottomSheet madhe Only titkich Minimum space Ghenar
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Create Task",
                      style: GoogleFonts.quicksand(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ],
                ),

                ///TITLE
                Text("Title",
                    style: GoogleFonts.quicksand(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromRGBO(0, 139, 148, 1.0),
                    )),
                TextField(
                  controller: titleController,

                  ///bInding controller
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(0, 139, 148, 1.0),
                          ))),
                ),
                const SizedBox(
                  height: 20,
                ),

                ///DESCRIPTION
                Text("Description",
                    style: GoogleFonts.quicksand(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromRGBO(0, 139, 148, 1.0),
                    )),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 9),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(0, 139, 148, 1.0),
                          ))),
                ),
                const SizedBox(
                  height: 20,
                ),

                ///DATE
                Text("Date",
                    style: GoogleFonts.quicksand(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromRGBO(0, 139, 148, 1.0),
                    )),
                TextField(
                  controller: dateController,
                  decoration: InputDecoration(
                      //hintText: "Date",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color.fromRGBO(0, 139, 148, 1.0),
                        ),
                      ),
                      suffix: GestureDetector(
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                firstDate: DateTime(2024),
                                lastDate: DateTime(2025));
                            String formattedDate =
                                DateFormat.yMMMd().format(pickedDate!);

                            ///for Dateformate add the dependency intl
                            setState(() {
                              dateController.text = formattedDate;
                            });
                          },
                          child: const Icon(Icons.calendar_month_outlined))),
                ),
                const SizedBox(
                  height: 10,
                ),

                //LOGIC FOR SUBMIT BUTTON
                ElevatedButton(
                  onPressed: () {
                    if (doEdit == true) {
                      submit(true, todoObj);
                    } else {
                      submit(false);
                    }
                  },
                  child: Center(
                    child: Text("SUBMIT",
                        style: GoogleFonts.quicksand(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black)),
                  ),
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      Color.fromRGBO(0, 139, 148, 1.0),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        ///APPBAR
        title: Text(
          "To-do list",
          style: GoogleFonts.quicksand(
            fontWeight: FontWeight.w700,
            fontSize: 26,
            color: const Color.fromRGBO(255, 255, 255, 1),
          ),
        ),
        backgroundColor: const Color.fromRGBO(2, 167, 177, 1),
      ),

      ///LISTVIEW BUILDER
      body: ListView.builder(
          itemCount: todocards.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
              child: Container(
                decoration: BoxDecoration(
                  ///colors from list of colors
                  color: listofColors[index % listofColors.length],

                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(
                        0,
                        10,
                      ),
                      color: Color.fromRGBO(0, 0, 0, 0.1),
                      blurRadius: 10,
                    )
                  ],

                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 52,
                            width: 52,
                            decoration: const BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                            child: Padding(
                              padding: const EdgeInsets.all(10),

                              ///IMAGE
                              child: SvgPicture.asset("assets/svg/image.svg"),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  //fill title from todocards
                                  todocards[index].title,
                                  style: GoogleFonts.quicksand(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    color: const Color.fromRGBO(0, 0, 0, 1),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  //fill description from todocards
                                  todocards[index].description,
                                  style: GoogleFonts.quicksand(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 10,
                                    color: const Color.fromRGBO(84, 84, 84, 1),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text(
                            //fill date from todocards
                            todocards[index].date,
                            style: GoogleFonts.quicksand(
                              fontWeight: FontWeight.w500,
                              fontSize: 10,
                              color: const Color.fromRGBO(132, 132, 132, 1),
                            ),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  titleController.text = todocards[index].title;
                                  descriptionController.text =
                                      todocards[index].description;
                                  dateController.text = todocards[index].date;
                                  showBottomSheet(
                                    true,
                                    todocards[index],
                                  );
                                },
                                child: const Icon(
                                  Icons.edit_outlined,
                                  color: Color.fromRGBO(2, 167, 177, 1),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),

                              ///DELETE BUTTON
                              GestureDetector(
                                onTap: () {
                                  todocards.remove(todocards[index]);
                                  setState(() {});
                                },
                                child: const Icon(
                                  Icons.delete_outlined,
                                  color: Color.fromRGBO(2, 167, 177, 1),
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ///NEW CARD
          showBottomSheet(false);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Color.fromRGBO(2, 167, 177, 1),
        shape: const CircleBorder(),
      ),
    );
  }
}
