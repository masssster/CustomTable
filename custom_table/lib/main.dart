import 'package:custom_table/custom_table_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

int curPage = 0;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Custom Table")),
      body: BlocProvider(
        create: (context) =>
            CustomTableBloc()..add(FetchData(page: 0, take: 10)),
        child: Center(
          child: BlocBuilder<CustomTableBloc, List<String>>(
            builder: (context, state) => CustomTable(
              listData: state,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTable extends StatelessWidget {
  late List<String> listData;

  CustomTable({super.key, required this.listData});

  TableRow header() {
    return TableRow(
      children: [
        Container(
          height: 30,
          color: Colors.grey,
          child: Center(
            child: Text("Data Header"),
          ),
        )
      ],
    );
  }

  List<TableRow> body(listData) {
    List<TableRow> data = [];
    for (var x in listData) {
      data.add(
        TableRow(
          children: [
            Container(
              height: 20,
              child: Center(
                child: Text("Data " + x.toString()),
              ),
            ),
          ],
        ),
      );
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(13),
      ),
      width: 400,
      height: 275,
      child: Column(
        children: [
          Table(
            border: const TableBorder(
              horizontalInside: BorderSide(color: Colors.grey),
            ),
            children: [header()] + body(listData),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  if (curPage > 0) {
                    curPage = curPage - 1;
                    BlocProvider.of<CustomTableBloc>(context)
                        .add(FetchData(page: curPage, take: 10));
                  }
                },
                icon: Icon(Icons.arrow_circle_left),
              ),
              IconButton(
                onPressed: () {
                  curPage = curPage + 1;
                  BlocProvider.of<CustomTableBloc>(context)
                      .add(FetchData(page: curPage, take: 10));
                },
                icon: Icon(Icons.arrow_circle_right),
              )
            ],
          )
        ],
      ),
    );
  }
}
