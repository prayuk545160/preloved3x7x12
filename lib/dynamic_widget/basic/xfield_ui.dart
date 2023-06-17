import 'dart:convert';

import 'package:intl/intl.dart';

import '../../dynamic_widget.dart';
import '../utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../g.dart' as g;
import 'package:flutter_form_builder/flutter_form_builder.dart';

class xfield_ui extends WidgetParser {

  final List<String> dtag;
  xfield_ui(this.dtag);


  @override
  Widget parse(Map<String, dynamic> m, BuildContext buildContext,
      ClickListener listener) {

    if(m["id"]==null){
      m["id"]=g.createid();
    }
    m["skey"]= dtag[0];
    if(!m["id"].toString().contains(".")){
      m["id"]=m["skey"]+"."+m["id"];
    }
    return xfield_uiex(buildContext,m);

    return TextField(textAlign: TextAlign.left,
        decoration: new InputDecoration(hintText: g.null2str(m["hinttext"]), contentPadding: const EdgeInsets.all(5.0))
    );
  }

  @override
  String get widgetName => "field";
}


class xfield_uiex extends StatefulWidget {

  final BuildContext _buildContext;
  final  Map<String, dynamic> m;
  final fkey = GlobalKey<FormBuilderState>();

  xfield_uiex( this._buildContext, this.m);

  String id() {
    return g.null2str(m["id"]);
  }

  String set_value(Map<String, dynamic>  h){
    h.forEach((key, value) {
      if(fkey.currentState.value.containsKey(key)){
        fkey.currentState.value[key]=value;
      }
    });

  }

  Map<String, dynamic> get_editvalue(){
    return fkey.currentState.value;
  }
  String val(){
    return fkey.currentState.value.toString();
  }

  getdata(){
    try {
      fkey.currentState.save();
      return fkey.currentState.value;
    }catch(e){
    }
  }






  @override
  _xfield_uiexState createState() => _xfield_uiexState(m);

}

class _xfield_uiexState  extends State<xfield_uiex> {
  final  Map<String, dynamic> m;
  String skey;
  String id="";
  String sval="";
  _xfield_uiexState(this.m);


  @override
  void initState() {

    skey =g.null2str(m["skey"]);
    id=g.null2str(m["id"]);

    super.initState();


  }


  void dispose() {
    super.dispose();
  }


