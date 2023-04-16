import 'package:flutter/material.dart';
import 'package:productos_app/preferencias/preferencias_usuario.dart';
import 'package:productos_app/providers/form_score_provider.dart';
import 'package:productos_app/services/score_services.dart';
import 'package:productos_app/ui/InputDecorations.dart';
import 'package:productos_app/widgets/mycolors.dart';
import 'package:provider/provider.dart';


class FormScore extends StatelessWidget {

  final int move;
  final int time;

  FormScore(this.move, this.time);
  
  @override
  Widget build(BuildContext context) {
    final scoreService = Provider.of<ScoreService>(context);

     return ChangeNotifierProvider(
      create: (_) => FormScoreProvider(scoreService.score!),
      child: _Body(move: move, time: time)
    );  
    
  }
}

class _Body extends StatelessWidget {
  const _Body({
    Key? key,
    required this.move,
    required this.time,
  }) : super(key: key);

  final int move;
  final int time;

  @override
  Widget build(BuildContext context) {

    final formScore  = Provider.of<FormScoreProvider>(context);
    final scoreService = Provider.of<ScoreService>(context);

    final pref = PreferenciasUsurario();



    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 2),
      child: Form(
          key: formScore.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [      
              
              //Nombre
        
              TextFormField(
        
                onChanged: (value) {
                  formScore.updateNombre(value);
                },
                validator: (value) {
                  if (value == null || value.length < 5) {
                    return 'Ingrese Nombre y Apellido';
                  }
                },
                maxLength: 20,
                keyboardType: TextInputType.name,
                decoration: InputDecorations.decorationInput(
                    hinText: 'Nombre',
                    labelTex: 'Nombre y Apellido',
                    iconData: Icons.person),
              ),
        
              SizedBox(height: 5),
        
              //Movimientos
        
              TextFormField(
                enabled: false,
                initialValue: move.toString(),
                onChanged: ( value ) => formScore.updateMovimientos(move)
              ,
                keyboardType: TextInputType.number,
                decoration: InputDecorations.decorationInput(
                    hinText: 'Movimientos',
                    labelTex: 'Movimientos',
                    iconData: Icons.slow_motion_video_sharp),
              ),
        
              SizedBox(height: 5),
        
                //Tiempo
        
                TextFormField(
                enabled: false,
                initialValue: time.toString(),
                onChanged: (value) {
                  formScore.updateTiempo(time);
        
                },
                autocorrect: false,
                keyboardType: TextInputType.number,
                decoration: InputDecorations.decorationInput(
                    hinText: 'Tiempo',
                    labelTex: 'Tiempo',
                    iconData: Icons.timelapse),
              ),
        
              SizedBox(height: 30),
        
               SizedBox(
                width: 220.0,
                child: ElevatedButton(
       
        
                  onPressed: scoreService.isSaving 
                  ? null
                  : () async {
        
                    print(formScore.isValidFomr());
        
                    formScore.updateMovimientos(move);
                    formScore.updateTiempo(time);
                    
                    if (!formScore.isValidFomr()) return;
                      await scoreService
                          .saveOrCreateProduct(formScore.score);
        
                      
                  },
                   style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(pref.getColor
                          ? scoreService.isSaving ? Colors.grey.shade300 : MyColors.colorRosa
                          : scoreService.isSaving ? Colors.grey.shade300 :MyColors.colorAzul
                          )),
                  child: Text(
                    scoreService.isSaving 
                    ? "Guardando"
                    : "Finalizar",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
             
            ],
          )),
    );
  }
}
