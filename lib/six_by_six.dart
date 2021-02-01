import 'dart:async';

import 'package:new2048/grid_properties.dart';
import 'package:flutter/material.dart';

class SixBySix extends StatefulWidget {
  @override
  SixBySixState createState() => SixBySixState();
}

class SixBySixState extends State<SixBySix>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  List<List<Tile>> grid =
  List.generate(6, (y) => List.generate(6, (x) => Tile(x, y, 0)));
  List<Tile> toAdd = [];

  Iterable<Tile> get gridTiles => grid.expand((e) => e);
  Iterable<Tile> get allTiles => [gridTiles, toAdd].expand((e) => e);
  List<List<Tile>> get gridCols =>
      List.generate(6, (x) => List.generate(6, (y) => grid[y][x]));

  Timer aiTimer;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          toAdd.forEach((e) => grid[e.y][e.x].value = e.value);
          gridTiles.forEach((t) => t.resetAnimations());
          toAdd.clear();
        });
      }
    });

    setupNewGame();
  }

  @override
  Widget build(BuildContext context) {
    double contentPadding = 16;
    double borderSize = 4;
    double gridSize = MediaQuery.of(context).size.width - contentPadding * 2;
    double tileSize = (gridSize - borderSize * 2) / 6;
    List<Widget> stackItems = [];
    stackItems.addAll(gridTiles.map((t) => TileWidget(
        x: tileSize * t.x,
        y: tileSize * t.y,
        containerSize: tileSize,
        size: tileSize - borderSize * 2,
        color: lightBrown)));
    stackItems.addAll(allTiles.map((tile) => AnimatedBuilder(
        animation: controller,
        builder: (context, child) => tile.animatedValue.value == 0
            ? SizedBox()
            : TileWidget(
            x: tileSize * tile.animatedX.value,
            y: tileSize * tile.animatedY.value,
            containerSize: tileSize,
            size: (tileSize - borderSize * 2) * tile.size.value,
            color: numTileColor[tile.animatedValue.value],
            child: Center(child: TileNumber(tile.animatedValue.value))))));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: orange,
        title: Text("6 X 6"),      ),
        backgroundColor: tan,
        body: Padding(
            padding: EdgeInsets.all(contentPadding),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Swiper(
                      up: () => merge(mergeUp),
                      down: () => merge(mergeDown),
                      left: () => merge(mergeLeft),
                      right: () => merge(mergeRight),
                      child: Container(
                          height: gridSize,
                          width: gridSize,
                          padding: EdgeInsets.all(borderSize),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(cornerRadius),
                              color: darkBrown),
                          child: Stack(
                            children: stackItems,
                          ))),
                  RestartButton(onPressed: setupNewGame)
                ])));
  }

  void merge(bool Function() mergeFn) {
    setState(() {
      if (mergeFn()) {
        addNewTiles([2]);
        controller.forward(from: 0);
      }
    });
  }

  bool mergeLeft() => grid.map((e) => mergeTiles(e)).toList().any((e) => e);

  bool mergeRight() =>
      grid.map((e) => mergeTiles(e.reversed.toList())).toList().any((e) => e);

  bool mergeUp() => gridCols.map((e) => mergeTiles(e)).toList().any((e) => e);

  bool mergeDown() => gridCols
      .map((e) => mergeTiles(e.reversed.toList()))
      .toList()
      .any((e) => e);

  bool mergeTiles(List<Tile> tiles) {
    bool didChange = false;
    for (int i = 0; i < tiles.length; i++) {
      for (int j = i; j < tiles.length; j++) {
        if (tiles[j].value != 0) {
          Tile mergeTile = tiles
              .skip(j + 1)
              .firstWhere((t) => t.value != 0, orElse: () => null);
          if (mergeTile != null && mergeTile.value != tiles[j].value) {
            mergeTile = null;
          }
          if (i != j || mergeTile != null) {
            didChange = true;
            int resultValue = tiles[j].value;
            tiles[j].moveTo(controller, tiles[i].x, tiles[i].y);
            if (mergeTile != null) {
              resultValue += mergeTile.value;
              mergeTile.moveTo(controller, tiles[i].x, tiles[i].y);
              mergeTile.bounce(controller);
              mergeTile.changeNumber(controller, resultValue);
              mergeTile.value = 0;
              tiles[j].changeNumber(controller, 0);
            }
            tiles[j].value = 0;
            tiles[i].value = resultValue;
          }
          break;
        }
      }
    }
    return didChange;
  }

  void addNewTiles(List<int> values) {
    List<Tile> empty = gridTiles.where((t) => t.value == 0).toList();
    empty.shuffle();
    for (int i = 0; i < values.length; i++) {
      toAdd.add(Tile(empty[i].x, empty[i].y, values[i])..appear(controller));
    }
  }

  void setupNewGame() {
    setState(() {
      gridTiles.forEach((t) {
        t.value = 0;
        t.resetAnimations();
      });
      toAdd.clear();
      addNewTiles([2, 2]);
      controller.forward(from: 0);
    });
  }
}

