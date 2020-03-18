import 'package:Decisive/ui/widgets/carousel.dart';
import 'package:Decisive/ui/widgets/drawer.dart';
import 'package:Decisive/util/sizeConfig.dart';
import 'package:Decisive/util/uiData.dart';
import 'package:Decisive/util/validators.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Profile extends StatelessWidget{
    final min = 500.0;
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    @override
    Widget build(BuildContext context) {
      SizeConfig().init(context);
      return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(leading: GestureDetector(child:Text('     cancel',style: TextStyle(color: Colors.black,fontSize: 11)),onTap: ()=>Navigator.pop(context)),actions: <Widget>[
            Text('Benefits    ',style: TextStyle(color: Colors.black,fontSize: 11))
          ],elevation: 0,backgroundColor: Colors.transparent),
          body:ConstrainedBox(
          constraints: const BoxConstraints.expand(),
      child:ConstrainedBox(
      constraints: BoxConstraints(
      minHeight: min,
      maxHeight: SizeConfig.blockSizeVertical * 100 > min
      ? SizeConfig.blockSizeVertical * 100
          : min),
      child: Padding(padding: EdgeInsets.all(20.0),
      child: SingleChildScrollView(child:RegisterForm(_scaffoldKey))
      ))),
      drawer: AppDrawer());


}
}


    class RegisterForm extends StatefulWidget {
    final GlobalKey<ScaffoldState> _scaffoldKey;
    const RegisterForm(this._scaffoldKey,{Key key}) : super(key: key);

    @override
    _RegisterFormState createState() => _RegisterFormState();
    }

    class _RegisterFormState extends State<RegisterForm> {
      final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
      bool _autoValidate = false;
      bool _formWasEdited = false;
      final formatTime = new DateFormat.jm();
      Validators validate;
      TextEditingController txt;
      bool p1 = true;
      bool p2 = true;
      String firstName, lastName, email, phoneNumber, password;
      List<String> items = ["1","2","3"];


      @override
      void initState() {
        validate = Validators(_formWasEdited);
        txt = TextEditingController();
        super.initState();
      }

      @override
      void dispose() {
        txt.dispose();
        super.dispose();
      }

      void showInSnackBar(String value) {
        widget._scaffoldKey.currentState.showSnackBar(new SnackBar(
            content: new Text(value)
        ));
      }


/*    Future<void> _handleSubmitted() async{
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
    _autoValidate = true; // Start validating on every change.
    showInSnackBar('Please fix the errors in red before submitting.');
    } else {
    form.save();
    try {
    _showDialog(context);
    bool test =   await  Provider.of<UserVM>(context, listen: false).registerUser(email: email,
    password: password,
    firstName: firstName,
    lastName: lastName,
    passwordConfirmation: password);
    if(test){
    Navigator.pop(context);
    _autoValidate = false;
    _reset(form);
    Navigator.pushNamed(context, UIData.authRoute);
    }
    else {
    Navigator.pop(context);
    showInSnackBar('Registeration Unsuccessful');
    }
    }
    catch(exception){
    print(exception);
    showInSnackBar(exception);
    }

    }
    }*/

      void _reset(FormState form) {
        form.reset();
        txt.text = "";
      }

      Future<bool> _warnUserAboutInvalidData() async {
        final FormState form = _formKey.currentState;
        if (form == null || !_formWasEdited || form.validate())
          return true;

        return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return new AlertDialog(
              title: const Text('This form has errors'),
              content: const Text('Really leave this form?'),
              actions: <Widget>[
                new FlatButton(
                  child: const Text('YES'),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
                new FlatButton(
                  child: const Text('NO'),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
              ],
            );
          },
        ) ?? false;
      }

      @override
      Widget build(BuildContext context) {
        return Form(
          key: _formKey,
          autovalidate: _autoValidate,
          onWillPop: _warnUserAboutInvalidData,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(children: <Widget>[
                Column(
                  children: <Widget>[
                    Padding(child:IconButton(icon:Icon(Icons.clear,size: 30),onPressed: ()=>widget._scaffoldKey.currentState.openDrawer()),padding: EdgeInsets.only(right: 10))
                  ],crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,
                ),
                Expanded(child:Column(
                  children: <Widget>[
                    TextFormField(decoration:  InputDecoration(hintText: "Restaurant Name",hintStyle: TextStyle(color: Colors.black),enabledBorder: OutlineInputBorder(),border: OutlineInputBorder()),
                      keyboardType: TextInputType.text,onSaved: (value){},validator: (String name)=>validate.validateName(name)),
                    SizedBox(height:30.0),
                    TextFormField(decoration:  InputDecoration(hintText: "Address",hintStyle: TextStyle(color: Colors.black),enabledBorder: OutlineInputBorder(),border: OutlineInputBorder()),
                        keyboardType: TextInputType.text,onSaved: (value){},validator: (String address)=>validate.validateName(address)),
                    SizedBox(height:30.0),
                  ],
                ))
              ],),
              TextFormField(decoration:  InputDecoration(hintText: "Restaurant Name",hintStyle: TextStyle(color: Colors.black),enabledBorder: OutlineInputBorder(),border: OutlineInputBorder()),
                  keyboardType: TextInputType.multiline,onSaved: (value){},validator: (String name)=>validate.validateName(name),maxLines: null),
              SizedBox(height:30.0),
              Carousel(),
              SizedBox(height:30.0),
              Stack(
              children:[
              Container(decoration: BoxDecoration(border: Border(top: BorderSide())),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Flexible(child: Container(decoration: BoxDecoration(border: Border.all(color: Colors.black)),child: Text("  Name")),flex: 3,fit: FlexFit.tight,),
                      Flexible(child: Container(decoration: BoxDecoration(border: Border.all(color: Colors.black)),child: Text("  Description")),flex: 5,fit: FlexFit.tight),
                      Flexible(child: Container(decoration: BoxDecoration(border: Border.all(color: Colors.black)),child: Text("  Price")),flex: 2,fit: FlexFit.tight),
                    ],
                  ),
                  Column(
                    children: items.map((item)=>Row(
                      children: <Widget>[
                        Flexible(child: Container(decoration: BoxDecoration(border: Border.all(color: Colors.black)),child: TextFormField(decoration:  InputDecoration(enabledBorder: UnderlineInputBorder(),border: UnderlineInputBorder()),
                            keyboardType: TextInputType.text,onSaved: (value){},validator: (String name)=>validate.validateName(name))),flex: 3),
                        Flexible(child: Container(decoration: BoxDecoration(border: Border.all(color: Colors.black)),child: TextFormField(decoration:  InputDecoration(enabledBorder: UnderlineInputBorder(),border: UnderlineInputBorder()),
                            keyboardType: TextInputType.text,onSaved: (value){},validator: (String description)=>validate.validateName(description))),flex: 5),
                        Flexible(child: Container(decoration: BoxDecoration(border: Border.all(color: Colors.black)),child: TextFormField(decoration:  InputDecoration(enabledBorder: UnderlineInputBorder(),border: UnderlineInputBorder(),prefixText: '\$'),
                            keyboardType: TextInputType.numberWithOptions(),onSaved: (value){},validator: (String price)=>validate.validateName(price))),flex: 2),
                      ],
                    )).toList()
                  ),
                  SizedBox(height: 50.0)
                ],
              ),),
               Positioned(child: FloatingActionButton(onPressed: ()=>setState(()=>items.add("value")),child: Icon(Icons.add_circle_outline),mini: true,heroTag: "btn1",),right: 5.0,bottom: 20.0)

        ]
              ),
              SizedBox(height:30.0),
        Container(decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: Column(
        children: <Widget>[
          Text("Opening Period"),
          SizedBox(height:30.0),
          Row(
            children:[
              Text("Monday"),
              SizedBox(width:20.0),
              Expanded(child:Column(children: <Widget>[
                Row(children:[ Icon(Icons.access_time),SizedBox(width: 15.0),Text("Begin",style:TextStyle(color:Colors.grey)),]),
               DateTimeField(
                  format: formatTime,
                  onShowPicker: (context, currentValue) async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                    );
                    return DateTimeField.convert(time);
                  },
                  onSaved: (DateTime val){},validator: (DateTime value)=>validate.validateDateTime(value,errorMsg:"Please select time"),
                )
              ],crossAxisAlignment: CrossAxisAlignment.start,)),
              SizedBox(width:20.0),
              Expanded(child:Column(children: <Widget>[
                Row(children:[ Icon(Icons.access_time),SizedBox(width: 15.0),Text("End",style:TextStyle(color:Colors.grey)),]),
                DateTimeField(
                  format: formatTime,
                  onShowPicker: (context, currentValue) async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                    );
                    return DateTimeField.convert(time);
                  },
                  onSaved: (DateTime val){},validator: (DateTime value)=>validate.validateDateTime(value,errorMsg:"Please select time"),
                ),
              ],crossAxisAlignment: CrossAxisAlignment.start,)),
              SizedBox(width:20.0),

            ]
          ),
          SizedBox(height: 20.0),
          Row(
              children:[
                Text("Tuesday"),
                SizedBox(width:20.0),
                Expanded(child:Column(children: <Widget>[
                  Row(children:[ Icon(Icons.access_time),SizedBox(width: 15.0),Text("Begin",style:TextStyle(color:Colors.grey)),]),
                  DateTimeField(
                    format: formatTime,
                    onShowPicker: (context, currentValue) async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                      );
                      return DateTimeField.convert(time);
                    },
                    onSaved: (DateTime val){},validator: (DateTime value)=>validate.validateDateTime(value,errorMsg:"Please select time"),
                  )
                ],crossAxisAlignment: CrossAxisAlignment.start,)),
                SizedBox(width:20.0),
                Expanded(child:Column(children: <Widget>[
                  Row(children:[ Icon(Icons.access_time),SizedBox(width: 15.0),Text("End",style:TextStyle(color:Colors.grey)),]),
                  DateTimeField(
                    format: formatTime,
                    onShowPicker: (context, currentValue) async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                      );
                      return DateTimeField.convert(time);
                    },
                    onSaved: (DateTime val){},validator: (DateTime value)=>validate.validateDateTime(value,errorMsg:"Please select time"),
                  ),
                ],crossAxisAlignment: CrossAxisAlignment.start,)),

                SizedBox(width:20.0),

              ]
          ),
          SizedBox(height: 20.0),
          Row(
              children:[
                Text("Wednesday"),
                SizedBox(width:20.0),
                Expanded(child:Column(children: <Widget>[
                  Row(children:[ Icon(Icons.access_time),SizedBox(width: 15.0),Text("Begin",style:TextStyle(color:Colors.grey)),]),
                  DateTimeField(
                    format: formatTime,
                    onShowPicker: (context, currentValue) async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                      );
                      return DateTimeField.convert(time);
                    },
                    onSaved: (DateTime val){},validator: (DateTime value)=>validate.validateDateTime(value,errorMsg:"Please select time"),
                  )
                ],crossAxisAlignment: CrossAxisAlignment.start,)),
                SizedBox(width:20.0),
                Expanded(child:Column(children: <Widget>[
                  Row(children:[ Icon(Icons.access_time),SizedBox(width: 15.0),Text("End",style:TextStyle(color:Colors.grey)),]),
                  DateTimeField(
                    format: formatTime,
                    onShowPicker: (context, currentValue) async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                      );
                      return DateTimeField.convert(time);
                    },
                    onSaved: (DateTime val){},validator: (DateTime value)=>validate.validateDateTime(value,errorMsg:"Please select time"),
                  ),
                ],crossAxisAlignment: CrossAxisAlignment.start,)),

                SizedBox(width:20.0),

              ]
          ),
          SizedBox(height: 20.0),
          Row(
              children:[
                Text("Thursday"),
                SizedBox(width:20.0),
                Expanded(child:Column(children: <Widget>[
                  Row(children:[ Icon(Icons.access_time),SizedBox(width: 15.0),Text("Begin",style:TextStyle(color:Colors.grey)),]),
                  DateTimeField(
                    format: formatTime,
                    onShowPicker: (context, currentValue) async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                      );
                      return DateTimeField.convert(time);
                    },
                    onSaved: (DateTime val){},validator: (DateTime value)=>validate.validateDateTime(value,errorMsg:"Please select time"),
                  )
                ],crossAxisAlignment: CrossAxisAlignment.start,)),
                SizedBox(width:20.0),
                Expanded(child:Column(children: <Widget>[
                  Row(children:[ Icon(Icons.access_time),SizedBox(width: 15.0),Text("End",style:TextStyle(color:Colors.grey)),]),
                  DateTimeField(
                    format: formatTime,
                    onShowPicker: (context, currentValue) async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                      );
                      return DateTimeField.convert(time);
                    },
                    onSaved: (DateTime val){},validator: (DateTime value)=>validate.validateDateTime(value,errorMsg:"Please select time"),
                  ),
                ],crossAxisAlignment: CrossAxisAlignment.start,)),

                SizedBox(width:20.0),

              ]
          ),
          SizedBox(height: 20.0),
          Row(
              children:[
                Text("Friday"),
                SizedBox(width:20.0),
                Expanded(child:Column(children: <Widget>[
                  Row(children:[ Icon(Icons.access_time),SizedBox(width: 15.0),Text("Begin",style:TextStyle(color:Colors.grey)),]),
                  DateTimeField(
                    format: formatTime,
                    onShowPicker: (context, currentValue) async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                      );
                      return DateTimeField.convert(time);
                    },
                    onSaved: (DateTime val){},validator: (DateTime value)=>validate.validateDateTime(value,errorMsg:"Please select time"),
                  )
                ],crossAxisAlignment: CrossAxisAlignment.start,)),
                SizedBox(width:20.0),
                Expanded(child:Column(children: <Widget>[
                  Row(children:[ Icon(Icons.access_time),SizedBox(width: 15.0),Text("End",style:TextStyle(color:Colors.grey)),]),
                  DateTimeField(
                    format: formatTime,
                    onShowPicker: (context, currentValue) async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                      );
                      return DateTimeField.convert(time);
                    },
                    onSaved: (DateTime val){},validator: (DateTime value)=>validate.validateDateTime(value,errorMsg:"Please select time"),
                  ),
                ],crossAxisAlignment: CrossAxisAlignment.start,)),

                SizedBox(width:20.0),

              ]
          ),
          SizedBox(height: 20.0)
        ],crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.start,
        )
        ),
              SizedBox(height:30.0),
              Row(
                children: <Widget>[
                  RaisedButton(onPressed: ()=>showInSnackBar("SUCCESSFUL"),child: Text("SAVE",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16.0,color: Colors.white)),color:Colors.black,highlightColor: Colors.white,hoverColor: Colors.black,textColor: Colors.black87,padding: EdgeInsets.only(left: 60.0,right: 60.0),)
                ],mainAxisAlignment: MainAxisAlignment.center,
              ),
            ], mainAxisAlignment: MainAxisAlignment.center,
          ),
        );
      }
    }

