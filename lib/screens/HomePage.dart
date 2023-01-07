// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_first_application/screens/individual.dart';
import 'package:flutter_first_application/services/apiServices.dart';
import 'package:flutter_first_application/services/weather.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:alan_voice/alan_voice.dart';
import 'package:loading_animations/loading_animations.dart';
import '../utilities/articelsmodel.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var searchQuery = "latest";
  final PageController controller = PageController();
  _HomepageState() {
    /// Init Alan Button with project key from Alan Studio
    AlanVoice.addButton(
        "519e560738ceeb99a43c0f65ed657f692e956eca572e1d8b807a3e2338fdd0dc/stage",
        buttonAlign: AlanVoice.BUTTON_ALIGN_LEFT);

    /// Handle commands from Alan Studio
    AlanVoice.onCommand.add((command) => _handleCommand(command.data));
  }
  void _handleCommand(Map<String, dynamic> command) {
    switch (command['command']) {
      case 'sports':
        setState(
          () {
            searchQuery = 'sports';
            controller.jumpToPage(1);
          },
        );
        break;
      case 'politics':
        setState(
          () {
            searchQuery = 'politics';
            controller.jumpToPage(1);
          },
        );
        break;
      case 'latest':
        setState(
          () {
            searchQuery = 'latest';
            controller.jumpToPage(1);
          },
        );
        break;
      case 'educational':
        setState(
          () {
            searchQuery = 'educational';
            controller.jumpToPage(1);
          },
        );
        break;
      case 'health':
        setState(
          () {
            searchQuery = 'health';
            controller.jumpToPage(1);
          },
        );
        break;
      case 'finance':
        setState(
          () {
            searchQuery = 'finance';
            controller.jumpToPage(1);
          },
        );
        break;
      case 'entertainment':
        setState(
          () {
            searchQuery = 'entertainment';
            controller.jumpToPage(1);
          },
        );
        break;
      case 'bollywood':
        setState(
          () {
            searchQuery = 'bollywood';
            controller.jumpToPage(1);
          },
        );
        break;
      case 'cricket':
        setState(
          () {
            searchQuery = 'cricket';
            controller.jumpToPage(1);
          },
        );
        break;
    }
  }

  int index = 0;
  ApiServices client = ApiServices();
  var listScrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    // final PageController controller = PageController();
    return Scaffold(
      body: PageView(
        onPageChanged: (page) {
          setState(() {
            index = page;
          });
        },
        controller: controller,
        children: [
          FutureBuilder(
            future: client.getArticle("india"),
            builder:
                (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
              if (snapshot.hasData) {
                List<Article>? newsData = snapshot.data;
                return SingleChildScrollView(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => IndiPage(
                            author: newsData[0].author,
                            description: newsData[0].description,
                            content: newsData[0].content,
                            publishedAt: newsData[0].publishedAt,
                            title: newsData[0].title,
                            url: newsData[0].url,
                            urlToImage: newsData[0].urlToImage,
                          ),
                        ),
                      );
                    },
                    child: Column(
                      verticalDirection: VerticalDirection.down,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: Stack(
                            children: [
                              SizedBox(
                                height:
                                  MediaQuery.of(context).size.height * 0.3,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: Image.network(
                                    newsData![0].urlToImage as String,
                                    height: MediaQuery.of(context).size.height *
                                        0.3,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      const Color.fromARGB(255, 247, 247, 247)
                                          .withOpacity(0.0),
                                      const Color.fromARGB(255, 91, 0, 140),
                                    ],
                                  ),
                                ),
                              ),

                              // news of the day buttton
                              Container(
                                width: 150,
                                height: 40,
                                margin: const EdgeInsets.fromLTRB(30, 50, 0, 0),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: const Center(
                                  child: Text(
                                    "News of the day",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),

                              Column(
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.115,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Text(
                                      "${newsData[0].title}",
                                      maxLines: 3,
                                      overflow: TextOverflow.fade,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 15, 5, 0),
                          child: Stack(
                            children: [
                              SizedBox(
                                height: 60,
                                child: TextField(
                                  onChanged: (value) => {
                                    searchQuery = value,
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor:
                                        const Color.fromARGB(255, 228, 228, 228),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide.none,
                                    ),
                                    hintText: "Search for news here",
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: SizedBox(
                                  height: 60,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          controller.jumpToPage(1);
                                        });
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                const Color.fromARGB(
                                                    255, 91, 0, 140)),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                        ),
                                      ),
                                      child: const Icon(Icons.search_outlined)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 200,
                          width: (MediaQuery.of(context).size.width),
                          margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 240, 240, 240),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: const CWeather(),
                        ),
                        const Text(
                          "- Top news -",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 91, 0, 140)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Container(
                            height: 200,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: ListView(
                              controller: listScrollController,
                              scrollDirection: Axis.horizontal,
                              children: newsData.map((item) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => IndiPage(
                                          author: item.author,
                                          description: item.description,
                                          content: item.content,
                                          publishedAt: item.publishedAt,
                                          title: item.title,
                                          url: item.url,
                                          urlToImage: item.urlToImage,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Stack(children: [
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      height: 200,
                                      width: 160,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        child: Image.network(
                                          item.urlToImage ??
                                              "https://www.google.com/url?sa=i&url=https%3A%2F%2Funsplash.com%2Fs%2Fphotos%2Fwhite&psig=AOvVaw0i4DsAfbXSvJxV2ovFyKRx&ust=1671035012769000&source=images&cd=vfe&ved=0CA8QjRxqFwoTCLChnNSA9_sCFQAAAAAdAAAAABAE",
                                          height: 200,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20)),
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            const Color.fromARGB(
                                                    255, 247, 247, 247)
                                                .withOpacity(0),
                                            const Color.fromARGB(
                                                255, 91, 0, 140),
                                          ],
                                        ),
                                      ),
                                      width: 160,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                    ),
                                    Column(
                                      children: [
                                        const SizedBox(
                                          height: 60,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(20),
                                          width: 180,
                                          child: Text(
                                            item.title as String,
                                            maxLines: 4,
                                            overflow: TextOverflow.fade,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ]),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return Center(
                child: LoadingBouncingLine.circle(),
              );
            },
          ),
          Scaffold(
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            body: Container(
              padding: const EdgeInsets.all(20),
              child: FutureBuilder(
                future: client.getArticle(searchQuery),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Article>> snapshot) {
                  if (snapshot.hasData) {
                    List<Article>? newsData = snapshot.data;
                    return SingleChildScrollView(
                      child: Column(
                        verticalDirection: VerticalDirection.down,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Center(
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.85,
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: ListView(
                                scrollDirection: Axis.vertical,
                                children: newsData!.map((item) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => IndiPage(
                                            author: item.author,
                                            description: item.description,
                                            content: item.content,
                                            publishedAt: item.publishedAt,
                                            title: item.title,
                                            url: item.url,
                                            urlToImage: item.urlToImage,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Stack(children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 5),
                                        height: 200,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          child: Image.network(
                                            item.urlToImage ??
                                                "https://www.google.com/url?sa=i&url=https%3A%2F%2Funsplash.com%2Fs%2Fphotos%2Fwhite&psig=AOvVaw0i4DsAfbXSvJxV2ovFyKRx&ust=1671035012769000&source=images&cd=vfe&ved=0CA8QjRxqFwoTCLChnNSA9_sCFQAAAAAdAAAAABAE",
                                            height: 300,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 200,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20)),
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              const Color.fromARGB(
                                                      255, 247, 247, 247)
                                                  .withOpacity(0),
                                              const Color.fromARGB(
                                                  255, 91, 0, 140),
                                            ],
                                          ),
                                        ),
                                        // width: 160,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 5),
                                      ),
                                      Column(
                                        children: [
                                          const SizedBox(
                                            height: 130,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(20),
                                            // width: 180,
                                            child: Text(
                                              item.title as String,
                                              maxLines: 4,
                                              overflow: TextOverflow.fade,
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ]),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return Center(
                    child: LoadingBouncingLine.circle(),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 217, 163, 255),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )),
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 1),
        child: GNav(
          selectedIndex: index,
          onTabChange: (index) {
            setState(() {
              controller.jumpToPage(index);
            });
          },
          iconSize: 15,
          activeColor: const Color.fromARGB(255, 91, 0, 140),
          tabBackgroundColor: const Color.fromARGB(255, 226, 186, 255),
          gap: 7,
          hoverColor: Colors.black45,
          tabs: const [
            GButton(
              icon: Icons.home,
              text: "Home",
            ),
            GButton(
              icon: Icons.search,
              text: "search",
            ),
            GButton(
              icon: Icons.person,
              text: "account",
            ),
            GButton(
              icon: Icons.adjust,
              text: "settings",
            ),
          ],
        ),
      ),
    );
  }
}
