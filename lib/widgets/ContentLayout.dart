import 'dart:developer' as developer;
import 'package:corona_live_flutter/widgets/Graph.dart';
import 'package:corona_live_flutter/widgets/SimpleTable.dart';
import 'package:corona_live_flutter/lib/PreviousPageProvider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContentLayout extends StatelessWidget {
  ContentLayout({
    Key key,
    this.futureContent,
    this.pageName,
  }) : super(key: key);
  final String pageName;
  final Future<Content> futureContent;

  @override
  Widget build(BuildContext context) {
    final previousPageProvider = Provider.of<PreviousPageProvider>(context);
    Color borderColor = Theme.of(context).dividerColor;

    return Scaffold(
      body: FutureBuilder<Content> (
        future: futureContent,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              padding: const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 80),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: borderColor),
                      borderRadius: const BorderRadius.all(const Radius.circular(8)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                child: Column(
                                  children: [
                                    Text(snapshot.data.firstBoxListItems[0].label),
                                    Text(snapshot.data.firstBoxListItems[0].value),
                                  ],
                                ),
                              )
                            ),
                            Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                  child: Column(
                                    children: [
                                      Text(snapshot.data.firstBoxListItems[1].label),
                                      Text(snapshot.data.firstBoxListItems[1].value),
                                    ],
                                  ),
                                )
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                  child: Column(
                                    children: [
                                      Text(snapshot.data.firstBoxListItems[2].label),
                                      Text(snapshot.data.firstBoxListItems[2].value),
                                    ],
                                  ),
                                )
                            ),
                            Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                  child: Column(
                                    children: [
                                      Text(snapshot.data.firstBoxListItems[3].label),
                                      Text(snapshot.data.firstBoxListItems[3].value),
                                    ],
                                  ),
                                )
                            ),
                          ],
                        ),
                      ],
                    ),
                    margin: const EdgeInsets.only(bottom: 20),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: borderColor),
                      borderRadius: const BorderRadius.all(const Radius.circular(8)),
                    ),
                    child: DefaultTabController(
                      length: 4,
                      child: Builder(
                        builder: (BuildContext context) {
                          final TabController tabController = DefaultTabController.of(context);

                          return Column(
                            children: [
                              TabBar(
                                tabs: [
                                  Tab(child: Text('Graph1', style: TextStyle(color: Theme.of(context).primaryColor))),
                                  Tab(child: Text('Graph2', style: TextStyle(color: Theme.of(context).primaryColor))),
                                  Tab(child: Text('Graph3', style: TextStyle(color: Theme.of(context).primaryColor))),
                                  Tab(child: Text('Graph4', style: TextStyle(color: Theme.of(context).primaryColor))),
                                ],
                              ),
                              Container(
                                height: 220,
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide( //                   <--- left side
                                      color: borderColor,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: TabBarView(
                                  children: [
                                    Graph(
                                      points: snapshot.data.graphs[0],
                                    ),
                                    Graph(
                                      points: snapshot.data.graphs[1],
                                    ),
                                    Graph(
                                      points: snapshot.data.graphs[2],
                                    ),
                                    Graph(
                                      points: snapshot.data.graphs[3],
                                    ),
                                  ],
                                  controller: tabController,
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    ),
                    margin: const EdgeInsets.only(bottom: 20),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: borderColor),
                      borderRadius: const BorderRadius.all(const Radius.circular(8)),
                    ),
                    child: DefaultTabController(
                      length: 2,
                      child: Builder(
                        builder: (BuildContext context) {
                          final TabController tabController = DefaultTabController.of(context);

                          return Column(
                            children: [
                              TabBar(
                                tabs: [
                                  Tab(child: Text(snapshot.data.tableNames[0], style: TextStyle(color: Theme.of(context).primaryColor))),
                                  Tab(child: Text(snapshot.data.tableNames[1], style: TextStyle(color: Theme.of(context).primaryColor))),
                                ],
                              ),
                              Container(
                                height: 170,
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide( //                   <--- left side
                                      color: borderColor,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: TabBarView(
                                  children: [
                                    SimpleTable(tableContent: snapshot.data.tables[0]),
                                    SimpleTable(tableContent: snapshot.data.tables[1]),
                                  ],
                                  controller: tabController,
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("fetch 에 실패했습니다."));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
          previousPageProvider.visit(pageName);
        },
        child: Icon(Icons.list),
      ),
    );
  }
}

class Content {
  final List<FirstBoxListItem> firstBoxListItems;
  final List<List<GraphPoint>> graphs;
  final List<TableContent> tables;
  final List<String> tableNames;

  Content({this.firstBoxListItems, this.graphs, this.tables, this.tableNames});
}

class FirstBoxListItem {
  final String label;
  final String value;

  FirstBoxListItem({ this.label, this.value });
}
