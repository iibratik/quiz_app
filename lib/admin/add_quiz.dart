import 'package:flutter/material.dart';
import 'package:questionapp/services/datebase.dart';

class AddQuiz extends StatefulWidget {
  const AddQuiz({super.key});

  @override
  State<AddQuiz> createState() => _AddQuizState();
}

class _AddQuizState extends State<AddQuiz> {
  Future uploadItem() async {
    if (option1controller.text != "" &&
        option2controller.text != '' &&
        option3controller.text != "" &&
        option4controller.text != "") {
      Map<String, dynamic> addQuiz = {
        "verb": verbcontroller.text,
        "option1": option1controller.text,
        "option2": option2controller.text,
        "option3": option3controller.text,
        "option4": option4controller.text,
        "correct": correctOption,
      };
      await DatabaseMethods()
          .addQuizCategory(addQuiz, currentCategoryValue!)
          .then((value) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Quiz created successfuly",
              style: TextStyle(fontSize: 18),
            )));
      });
    }
  }

  String? currentCategoryValue;
  bool isLoading = false;

  final List<String> categoryItems = [
    'Presente',
    'Passato-remoto',
    'Passato-prossimo',
    'Trapassato-remoto',
    'Imperfetto',
    'Futuro',
    'Trapassato-prossimo',
    'Futuro-anteriore',
  ];
  TextEditingController verbcontroller = TextEditingController();
  TextEditingController option1controller = TextEditingController();
  TextEditingController option2controller = TextEditingController();
  TextEditingController option3controller = TextEditingController();
  TextEditingController option4controller = TextEditingController();
  String? correctOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Add Quiz",
          style: TextStyle(
              color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: isLoading
            ? SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Center(child: CircularProgressIndicator()),
              )
            : Container(
                margin:
                    EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Create new Quiz",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Verb",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Color(0xFFececf8),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        controller: verbcontroller,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Insert your verb",
                          hintStyle: TextStyle(
                              color: Colors.black38,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Option 1",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Color(0xFFececf8),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        controller: option1controller,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Insert option 1",
                          hintStyle: TextStyle(
                              color: Colors.black38,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Option 2",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Color(0xFFececf8),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        controller: option2controller,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Insert option 2",
                          hintStyle: TextStyle(
                              color: Colors.black38,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Option 3",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Color(0xFFececf8),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        controller: option3controller,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Insert option 3",
                          hintStyle: TextStyle(
                              color: Colors.black38,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Option 4",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Color(0xFFececf8),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        controller: option4controller,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Insert option 4",
                          hintStyle: TextStyle(
                              color: Colors.black38,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Select correct option",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Color(0xFFececF8),
                          borderRadius: BorderRadius.circular(10)),
                      child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                        dropdownColor: Colors.white,
                        iconSize: 36,
                        value: correctOption,
                        icon: Icon(Icons.arrow_drop_down),
                        hint: Text("Select correct option"),
                        items: _buildDropdownItems(
                            option1controller.text,
                            option2controller.text,
                            option3controller.text,
                            option4controller.text),
                        onChanged: (value) {
                          setState(() {
                            correctOption =
                                value; // Сохраняем выбранное значение
                          });
                        },
                      )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Select Category",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Color(0xFFececF8),
                          borderRadius: BorderRadius.circular(10)),
                      child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                              dropdownColor: Colors.white,
                              iconSize: 36,
                              value: currentCategoryValue,
                              icon: Icon(Icons.arrow_drop_down),
                              hint: Text("Select Category"),
                              items: categoryItems
                                  .map((item) => DropdownMenuItem(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.black),
                                      )))
                                  .toList(),
                              onChanged: (value) => {
                                    setState(() {
                                      currentCategoryValue = value;
                                    })
                                  })),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () async {
                        setState(() {
                          isLoading = true;
                        });
                        await uploadItem();
                        await Future.delayed(Duration(seconds: 1));
                        Route route = MaterialPageRoute(
                            builder: (context) => const AddQuiz());
                        Navigator.pushReplacement(context, route);
                        setState(() {
                          isLoading = true;
                        });
                      },
                      child: Center(
                        child: Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            width: 150,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                "Submit",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }

  List<DropdownMenuItem<String>> _buildDropdownItems(
      String option1, String option2, String option3, String option4) {
    // Собираем значения из контроллеров в список
    List<String> options = [
      option1,
      option2,
      option3,
      option4,
    ]
        .where((option) => option.toString().isNotEmpty)
        .toList(); // Убираем пустые строки

    // Преобразуем их в DropdownMenuItem
    return options
        .map(
          (item) => DropdownMenuItem(
            value: item,
            child: Text(
              item,
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          ),
        )
        .toList();
  }
}
