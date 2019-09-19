import 'package:cookbook/src/modal_sheet.dart';
import 'package:cookbook/src/pageswipe.dart';
import 'package:cookbook/src/signin.dart';
import 'package:cookbook/src/todo_list.dart';
import 'package:cookbook/src/waveslider.dart';
import 'package:flutter/material.dart';

class BCardData {
  final String title;
  final Widget content;

  const BCardData({
    @required this.title,
    @required this.content,
  });

  static List<BCardData> list = [
    BCardData(title: 'Wave Line', content: WaveApp()),
    BCardData(title: 'Page Swipe', content: PageSwipe()),
    BCardData(title: 'Todo List', content: TodoListPage()),
    BCardData(title: 'Modal Sheet', content: ModalSheet()),
    BCardData(title: 'Sing In', content: SignIn()),
  ];
}
