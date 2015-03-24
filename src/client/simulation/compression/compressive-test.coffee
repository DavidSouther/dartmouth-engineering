# Default Constants. These all come from a spec (probably an email) somewhere.
START_LENGTH = 2
START_BASE = .25

sut = null

compressionDataTable = [
  ['Square', 'Concrete', 0.25, 2, 0.0625, 0.00032552083, 4375, 16064],
  ['Square', 'Concrete', 0.25, 4, 0.0625, 0.00032552083, 4375, 4016],
  ['Square', 'Concrete', 0.5, 4, 0.25, 0.0052083333, 17500, 64255],
  ['Pipe', 'Concrete', 0.25, 4, 0.0490873, 0.000191747598485705, 3436, 2366],
  ['Pipe', 'Concrete', 0.5, 4, 0.1963495, 0.00306796157577128, 13744, 37849],
  ['Pipe', 'Concrete', 0.5, 8, 0.1963495, 0.00306796157577128, 13744, 9462],
  ['Square', 'Plastic', 0.25, 2, 0.0625, 0.000325520833333333, 3125, 1606],
  ['Square', 'Plastic', 0.25, 4, 0.0625, 0.000325520833333333, 3125, 402],
  ['Square', 'Plastic', 0.5, 4, 0.25, 0.00520833333333333, 12500, 6426],
  ['Pipe', 'Plastic', 0.25, 4, 0.049087385, 0.000191747598485705, 2454, 237],
  ['Pipe', 'Plastic', 0.5, 4, 0.1963495408, 0.00306796157577128, 9817, 3785],
  ['Pipe', 'Plastic', 0.5, 8, 0.1963495408, 0.00306796157577128, 9817, 946],
  ['Square', 'Steel', 0.25, 2, 0.0625, 0.000325520833333333, 15625, 160638],
  ['Square', 'Steel', 0.25, 4, 0.0625, 0.000325520833333333, 15625, 40160],
  ['Square', 'Steel', 0.5, 4, 0.25, 0.00520833333333333, 62500, 642552],
  ['Pipe', 'Steel', 0.25, 4, 0.049087385, 0.000191747598485705, 12272, 23656],
  ['Pipe', 'Steel', 0.5, 4, 0.196349540, 0.00306796157577128, 49087, 378495],
  ['Pipe', 'Steel', 0.5, 8, 0.196349540, 0.00306796157577128, 49087, 94624],
  ['Square', 'Wood', 0.25, 2, 0.0625, 0.000325520833333333, 1875, 8032],
  ['Square', 'Wood', 0.25, 4, 0.0625, 0.000325520833333333, 1875, 2008],
  ['Square', 'Wood', 0.5, 4, 0.25, 0.00520833333333333, 7500, 32128],
  ['Pipe', 'Wood', 0.25, 4, 0.049087385, 0.000191747598485705, 1473, 1183],
  ['Pipe', 'Wood', 0.5, 4, 0.1963495408, 0.00306796157577128, 5890, 18925],
  ['Pipe', 'Wood', 0.5, 8, 0.1963495408, 0.00306796157577128, 5890, 4731],
]

describe 'Compression Simulation', ->
  beforeEach module 'eau.simulation.compression'

  describe 'Controller', ->
    it 'sets default simulation properties', ->
      el = renderElement('compression')
      sut = el.$scope
      sut.simulation.length.should.equal START_LENGTH
      sut.simulation.base.should.equal START_BASE

    describe 'Calculation (material as shape (base x height))', ->
      compressionDataTable.forEach (test, i)->
        # [ Shape, Material, Diameter, Length | Area, Moment, Compress, Buckle ]
        it "is correct for #{test[1]} as #{test[0]} (#{test[2]}x#{test[3]})", ->
          el = renderElement('compression')
          sut = el.$scope

          sut.simulation.length = test[3]
          sut.simulation.base = test[2]
          sut.setCurrentMaterial test[1]
          sut.setCurrentShape test[0]

          sim = sut.simulation
          debugger
          sim.crossSection().should.be.closeTo test[4], 1e-5, "Area"
          sim.moment().should.be.closeTo test[5], 3e-5, "Moment"
          sim.compression().should.be.closeTo test[6], 1e0, "Compression"
          sim.buckle().should.be.closeTo test[7], 1e0, "Buckle"

  describe 'Directive', ->

  describe 'Simulation', ->
