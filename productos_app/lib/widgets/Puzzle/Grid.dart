import 'package:flutter/material.dart';
import 'package:productos_app/preferencias/preferencias_usuario.dart';
import 'package:productos_app/widgets/Puzzle/GridButton.dart';
import 'package:productos_app/widgets/mycolors.dart';

class Grid extends StatelessWidget {

  var numbers = [];
  Map<int, String> imagenes = {};

  var size;
  Function clickGrid;

  Grid(this.numbers, this.size, this.clickGrid, this.imagenes);

  @override
  Widget build(BuildContext context) {
    var height = size.height;

  final pref = PreferenciasUsurario();
  final orientation = MediaQuery.of(context).orientation;

    return Container(
      width: orientation == Orientation.portrait ? 370 : 600,
      height:  orientation == Orientation.portrait ? 370 : 600,
      padding: EdgeInsets.all(8),
      color: pref.getColor ? MyColors.colorRosa : MyColors.colorAzul ,
      child: Center(
        child: GridView.builder(
          shrinkWrap: true,       
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 3,
            crossAxisSpacing: 3,
          ),
          padding: EdgeInsets.all(0),
          itemCount: numbers.length,
          itemBuilder: (context, index) {
            return numbers[index] != 0
                ? GridButton(
                  "${numbers[index]}", 
                  () {
                    clickGrid(index);
                  },
                  imagenes,
                
                  )
                : SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
