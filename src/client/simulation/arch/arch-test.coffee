# Default Constants. These all come from a spec (probably an email) somewhere.
START_APPLIED = 25
START_HEIGHT = 200
START_SPAN = 200

sut = null

archDataTable = [
  # [ Applied, Height, Span | Compress, Horizontal, Vertical ]
  [50, 40, 100, 1563, 1563, 2500],
  [50, 80, 200, 3125, 3125, 5000],
  [50, 120, 300, 4688, 4688, 7500],
  [50, 240, 400, 4167, 4167, 10000],
  [100, 40, 100, 3125, 3125, 5000],
  [100, 80, 200, 6250, 6250, 10000],
  [100, 120, 300, 9375, 9375, 15000],
  [100, 240, 400, 8333, 8333, 20000],
  [150, 40, 100, 4688, 4688, 7500],
  [150, 80, 200, 9375, 9375, 15000],
  [150, 120, 300, 14063, 14063, 22500],
  [150, 240, 400, 12500, 12500, 30000],
  [200, 40, 100, 6250, 6250, 10000],
  [200, 80, 200, 12500, 12500, 20000],
  [200, 120, 300, 18750, 18750, 30000],
  [200, 240, 400, 16667, 16667, 40000],
  [250, 40, 100, 7813, 7813, 12500],
  [250, 80, 200, 15625, 15625, 25000],
  [250, 120, 300, 23438, 23438, 37500],
  [250, 240, 400, 20833, 20833, 50000]
]

describe 'Arch Simulation', ->
  beforeEach module 'eau.simulation.arch'

  describe 'Controller', ->
    it 'sets default simulation properties', ->
      el = renderElement('arch')
      sut = el.$scope
      sut.simulation.applied.should.equal START_APPLIED
      sut.simulation.height.should.equal START_HEIGHT
      sut.simulation.span.should.equal START_SPAN

    describe 'Calculation (height x span @ applied)', ->
      archDataTable.forEach (test)->
        setup = ->
          el = renderElement('arch')
          sut = el.$scope

        it "is correct for #{test[1]}m x #{test[2]}m @ #{test[0]}N", ->
          setup()
          # [ Applied, Height, Span | Compress, Horizontal, Vertical ]
          sut.simulation.applied = test[0]
          sut.simulation.height = test[1]
          sut.simulation.span = test[2]

          sut.force.compressive().should.be.closeTo test[3], 1e0
          sut.force.horizontal().should.be.closeTo test[4], 1e-7
          sut.force.vertical().should.be.closeTo test[5], 1e-7

  describe 'Directive', ->

  describe 'Simulation', ->
