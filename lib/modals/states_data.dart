import 'package:flutter/material.dart';

class StateData{
  String name, capital, picturePath;
  Color colour;

  StateData({@required this.name, @required this.capital, @required this.colour, @required this.picturePath});
}

List<StateData> IndianStates =[
  StateData(name: 'Jammu and Kashmir', capital: 'Jammu(Winter) and Srinagar(Summer)', colour: Color(0xffff0000), picturePath: 'assets/JammuAndKashmir.png'),
  StateData(name: 'Goa',               capital: 'Panaji',                             colour: Color(0xff000000), picturePath: 'assets/Goa.png'),
  StateData(name: 'Uttarakhand',       capital: 'Dehradun',                           colour: Color(0xff800000), picturePath: 'assets/Uttarakhand.png'),
  StateData(name: 'Assam',             capital: 'Dispur',                             colour: Color(0xff008000), picturePath: 'assets/Assam.png'),
  StateData(name: 'Arunachal Pradesh', capital: 'Itanagar',                           colour: Color(0xff808000), picturePath: 'assets/ArunachalPradesh.png'),
  StateData(name: 'Meghalaya',         capital: 'Shillong',                           colour: Color(0xffff8000), picturePath: 'assets/Meghalaya.png'),
  StateData(name: 'Andhra Pradesh',    capital: 'Amaravati',                          colour: Color(0xff00ff00), picturePath: 'assets/AndhraPradesh.png'),
  StateData(name: 'Maharashtra',       capital: 'Mumbai',                             colour: Color(0xff80ff00), picturePath: 'assets/Maharashtra.png'),
  StateData(name: 'Gujarat',           capital: 'Ahemedabad',                         colour: Color(0xffffff00), picturePath: 'assets/Gujarat.png'),
  StateData(name: 'Nagaland',          capital: 'Kohima',                             colour: Color(0xff000080), picturePath: 'assets/Nagaland.png'),
  StateData(name: 'Manipur',           capital: 'Imphal',                             colour: Color(0xff800080), picturePath: 'assets/Manipur.png'),
  StateData(name: 'West Bengal',       capital: 'Kolkata',                            colour: Color(0xffff0080), picturePath: 'assets/WestBengal.png'),
  StateData(name: 'Karnataka',         capital: 'Bengaluru',                          colour: Color(0xff008080), picturePath: 'assets/Karnataka.png'),
  StateData(name: 'Mizoram',           capital: 'Aizwal',                             colour: Color(0xff808080), picturePath: 'assets/Mizoram.png'),
  StateData(name: 'Tripura',           capital: 'Agartala',                           colour: Color(0xffff8080), picturePath: 'assets/Tripura.png'),
  StateData(name: 'Haryana',           capital: 'Chandigarh',                         colour: Color(0xff00ff80), picturePath: 'assets/Haryana.png'),
  StateData(name: 'Chhattisgarh',      capital: 'Raipur',                             colour: Color(0xff80ff80), picturePath: 'assets/Chhattisgarh.png'),
  StateData(name: 'Himachal Pradesh',  capital: 'Shimla',                             colour: Color(0xffffff80), picturePath: 'assets/HimachalPradesh.png'),
  StateData(name: 'Punjab',            capital: 'Chandigarh',                         colour: Color(0xff0000ff), picturePath: 'assets/Punjab.png'),
  StateData(name: 'Madhya Pradesh',    capital: 'Bhopal',                             colour: Color(0xff8000ff), picturePath: 'assets/MadhyaPradesh.png'),
  StateData(name: 'Uttar Pradesh',     capital: 'Lucknow',                            colour: Color(0xffff00ff), picturePath: 'assets/UttarPradesh.png'),
  StateData(name: 'Tamil Nadu',        capital: 'Chennai',                            colour: Color(0xff0080ff), picturePath: 'assets/TamilNadu.png'),
  StateData(name: 'Kerala',            capital: 'Thiruvananthapuram',                 colour: Color(0xff8080ff), picturePath: 'assets/Kerala.png'),
  StateData(name: 'Odisha',            capital: 'Bhubhaneshwar',                      colour: Color(0xffff80ff), picturePath: 'assets/Odisha.png'),
  StateData(name: 'Rajasthan',         capital: 'Jaipur',                             colour: Color(0xff00ffff), picturePath: 'assets/Rajasthan.png'),
  StateData(name: 'Telangana',         capital: 'Hyderabad',                          colour: Color(0xff80ffff), picturePath: 'assets/Telengana.png'),
  StateData(name: 'Jharkhand',         capital: 'Ranchi',                             colour: Color(0xff000040), picturePath: 'assets/Jharkhand.png'),
  StateData(name: 'Bihar',             capital: 'Patna',                              colour: Color(0xff400000), picturePath: 'assets/Bihar.png'),
  StateData(name: 'Sikkim',            capital: 'Gangtok',                            colour: Color(0xff004000), picturePath: 'assets/Sikkim.png')
];