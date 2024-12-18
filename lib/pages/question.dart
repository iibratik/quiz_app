import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No quizzes found.'));
          }
          final quizDocs = snapshot.data!.docs;
          return snapshot.hasData
              ? PageView.builder(
                  controller: controller,
                  itemCount: quizDocs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30))),
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 40),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    ds["Image"],
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(height: 20),
                                GestureDetector(
                                  onTap: () {
                                    showAnswrs = true;
                                    setState(() {});
                                  },
                                  child: showAnswrs
                                      ? Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          padding: EdgeInsets.all(15),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: ds["correct"] ==
                                                          ds['option1']
                                                      ? Colors.green
                                                      : Colors.red,
                                                  width: 1.5),
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Text(
                                            ds["option1"],
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        )
                                      : Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          padding: EdgeInsets.all(15),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Color(0xFF818181),
                                                  width: 1.5),
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Text(
                                            ds["option1"],
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                ),
                                SizedBox(height: 20),
                                GestureDetector(
                                  onTap: () {
                                    showAnswrs = true;
                                    setState(() {});
                                  },
                                  child: showAnswrs
                                      ? Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          padding: EdgeInsets.all(15),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: ds["correct"] ==
                                                          ds['option2']
                                                      ? Colors.green
                                                      : Colors.red,
                                                  width: 1.5),
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Text(
                                            ds["option2"],
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        )
                                      : Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          padding: EdgeInsets.all(15),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Color(0xFF818181),
                                                  width: 1.5),
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Text(
                                            ds["option2"],
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                ),
                                SizedBox(height: 20),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      showAnswrs = false;
                                    });
                                    controller.nextPage(
                                        duration: Duration(microseconds: 200),
                                        curve: Curves.bounceIn);
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
                      decoration: BoxDecoration(
                          color: Color(0xFFf35b32),
                          borderRadius: BorderRadius.circular(60)),
                      child: Center(
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 100,
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
