import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

    void main(){
        runApp(MaterialApp(
          home: Home(),
        ),);    // MaterialApp
    }

    class Home extends StatefulWidget {
      @override
      _HomeState createState() => _HomeState();
    }

    class _HomeState extends State<Home>{

      // Objetos controller da Gasolina e Etanol
      TextEditingController precoGasolinaController = TextEditingController();
      TextEditingController precoEtanolController = TextEditingController();

      //criando variavel responsavel por controle do formulario
      GlobalKey<FormState> _formKey = GlobalKey<FormState>();

      String _info = "Informe os preços dos combustiveis!";

      void _resetFields(){
        precoEtanolController.text = "";
        precoGasolinaController.text = "";

        setState(() {
          _info = "Informe os preços dos combustiveiss!";
          _formKey = GlobalKey<FormState>();
        });
      }

      void _changeTextError() {
        _info = "Informação invalida";
      }


      void _calculaMelhorCombustivel(){
        setState( () {
          double precoEtanol = double.parse(precoEtanolController.text);
          double precoGasolina = double.parse(precoGasolinaController.text);
          double coeficiente = precoEtanol / precoGasolina;
          print(coeficiente);
          _info = (coeficiente < 0.7) ? "Etanol é a melhor opção" : "Gasolina é a melhor opção" ;
        });
     }

      @override
        Widget build(BuildContext context){
          return Scaffold(

            appBar: AppBar(
              title: Text("Qual combustível?"),
              centerTitle: true,

              //Borda arredondada
              shape: new RoundedRectangleBorder(borderRadius:
              new BorderRadius.circular(5.0)),

              actions: <Widget>[
                IconButton(icon: Icon(Icons.refresh),
                onPressed: () {_resetFields();}) //chama a funcao refresh
                ],
            ),

            body: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 0.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[

                    //Icone central
                    //Icon(Icons.time_to_leave, size: 50.0, color: Colors.blue),
                    Icon(Icons.local_gas_station, size: 150.0, color: Colors.blue),

                    TextFormField(
                      controller: precoGasolinaController, //chamando o controller
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Gasolina R\$",
                          labelStyle: TextStyle(color: Colors.black)
                      ),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontSize: 20.0),
                      validator: (value){
                        if(value.isEmpty){
                          return "Informe o preço da Gasolina!";
                        }
                      },
                    ),

                    TextFormField(
                      controller: precoEtanolController, //chamando o controller
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Etanol R\$",
                          labelStyle: TextStyle(color: Colors.black)
                      ),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontSize: 20.0),
                      validator: (value){
                        if(value.isEmpty){
                          return "Informe valor do Etanol";
                        }
                      },

                    ),

                    Padding(
                      padding: EdgeInsets.only(top:20.0, bottom: 20.0),
                      child: Container(
                        height: 50.0,
                        child: RaisedButton(



                            onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  _calculaMelhorCombustivel();
                                }

                              },

                            //Borda arredondada
                            shape: new RoundedRectangleBorder(borderRadius:
                            new BorderRadius.circular(10.0)),

                            child: Text("Calcular",
                              style: TextStyle(color: Colors.white, fontSize: 20.0),
                            ) ,
                            color: Colors.blue
                        ),
                      ),
                    ),

                    //Text("Informações",textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 20.0),)
                    Text(_info, textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontSize: 20.0),
                    )

                  ],
                ),

              ),

            )

          );
        }
      }
