import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyView(),
    );
  }
}

class MyState {
  Map<String, dynamic> data = {};
  MyState({required this.data});
}

class MyViewModel extends Cubit<MyState> {

   Map<String, dynamic> data = {
  "id": 123,
  "name": "T-Shirt",
  "price": 19.99,
  "categories": ['Seçenek 1', 'Seçenek 2', 'Seçenek 3'],
  "details": {
    "color": "Red",
    "size": "Medium",
    "material": "Cotton"
  }
};

  MyViewModel({required this.data}): super(MyState(data: {}));
}

class MyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyViewModel(),
      child: Builder(
        builder: (context) {
          final viewModel = BlocProvider.of<MyViewModel>(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('Dropdown ve Textbox Örneği'),
            ),
            body: Column(
              children: [
                BlocBuilder<MyViewModel, MyState>(
                  bloc: viewModel,
                  builder: (context, state) {
                    return DropdownButton(
                      items: viewModel.data["categories"].map((value) {
                        return DropdownMenuItem<dynamic>(
                          value: value,
                          child: Text(value.toString()),
                        );
                      }).toList(),
                      onChanged: (value) {
                        viewModel.state.data["selectedValue"] = value;
                        viewModel.emit(new MyState(data: viewModel.state.data));
                        // viewModel.onDropdownChanged(value);
                      },
                    );
                  },
                ),
                BlocBuilder<MyViewModel, MyState>(
                  bloc: viewModel,
                  builder: (context, state) {
                    if (state.data["selectedValue"] != null) {
                      // Show the TextField
                      return TextField(
                        controller: TextEditingController(
                            text: state.data["selectedValue"].toString()),
                        decoration: InputDecoration(labelText: 'Seçilen Değer'),
                      );
                    } else {
                      // Hide the widget (e.g., return an empty Container)
                      return Container();
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
