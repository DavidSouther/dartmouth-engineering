# Default Constants. These all come from a spec (probably an email) somewhere.
START_LENGTH = 2
START_BASE = .25

sut = null
describe 'Compression Simulation', ->
  beforeEach module 'eau.simulation.compression'

  describe 'Controller', ->
    beforeEach inject ($controller)->
      el = renderElement('compression')
      sut = el.$scope

    it 'sets default simulation properties', ->
      sut.simulation.length.should.equal START_LENGTH
      sut.simulation.base.should.equal START_BASE

    it 'calculates correct values', ->
      compressionDataTable.forEach (test, i)->
        console.log(i, test)
        # [ Shape, Material, Diameter, Length | Area, Moment, Compress, Buckle ]
        sut.simulation.length = test[3]
        sut.simulation.base = test[2]
        sut.setCurrentMaterial test[1]
        sut.setCurrentShape test[0]

        sim = sut.simulation

        sim.crossSection().should.be.closeTo test[4], 1e-7, "Area #{i}"
        sim.moment().should.be.closeTo test[5], 1e-7, "Moment #{i}"
        # sim.compression().should.be.closeTo test[6], 1e-7, "Compression #{i}"
        # sim.buckle().should.be.closeTo test[7], 1e-7, "Buckle #{i}"

  describe 'Directive', ->

  describe 'Simulation', ->


compressionDataTable = [
  ['Square', 'Concrete', 0.25, 2, 0.0625, 0.000325520833333333, 4375, 16064],
  ['Square', 'Concrete', 0.25, 4, 0.0625, 0.000325520833333333, 4375, 4016],
  ['Square', 'Concrete', 0.5, 4, 0.25, 0.00520833333333333, 17500, 64255],
  ['Pipe', 'Concrete', 0.25, 4, 0.0490873852123405, 0.000061035156, 3436, 753],
  ['Pipe', 'Concrete', 0.5, 4, 0.196349540849362, 0.0009765625, 13744, 12048],
  ['Pipe', 'Concrete', 0.5, 8, 0.196349540849362, 0.0009765625, 13744, 3012],
  ['Square', 'Plastic', 0.25, 2, 0.0625, 0.000325520833333333, 3125, 1606],
  ['Square', 'Plastic', 0.25, 4, 0.0625, 0.000325520833333333, 3125, 402],
  ['Square', 'Plastic', 0.5, 4, 0.25, 0.00520833333333333, 12500, 6426],
  ['Pipe', 'Plastic', 0.25, 4, 0.0490873852123405, 0.00006103515625, 2454, 75],
  ['Pipe', 'Plastic', 0.5, 4, 0.196349540849362, 0.0009765625, 9817, 1205],
  ['Pipe', 'Plastic', 0.5, 8, 0.196349540849362, 0.0009765625, 9817, 301],
  ['Square', 'Steel', 0.25, 2, 0.0625, 0.000325520833333333, 15625, 160638],
  ['Square', 'Steel', 0.25, 4, 0.0625, 0.000325520833333333, 15625, 40160],
  ['Square', 'Steel', 0.5, 4, 0.25, 0.00520833333333333, 62500, 642552],
  ['Pipe', 'Steel', 0.25, 4, 0.0490873852123405, 0.00006103515625, 12272, 7530],
  ['Pipe', 'Steel', 0.5, 4, 0.196349540849362, 0.0009765625, 49087, 120479],
  ['Pipe', 'Steel', 0.5, 8, 0.196349540849362, 0.0009765625, 49087, 30120],
  ['Square', 'Wood', 0.25, 2, 0.0625, 0.000325520833333333, 1875, 8032],
  ['Square', 'Wood', 0.25, 4, 0.0625, 0.000325520833333333, 1875, 2008],
  ['Square', 'Wood', 0.5, 4, 0.25, 0.00520833333333333, 7500, 32128],
  ['Pipe', 'Wood', 0.25, 4, 0.0490873852123405, 0.00006103515625, 1473, 376],
  ['Pipe', 'Wood', 0.5, 4, 0.196349540849362, 0.0009765625, 5890, 6024],
  ['Pipe', 'Wood', 0.5, 8, 0.196349540849362, 0.0009765625, 5890, 1506],
]
