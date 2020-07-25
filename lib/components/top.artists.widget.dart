import 'package:flutter/material.dart';
import 'package:quarentify/components/top.artists.card.dart';
import 'package:quarentify/models/top.artists.model.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class TopArtistsWidget extends StatefulWidget {

  final List<ArtistsItems> artists;

  TopArtistsWidget({Key key, @required this.artists}) : super(key: key);

  @override
  _TopArtistsWidgetState createState() => _TopArtistsWidgetState();
}

class _TopArtistsWidgetState extends State<TopArtistsWidget> {

  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  int actualIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05
            ),
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Top ${widget.artists.length} Artistas",
                  style: TextStyle(
                    color: Theme.of(context).textSelectionColor,
                    fontSize: 20
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      padding: EdgeInsets.all(0),
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 18,
                      ),
                      onPressed: () {
                        setState(() {
                          double size = MediaQuery.of(context).size.width - 0.1;
                          actualIndex -= size ~/ 230;
                          if (actualIndex >= 0) {
                            itemScrollController.jumpTo(
                              index: actualIndex,
                            );
                          }
                          else {
                            actualIndex += size ~/ 230;
                          }
                        });
                      },
                    ),
                    Container(
                      height: 25,
                      width: 1.5,
                      color: Colors.white,
                    ),
                    IconButton(
                      padding: EdgeInsets.only(right: 0),
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 18,
                      ),
                      onPressed: () {
                        setState(() {
                          double size = MediaQuery.of(context).size.width - 0.1;
                          actualIndex += size ~/ 230;
                          if (actualIndex <= widget.artists.length) {
                            itemScrollController.jumpTo(
                              index: actualIndex,
                            );
                          }
                          else {
                            actualIndex -= size ~/ 230;
                          }
                        });
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 5,
              horizontal: MediaQuery.of(context).size.width * 0.05
            ),
            height: 0.5,
            color: Theme.of(context).textSelectionColor,
          ),
          Container(
            height: 300,
            child: ScrollablePositionedList.builder(
              itemScrollController: itemScrollController,
              itemPositionsListener: itemPositionsListener,
              scrollDirection: Axis.horizontal,
              itemCount: widget.artists.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: index == 0
                  ? EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05)
                  : EdgeInsets.all(0),
                  child: TopArtistsCard(
                    artist: widget.artists[index],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}