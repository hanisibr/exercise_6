import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TextUpdateBloc>(
      create: (context) => TextUpdateBloc(),
      child: MaterialApp(
        home: Scaffold(body: DeleteWidget()),
      ),
    );
  }
}

class TextInputState {}

class TextInputInitState extends TextInputState {
  String? text;

  TextInputInitState({this.text});
}

class TextInputDataChange extends TextInputState {
  String? text;

  TextInputDataChange({this.text});
}

class TextEvents {}

class TextInit extends TextEvents {}

class TextChange extends TextEvents {
  final String? data;

  TextChange({@required this.data});
}

class TextUpdateBloc extends Bloc<TextEvents, TextInputState> {
  TextUpdateBloc() : super(TextInputInitState());

  get initialState => TextInputInitState(text: " ");

  @override
  Stream<TextInputState> mapEventToState(event) async* {
    if (event is TextInit) {
      yield TextInputInitState(text: "");
    } else if (event is TextChange) {
      yield TextInputInitState(text: event.data);
    }
  }
}

class DeleteWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextUpdateBloc counterBloc = BlocProvider.of<TextUpdateBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Exercise 6 - Bloc'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              onChanged: (value) => counterBloc.add(TextChange(data: value)),
            ),
            Container(
              padding: EdgeInsets.only(top: 20.0),
              child: BlocBuilder<TextUpdateBloc, TextInputState>(
                builder: (context, state) {
                  if (state is TextInputInitState) {
                    return Text(state.text.toString());
                  } else if (state is TextInputDataChange) {
                    return Text(state.text.toString());
                  } else {
                    return Text("something is wrong");
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
