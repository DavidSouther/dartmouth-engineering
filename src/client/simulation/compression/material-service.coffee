angular.module('eau.simulation.compression.materials', [

])
.value 'MaterialList',
  "Granite":
    density: 2750
    elasticity: 10e9
  "Wood":
    density: 630
    elasticity: 10e9
  "Steel":
    density: 7750
    elasticity: 200
.value 'MomentShapes',
  "Brick":
    moment: (b)->
      Math.pow(b, 4) / 12
  "Hollow Brick":
    moment: (b)->
      t = b * .25
      tube = Math.pow(b, 4)
      center = Math.pow((b - 2 * t), 4)
      (tube - center) / 12
  "Pipe":
    moment: (d)->
      (Math.PI / 64) * Math.pow(d, 4)
  "Hollow Pipe":
    moment: (d)->
      t = d * .25
      pipe = Math.pow(d, 4)
      center = Math.pow((d - 2 * t), 4)
      (Math.PI / 64) * (pipe - center)
