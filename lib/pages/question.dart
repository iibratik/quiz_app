import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:questionapp/services/datebase.dart';

// ignore: must_be_immutable
class Question extends StatefulWidget {
  String category;
  Question({super.key, required this.category});

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  bool showAnswrs = false;

  getOnTheLoad() async {
    quizStream = await DatabaseMethods().getCategoryQuiz(widget.category);
    setState(() {});
  }

  @override
  void initState() {
    getOnTheLoad();
    super.initState();
  }

  Stream? quizStream;
  PageController controller = PageController();
  Widget allQuiz() {
    return StreamBuilder(
        stream: quizStream,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text(
              'Error: ${snapshot.error}',
              style: TextStyle(color: Colors.white),
            ));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
                child: Text(
              'No quizzes found.',
              style: TextStyle(color: Colors.white),
            ));
          }
          final quizDocs = snapshot.data!.docs;
          return snapshot.hasData
              ? PageView.builder(
                  controller: controller,
                  itemCount: quizDocs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30))),
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 40),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Text(
                                  ds['verb'],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    showAnswrs = true;
                                    setState(() {});
                                  },
                                  child: Option(
                                    ds: ds,
                                    optionName: "option1",
                                    showAnswrs: showAnswrs,
                                  )),
                              SizedBox(height: 20),
                              GestureDetector(
                                  onTap: () {
                                    showAnswrs = true;
                                    setState(() {});
                                  },
                                  child: Option(
                                    ds: ds,
                                    optionName: "option2",
                                    showAnswrs: showAnswrs,
                                  )),
                              SizedBox(height: 20),
                              GestureDetector(
                                  onTap: () {
                                    showAnswrs = true;
                                    setState(() {});
                                  },
                                  child: Option(
                                    ds: ds,
                                    optionName: "option3",
                                    showAnswrs: showAnswrs,
                                  )),
                              SizedBox(height: 20),
                              GestureDetector(
                                  onTap: () {
                                    showAnswrs = true;
                                    setState(() {});
                                  },
                                  child: Option(
                                    ds: ds,
                                    optionName: "option4",
                                    showAnswrs: showAnswrs,
                                  )),
                              SizedBox(height: 20),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    showAnswrs = false;
                                  });
                                  if (controller.page == quizDocs.length - 1) {
                                    // Если это последняя страница, переходим на первую
                                    controller.jumpToPage(0);
                                  } else {
                                    // Иначе переходим на следующую страницу
                                    controller.nextPage(
                                      duration: Duration(milliseconds: 200),
                                      curve: Curves.easeIn,
                                    );
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            border: Border.all(
                                                color: Colors.black)),
                                        child: Icon(
                                          Icons.arrow_forward_ios_outlined,
                                          color: Colors.lightGreen,
                                        )),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  })
              : Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF004840),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50, left: 20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Color(0xFFf35b32),
                          borderRadius: BorderRadius.circular(60)),
                      child: Container(
                        margin: EdgeInsets.only(left: 7),
                        child: Center(
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    widget.category,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(child: allQuiz())
          ],
        ),
      ),
    );
  }
}

class Option extends StatelessWidget {
  const Option(
      {super.key,
      required this.showAnswrs,
      required this.ds,
      required this.optionName});
  final DocumentSnapshot<Object?> ds;
  final bool showAnswrs;
  final String optionName;
  @override
  Widget build(BuildContext context) {
    return showAnswrs
        ? Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                border: Border.all(
                    color: ds["correct"] == ds[optionName]
                        ? Colors.green
                        : Colors.red,
                    width: 1.5),
                borderRadius: BorderRadius.circular(15)),
            child: Text(
              ds[optionName],
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
          )
        : Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF818181), width: 1.5),
                borderRadius: BorderRadius.circular(15)),
            child: Text(
              ds[optionName],
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
          );
  }
}
