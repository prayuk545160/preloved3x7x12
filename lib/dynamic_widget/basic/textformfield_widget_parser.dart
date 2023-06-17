import 'package:validators/validators.dart';
import '../../dynamic_widget.dart';
import '../utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../g.dart' as g;

class TextformFieldParser extends WidgetParser {

  final List<String> dtag;
  TextformFieldParser(this.dtag);


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
    return textformfield_ex(buildContext,m,listener);

  }

  @override
  String get widgetName => "TextFormField";
}


class textformfield_ex extends StatefulWidget {

  final BuildContext _buildContext;
  final ClickListener listener;
  final  Map<String, dynamic> m;

  TextEditingController txtc =  TextEditingController();

  textformfield_ex( this._buildContext, this.m,this.listener);

  String id() {
    return g.null2str(m["id"]);
  }
  String val(){
    return txtc.text;
  }
  String setval(String val){
    txtc.text=val;
    g.saveiform(m["skey"],val);
  }
  @override
  _TextFormField_exState createState() => _TextFormField_exState(m,txtc);

}

class _TextFormField_exState  extends State<textformfield_ex> {

  final  Map<String, dynamic> m;
  String skey;
  String last_text="";
  String id="";
  String sval="";
  TextEditingController txtc =  TextEditingController();
  _TextFormField_exState(this.m,this.txtc);
  int idatareq=0;
  String clickEvent="";
 var ui;


  @override
  void initState() {

    skey =g.null2str(m["skey"]);
    id=g.null2str(m["id"]);
    txtc.text=g.null2str(m["data"]);
    clickEvent = m.containsKey("click_event") ? m['click_event'] : "";


    super.initState();

  }


  void dispose() {
    txtc.dispose();
    super.dispose();
  }

  void data_change(int treq){
    if(m.containsKey("editvalue2click")){
      int delay_time=g.cint(g.null2str(m["delay_time"]), 1000);
      Future.delayed(Duration(milliseconds: delay_time), () async {
        if(idatareq==treq){
          g.b_click=g.null2str(m["editvalue2click"]);
        }
      });
    }
  }
  int getireq(){
    idatareq+=1;
    return idatareq;
  }
  void call_text_change(){
     if(m.containsKey("edit2click")){
       g.t_click=g.null2str(m["edit2click"]);
     }
  }
  @override
  Widget build(BuildContext context) {




    if(g.isfoundfield(m["id"])){
      setState(() {
        txtc.text=g.getdatafield(m["id"]);
      });
    }

    bool fieldenable=true;
    if(g.null2str(m["enabled"])=="false"){
      fieldenable=false;
    }

    bool is_secut=(m["obscureText"]=="true");
    var clear_button;

    if(g.null2str(m["clear_button"])=="true"){
      clear_button=IconButton(
        onPressed: () {
          try{
            txtc.clear();
            g.saveiform(m["id"], txtc.text);
            data_change(getireq());
          }catch(e){
            print("printTextField.error."+e.toString());
          }
        },
        icon: Icon(Icons.clear,size: 20.0),
      );
    }


    var h=g.cdbl(g.null2str(m["height"]),40.0);
    if(g.null2str(m["height"])=="fill"){
      h=double.infinity;
    }

     ui=




    TextFormField(textAlign: TextAlign.left,
      autofocus:  m.containsKey("autofocus") ? m['autofocus'] : false,
      key: g.getnewkey(),
      enabled:fieldenable,
      obscureText: is_secut,
      decoration: InputDecoration(
        hintText: g.null2str(m["hinttext"]),
        labelText:g.null2str(m["labelText"]),
        //errorText: false ? 'true' :'false',
        isDense: true,

        contentPadding:  EdgeInsets.all(g.cdbl(m["contentPadding"],4.0)),
        suffixIcon: clear_button,
      ),
      validator: (val) {
        if(isEmail(val)){
             return "Invalid Email";
        }else {
            return null;
        }
      } ,
      controller
          : txtc,
      keyboardType: m.containsKey('keyboardType') ? Key(m['keyboardType']) :TextInputType.text,
      onChanged: (String value) async {
        try{
          if(txtc.text!=value){
            txtc.text=value;
          }


          Future.delayed(Duration(milliseconds: 2000), () async {
            if(last_text==value){
              call_text_change();
            }else {
              Future.delayed(Duration(milliseconds: 2000), () async {
                if(last_text==value){

                   call_text_change();

                }

              });
            }

          });

          last_text=value;


          g.saveiform(m["id"], value);
          if(m.containsKey("edit_click")){
            g.t_click=g.null2str(m["edit_click"]);
          }
        }catch(e){
          print("printTextFormField.error."+e.toString());
        }
      },
        onEditingComplete: (){
          if(m.containsKey("done_click")){
            g.t_click=g.null2str(m["done_click"]);
          }
          //do your stuff
        }
    );

    ui=SizedBox(child: ui,height: h);


    if ( clickEvent != "") {
      return InkWell(
        onTap: () {
          widget.listener.onClicked(clickEvent);
        },
        child: AbsorbPointer(
            absorbing: true,  //To disable from touch use false while **true** for otherwise
            child: ui
        ),
      );
    } else {
      return ui;
    }







  }


}