class Tile {
  final int x;
  final int y;

  int value;

  Animation<double> animatedX;
  Animation<double> animatedY;
  Animation<double> size;

  Animation<int> animatedValue;

  Tile(this.x, this.y, this.value) {
    resetAnimations();
  }

  void resetAnimations() {
    animatedX = AlwaysStoppedAnimation(x.toDouble());
    animatedY = AlwaysStoppedAnimation(y.toDouble());
    size = AlwaysStoppedAnimation(1.0);
    animatedValue = AlwaysStoppedAnimation(value);
  }

  void moveTo(Animation<double> parent, int x, int y) {
    Animation<double> curved =
    CurvedAnimation(parent: parent, curve: Interval(0.0, moveInterval));
    animatedX =
        Tween(begin: this.x.toDouble(), end: x.toDouble()).animate(curved);
    animatedY =
        Tween(begin: this.y.toDouble(), end: y.toDouble()).animate(curved);
  }

  void bounce(Animation<double> parent) {
    size = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.2), weight: 1.0),
      TweenSequenceItem(tween: Tween(begin: 1.2, end: 1.0), weight: 1.0),
    ]).animate(
        CurvedAnimation(parent: parent, curve: Interval(moveInterval, 1.0)));
  }

  void changeNumber(Animation<double> parent, int newValue) {
    animatedValue = TweenSequence([
      TweenSequenceItem(tween: ConstantTween(value), weight: .01),
      TweenSequenceItem(tween: ConstantTween(newValue), weight: .99),
    ]).animate(
        CurvedAnimation(parent: parent, curve: Interval(moveInterval, 1.0)));
  }

  void appear(Animation<double> parent) {
    size = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: parent, curve: Interval(moveInterval, 1.0)));
  }
}

class TileWidget extends StatelessWidget {
  final double x;
  final double y;
  final double containerSize;
  final double size;
  final Color color;
  final Widget child;

  const TileWidget(
      {Key key,
        this.x,
        this.y,
        this.containerSize,
        this.size,
        this.color,
        this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Positioned(
      left: x,
      top: y,
      child: Container(
          width: containerSize,
          height: containerSize,
          child: Center(
              child: Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(cornerRadius),
                      color: color),
                  child: child))));
}

class TileNumber extends StatelessWidget {
  final int val;

  const TileNumber(this.val, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Text("$val",
      style: TextStyle(
          color: numTextColor[val],
          fontSize: val > 128 ? 21 : 26,
          fontWeight: FontWeight.w900));
}

class RestartButton extends StatelessWidget {
  final void Function() onPressed;

  const RestartButton({Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
      height: 80,
      width: 400,
      child: RaisedButton(
        color: orange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cornerRadius),
        ),
        child: Text("Restart",
            style: TextStyle(
                color: Colors.white,
                fontSize: 34,
                fontWeight: FontWeight.w700)),
        onPressed: onPressed,
      ));
}

class Swiper extends StatelessWidget {
  final Function() up;
  final Function() down;
  final Function() left;
  final Function() right;
  final Widget child;

  const Swiper({Key key, this.up, this.down, this.left, this.right, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
      onVerticalDragEnd: (details) {
        if (details.velocity.pixelsPerSecond.dy < -250) {
          up();
        } else if (details.velocity.pixelsPerSecond.dy > 250) {
          down();
        }
      },
      onHorizontalDragEnd: (details) {
        if (details.velocity.pixelsPerSecond.dx < -1000) {
          left();
        } else if (details.velocity.pixelsPerSecond.dx > 1000) {
          right();
        }
      },
      child: child);
}