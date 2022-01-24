import 'package:TenTwelveBlood/src/applications/state/about_us/about_us_state.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          " আমাদের সম্পর্কে ",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.pink,
      ),
      // endDrawer: PkEndDrawer(),
      body: AboutUsListTeam(),
    );
  }
}

class AboutUsListTeam extends StatefulWidget {
  @override
  _AboutUsListTeamState createState() => _AboutUsListTeamState();
}

class _AboutUsListTeamState extends State<AboutUsListTeam> {
  final _aboutUsState = RM.get<AboutUsState>();
  ScrollController _scrollController;

  @override
  void didChangeDependencies() {
    _getAboutUsList();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          _aboutUsState.state.loading) {
        _getAboutUsList();
      }
    });
    super.didChangeDependencies();
  }

  void _getAboutUsList() {
    _aboutUsState.setState((s) => s.getAllAboutUsList(1));
  }

  //  @override
  // void dispose() {
  //   _aboutUsState.setState((s) => s.setStateClear());
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StateBuilder<AboutUsState>(
        observe: () => _aboutUsState,
        builder: (context, model) {
          return (model.state.aboutUsList.length > 0)
              ? GridView.count(
                  crossAxisCount: 2,
                  children: <Widget>[
                    ...model.state.aboutUsList.map(
                      (about) => Center(
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: FlipCard(
                            direction: FlipDirection.HORIZONTAL,
                            front: FrontCard(imageUrl: about.picture ?? ''),
                            back: BackCard(
                                name: about.name,
                                color: Colors.deepOrange,
                                designation: about.designation,
                                pkRole: about.role),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              : Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.pink,
                  ),
                );
        },
      ),
    );
  }
}

class FrontCard extends StatelessWidget {
  final String imageUrl;
  const FrontCard({Key key, this.imageUrl}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Image.network(
        imageUrl,
        fit: BoxFit.fill,
        height: 250,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}

class BackCard extends StatelessWidget {
  final String name;
  final String designation;
  final String pkRole;
  final MaterialColor color;
  const BackCard(
      {Key key, this.name, this.color, this.designation, this.pkRole})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      elevation: 10,
      child: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Padding(
                  padding: EdgeInsets.all(2),
                  child: Text(
                    pkRole,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.all(2),
                  child: Text(
                    name,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.all(2),
                  child: Text(
                    designation,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
