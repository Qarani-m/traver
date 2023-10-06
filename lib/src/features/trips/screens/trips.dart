import 'package:flutter/material.dart';

class Trips extends StatelessWidget {
  const Trips({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Trips", style: Theme.of(context).textTheme.titleSmall,),),
    );
  }
}