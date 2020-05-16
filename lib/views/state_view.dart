import 'package:flutter/material.dart';
import '../modals/states_data.dart';

class StateView extends StatelessWidget {

  static const id = 'viewOfState';

  static StateData state;

  StateView({@required state});

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.only(top: 50.0, left: 40.0, right: 40.0),
        decoration:BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)) 
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              '${state.name}',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 30.0,
                decoration: TextDecoration.none
              )
            ),
            SizedBox(
              height: 20.0
            ),
            Container(
              height: 200.0,
              width: 200.0,
              child: Image.asset(state.picturePath, fit: BoxFit.contain),
            ),
            SizedBox(
              height: 20.0
            ),
            Text(
              '${state.capital}',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.lightBlueAccent,
                fontSize: 30.0,
                decoration: TextDecoration.none
              ),
            ),
            SizedBox(
              height: 20.0
            ),
            Container(
              width: 100.0,
              child: FlatButton(
                onPressed: (){
                  Navigator.pop(context);
                }, 
                color: Colors.lightBlueAccent,
                child: Text(
                  'Go Back',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0
                  ),
                )
              ),
            )
          ]
        ),
      ),
    );
  }
}