  getkeyboardtype(){

    switch(g.null2str(m["keyboardType"])){
      case "multiline":
        return TextInputType.multiline;
        break;
      case "datetime":
        return TextInputType.datetime;
        break;
      case "emailAddress":
        return TextInputType.emailAddress;
        break;
      case "name":
        return TextInputType.name;
        break;
      case "number":
        return TextInputType.number;
        break;
      case "phone":
        return TextInputType.phone;
        break;
      case "streetAddress":
        return TextInputType.streetAddress;
        break;
      case "text":
        return TextInputType.text;
        break;
      case "url":
        return TextInputType.url;
        break;
      case "values":
        return TextInputType.values;
        break;
      case "visiblePassword":
        return TextInputType.visiblePassword;
        break;
      case "values":
        return TextInputType.values;
        break;
      default:
        return TextInputType.text;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {


    var wg;
    var ih=g.cdbl(g.null2str(m["height"]),36.0);

    if(g.null2str(m["height"])=="fill"){
      ih=double.infinity;
    }
    bool is_secut=(m["obscureText"]=="true");
    var clear_button;
    if(g.null2str(m["clear_button"])=="true"){
      clear_button=IconButton(
        onPressed: () {

          try{


          }catch(e){
            print("printTextField.error."+e.toString());
          }
        },
        icon: Icon(Icons.clear,size: 20.0),
      );
    }
    bool fieldenable=true;
    if(g.null2str(m["enabled"])=="false"){
      fieldenable=false;
    }
    List<Widget> allwg=[];


    try {
      List allrow =jsonDecode(g.read_json( g.json_ui,"iform")) as List;
      if (allrow.length > 0) {
        int im=allrow.length;
        Map<String, dynamic> h = new Map<String, dynamic>();
        String vname="";

        for(int i=0; i<im; i++){
           h = allrow[i] as Map<String, dynamic>;
           vname=g.null2str(h["name"]);
           try{

             wg=null;
             switch(g.null2str(h["type"])){

               case "checkbox":
                 wg=FormBuilderCheckbox(
                   name: vname,
                   initialValue: false,
                   onChanged: null,
                   title: RichText(
                     text: TextSpan(
                       children: [
                         TextSpan(
                           text: 'I have read and agree to the ',
                           style: TextStyle(color: Colors.black),
                         )
                       ],
                     ),
                   ),
                   validator: FormBuilderValidators.equal(
                     context,
                     true,
                     errorText:
                     'You must accept terms and conditions to continue',
                   ),
                 );

                 break;
               case "date":
                 wg=FormBuilderDateTimePicker(
                   name: vname,
                   // onChanged: _onChanged,
                   inputType: InputType.date,
                   decoration: InputDecoration(
                     labelText: 'date',
                   ),
                   initialTime: TimeOfDay(hour: 8, minute: 0),
                   // initialValue: DateTime.now(),
                   // enabled: true,
                 );
                 break;
               case "datetime":
                 wg=FormBuilderDateTimePicker(
                   name: vname,
                   // onChanged: _onChanged,
                   inputType: InputType.both,
                   decoration: InputDecoration(
                     labelText: 'datetime',
                   ),
                   initialTime: TimeOfDay(hour: 8, minute: 0),
                   // initialValue: DateTime.now(),
                   // enabled: true,
                 );
                 break;



               case "time":
                 wg=FormBuilderDateTimePicker(
                   name: vname,
                   // onChanged: _onChanged,
                   inputType: InputType.time,
                   decoration: InputDecoration(
                     labelText: 'time',
                   ),
                   initialTime: TimeOfDay(hour: 8, minute: 0),
                   // initialValue: DateTime.now(),
                   // enabled: true,
                 );
                 break;

               case "date_rank":
                 wg=FormBuilderDateRangePicker(
                   name: vname,
                   format: DateFormat('dd/MM/yyyy'),
                   decoration: InputDecoration(
                     labelText: 'date_ranke',
                     helperText: 'Helper text',
                     hintText: 'Hint text',
                   ),
                 );

                 break;

               case "slider":
                 wg=FormBuilderSlider(
                   name: vname,
                   validator: FormBuilderValidators.compose([
                     FormBuilderValidators.min(context, 6),
                   ]),
                   onChanged: null,
                   min: 0.0,
                   max: 10.0,
                   initialValue: 7.0,
                   divisions: 20,
                   activeColor: Colors.red,
                   inactiveColor: Colors.pink[100],
                   decoration: InputDecoration(
                     labelText: 'Number of things',
                   ),
                 );

                 break;
               case "switch":
                 wg= FormBuilderSwitch(
                   name: vname,
                   initialValue: true,
                 );

                 break;

               case "slider2":
                 wg=FormBuilderRangeSlider(
                   name: vname,
                   validator: FormBuilderValidators.compose([
                     FormBuilderValidators.min(context, 6),
                   ]),
                   min: 0.0,
                   max: 10.0,
                   divisions: 20,
                   activeColor: Colors.red,
                   inactiveColor: Colors.pink[100],
                   decoration: InputDecoration(
                     labelText: 'Number of things',
                   ),
                 );

                 break;

               case "radiogroup":

                 wg=FormBuilderRadioGroup(
                   name: vname,
                   decoration: InputDecoration(labelText: 'My best language'),
                   validator: FormBuilderValidators.required(context),
                   options: [
                     'Dart',
                     'Kotlin',
                     'Java',
                     'Swift',
                     'Objective-C',
                     'Other'
                   ]
                       .map((lang) => FormBuilderFieldOption(value: lang))
                       .toList(growable: false),
                 );
                 break;


               case "dropdown":


                 wg= FormBuilderDropdown(
                   name: vname,
                   decoration: InputDecoration(
                     labelText: 'Gender',
                   ),
                   // initialValue: 'Male',
                   allowClear: true,
                   hint: Text('Select Gender'),
                   validator: FormBuilderValidators.compose(
                       [FormBuilderValidators.required(context)]),
                   items: <String>['Male', 'Female']
                       .map((gender) => DropdownMenuItem(
                     value: gender,
                     child: Text('$gender'),
                   ))
                       .toList(),
                 );


                 break;

               case "segment":
                 wg= FormBuilderSegmentedControl(
                   name: vname,
                   decoration: InputDecoration(labelText: "No of Children"),

                   options: List.generate(5, (i) => i + 1)
                       .map(
                           (number) => FormBuilderFieldOption(value: number))
                       .toList(),
                 );
                 break;

               case "checkbox_group":

                 wg=   FormBuilderCheckboxGroup (
                   name: vname,
                   decoration:
                   InputDecoration(labelText: "Known Langugaes"),
                   initialValue: ["English"],
                   options: [
                     FormBuilderFieldOption(value: "English"),
                     FormBuilderFieldOption(value: "Hindi"),
                     FormBuilderFieldOption(value: "Telugu"),
                     FormBuilderFieldOption(value: "Other")
                   ],
                 );

                 break;

               case "radio_group":

                 wg=   FormBuilderRadioGroup (
                   name: vname,
                   decoration:
                   InputDecoration(labelText: "Known Langugaes"),
                   initialValue: ["English"],
                   options: [
                     FormBuilderFieldOption(value: "English"),
                     FormBuilderFieldOption(value: "Hindi"),
                     FormBuilderFieldOption(value: "Telugu"),
                     FormBuilderFieldOption(value: "Other")
                   ],
                 );

                 break;




               case "filter_chip":
                 wg=FormBuilderFilterChip(
                   name: vname,
                   decoration: InputDecoration(
                     labelText: 'Select many options',
                   ),
                   options: [
                     FormBuilderFieldOption(
                         value: 'Test', child: Text('Test')),
                     FormBuilderFieldOption(
                         value: 'Test 1', child: Text('Test 1')),
                     FormBuilderFieldOption(
                         value: 'Test 2', child: Text('Test 2')),
                     FormBuilderFieldOption(
                         value: 'Test 3', child: Text('Test 3')),
                     FormBuilderFieldOption(
                         value: 'Test 4', child: Text('Test 4')),
                   ],
                 );

                 break;


               case "filter_one":
                 wg= FormBuilderChoiceChip(
                   name: vname,
                   decoration: InputDecoration(
                     labelText: 'Select an option',
                   ),
                   options: [
                     FormBuilderFieldOption(
                         value: 'Test', child: Text('Test')),
                     FormBuilderFieldOption(
                         value: 'Test 1', child: Text('Test 1')),
                     FormBuilderFieldOption(
                         value: 'Test 2', child: Text('Test 2')),
                     FormBuilderFieldOption(
                         value: 'Test 3', child: Text('Test 3')),
                     FormBuilderFieldOption(
                         value: 'Test 4', child: Text('Test 4')),
                   ],
                 );

                 break;
               case "textfield":
                 wg= FormBuilderTextField(
                   name: vname,
                   decoration: InputDecoration(
                     labelText:
                     'This value is passed along to the [Text.maxLines] attribute of the [Text] widget used to display the hint text.',
                   ),
                   onChanged: null,
                   // valueTransformer: (text) => num.tryParse(text),
                   validator: FormBuilderValidators.compose([
                     FormBuilderValidators.required(context),
                     FormBuilderValidators.numeric(context),
                     FormBuilderValidators.max(context, 70),
                   ]),
                   keyboardType: TextInputType.number,
                 );

                 break;

               case "text":
                 var wg=Container(height: ih,
                     child:TextField(textAlign: TextAlign.left,

                       key: g.getnewkey(),
                       enabled:fieldenable,
                       obscureText: is_secut,
                       maxLines: null,
                       expands: true,
                       decoration: InputDecoration(
                         border: OutlineInputBorder(
                           borderRadius: BorderRadius.all(Radius.circular(10.0)),
                         ),
                         hintText: g.null2str(m["hinttext"]),
                         labelText:g.null2str(m["labelText"]),
                         contentPadding: const EdgeInsets.all(5.0),
                         suffixIcon: clear_button,
                       ),
                       keyboardType:getkeyboardtype(),
                       onChanged: (String value) async {
                         try{
                           g.saveiform(m["id"], value);
                         }catch(e){
                           print("printTextField.error."+e.toString());
                         }
                       },
                     ));
                 break;
             }
             if(wg!=null){
               allwg.add(wg);
             }

           }catch(e){}

        }
      }
    } catch (e) {}

    return

    Column(
        children: <Widget>[
        FormBuilder(
        autovalidateMode:AutovalidateMode.always,
        key: widget.fkey,
        child: Column(children:allwg)
        )
       ]
    );




  }
}
