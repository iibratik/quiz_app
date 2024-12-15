import 'package:flutter/material.dart';
import 'package:questionapp/pages/question.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffedf3f3f6),
      body: SingleChildScrollView(
          child: Container(
        margin: const EdgeInsets.only(bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(children: [
              Container(
                height: 220,
                padding: const EdgeInsets.only(left: 20, top: 50, right: 20),
                decoration: const BoxDecoration(
                    color: Color(0xFF2a2b31),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Image.asset(
                        "assets/img/user_profile.jpg",
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        'Akrom Ibragimov',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(30)),
                margin: const EdgeInsets.only(top: 120, left: 20, right: 20),
                child: Column(
                  children: [
                    ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20)),
                        child: Image.asset("assets/img/main_banner.jpg")),
                    const SizedBox(
                      width: 30,
                    ),
                    const Column(
                      children: [
                        Text(
                          textAlign: TextAlign.center,
                          'Play & Win',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Play Quiz \n by guessing the image',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color(0xFFa4a4a4),
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ]),
            const SizedBox(
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                'Top Quiz Categories',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 23,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Question(
                                    category: "Place",
                                  )));
                    },
                    child: CategoryCard(
                      imageSrc: "assets/img/place.png",
                      cardTitle: "Places",
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Question(
                                    category: "Fruits",
                                  )));
                    },
                    child: CategoryCard(
                      imageSrc: "assets/img/fruit.jpg",
                      cardTitle: "Fruits",
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Question(
                                    category: "Sports",
                                  )));
                    },
                    child: CategoryCard(
                      imageSrc: "assets/img/place.png",
                      cardTitle: "Sports",
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Question(
                                    category: "Place",
                                  )));
                    },
                    child: CategoryCard(
                      imageSrc: "assets/img/place.png",
                      cardTitle: "Places",
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Question(
                                    category: "Place",
                                  )));
                    },
                    child: CategoryCard(
                      imageSrc: "assets/img/place.png",
                      cardTitle: "Places",
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Question(
                                    category: "Place",
                                  )));
                    },
                    child: CategoryCard(
                      imageSrc: "assets/img/place.png",
                      cardTitle: "Places",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String imageSrc;
  final String cardTitle;

  const CategoryCard({
    super.key,
    required this.imageSrc,
    required this.cardTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(20),
      elevation: 5,
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Image.asset(
              imageSrc,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
            Text(
              cardTitle,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
