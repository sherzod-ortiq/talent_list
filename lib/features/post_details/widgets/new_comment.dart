import 'package:flutter/material.dart';

import 'package:talent_list/features/post_details/post_details.dart';

class NewComment extends StatelessWidget {
  NewComment(this.bloc, {Key? key}) : super(key: key);

  final PostDetailsBloc bloc;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void _submitData() {
      if (_nameController.text.isEmpty ||
          _emailController.text.isEmpty ||
          _textController.text.isEmpty) {
        return;
      }

      bloc.add(
        PostDetailsCommentCreateRequested(
          name: _nameController.text,
          email: _emailController.text,
          text: _textController.text,
        ),
      );

      Navigator.of(context).pop();
    }

    return SingleChildScrollView(
      child: Card(
        margin: const EdgeInsets.all(0),
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(labelText: 'Name'),
                controller: _nameController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Email'),
                controller: _emailController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Text'),
                controller: _textController,
                onSubmitted: (_) => _submitData(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: ElevatedButton(
                  onPressed: _submitData,
                  child: const Text('Add comment'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
