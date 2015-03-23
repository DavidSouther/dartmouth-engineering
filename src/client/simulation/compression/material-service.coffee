angular.module('eau.simulation.compression.materials', [

])
.value 'MaterialList',
  "Concrete":
    density: 23e3
    elasticity: 20e9
    stress: 70e6
    color: 'bisque'
  "Granite":
    density: 27e3
    elasticity: 80e9
    stress: 150e6
    color: 'slategrey'
  "Plastic":
    density: 27e3
    elasticity: 2e9
    stress: 50e6
    color: 'honeydew'
  "Glass":
    density: 10e3
    elasticity: 50e9
    stress: 100e6
    color: "paleturquoise"
  "Steel":
    density: 77e3
    elasticity: 200e9
    stress: 250e6
    color: 'lightsteelblue'
  "Wood":
    density: 6e3
    elasticity: 10e9
    stress: 30e6
    color: 'brown'
  "Copper":
    density: 87e3
    elasticity: 100e9
    stress: 150e6
    color: "sienna"

.value 'MomentShapes',
  "Square":
    moment: (b)->
      Math.pow(b, 4) / 12
    crossSection: (b)->
      b * b
  "Hollow Square":
    moment: (b)->
      t = b * .25
      tube = Math.pow(b, 4)
      center = Math.pow((b - 2 * t), 4)
      (tube - center) / 12
    crossSection: (b)->
      t = b * .25
      tube = b * b
      center = Math.pow((b - 2 * t), 2)
      (tube - center)
  "Pipe":
    moment: (d)->
      Math.pow(d, 4) / 65
      # (Math.PI / 64) * Math.pow(d, 4)
    crossSection: (d)->
      Math.PI * d * d * 1/4
  "Hollow Pipe":
    moment: (d)->
      t = d * .25
      pipe = Math.pow(d, 4)
      center = Math.pow((d - 2 * t), 4)
      (Math.PI / 64) * (pipe - center)
    crossSection: (d)->
      t = d * .25
      pipe = d * d
      center = Math.pow((d - 2 * t), 2)
      Math.PI * (pipe - center) * 1/4
