# Default Constants. These all come from a spec (probably an email) somewhere.
START_WIDTH = 4
START_PULL = 2
START_DIAMETER = 10
START_MATERIAL = 'Steel'

sut = null

tensionDataTable = [
  ['Nylon', 50000, 1, 0.785, 1, 2, 1.326, 39270, 76195],
  ['Nylon', 50000, 5, 19.635, 5, 4, 1.012, 981748, 1665041],
  ['Nylon', 50000, 10, 78.540, 10, 6, 0.876, 3926991, 6033596],
  ['Nylon', 50000, 15, 176.715, 15, 8, 0.818, 8835729, 12891987],
  ['Nylon', 50000, 20, 314.159, 20, 10, 0.785, 15707963, 22214415],
  ['Nylon', 50000, 25, 490.874, 1, 2, 1.326, 24543693, 47621759],
  ['Nylon', 50000, 30, 706.858, 5, 4, 1.012, 35342917, 59941468],
  ['Nylon', 50000, 35, 962.113, 10, 6, 0.876, 48105638, 73911549],
  ['Nylon', 50000, 40, 1256.637, 15, 8, 0.818, 62831853, 91676349],
  ['Nylon', 50000, 50, 1963.495, 20, 10, 0.785, 98174770, 138840092],
  ['Steel', 250000, 1, 0.785, 1, 2, 1.326, 196350, 380974],
  ['Steel', 250000, 5, 19.635, 5, 4, 1.012, 4908739, 8325204],
  ['Steel', 250000, 10, 78.540, 10, 6, 0.876, 19634954, 30167979],
  ['Steel', 250000, 15, 176.715, 15, 8, 0.818, 44178647, 64459933],
  ['Steel', 250000, 20, 314.159, 20, 10, 0.785, 78539816, 111072073],
  ['Steel', 250000, 25, 490.874, 1, 2, 1.326, 122718463, 238108793],
  ['Steel', 250000, 30, 706.858, 5, 4, 1.012, 176714587, 299707340],
  ['Steel', 250000, 35, 962.113, 10, 6, 0.876, 240528188, 369557744],
  ['Steel', 250000, 40, 1256.637, 15, 8, 0.818, 314159265, 458381744],
  ['Steel', 250000, 50, 1963.495, 20, 10, 0.785, 490873852, 694200459],
]

describe 'Tension Simulation', ->
  beforeEach module 'eau.simulation.tension'

  describe 'Controller', ->
    it 'sets default simulation properties', ->
      el = renderElement('tension')
      sut = el.$scope
      sut.simulation.width.should.equal START_WIDTH
      sut.simulation.pull.should.equal START_PULL
      sut.simulation.diameter.should.equal START_DIAMETER
      sut.simulation.material.name.should.equal START_MATERIAL

    describe 'Calculation', ->
      tensionDataTable.forEach (test, i)->
        # [
        #   Material, Strength, Diameter | Area |
        #   Span, Depth | Angle, Tension, Load
        # ]
        setup = ->
          el = renderElement('tension')
          sut = el.$scope
          mdx = if test[0] is 'Steel' then 0 else 1
          sut.simulation.material = sut.materials[mdx]
          sut.simulation.width = test[4]
          sut.simulation.pull = test[5]
          sut.simulation.diameter = test[2]

        it "is correct for #{test[2]}mm #{test[0]}", ->
          setup()
          sut.theta().should.be.closeTo test[6], 1e-2, "Theta #{i}"
          sut.area().should.be.closeTo test[3], 1e-2, "Area #{i}"
          sut.simulation.stress().should.be.closeTo test[7], 1e2, "Tension #{i}"
          sut.simulation.load().should.be.closeTo test[8], 1e2, "Load #{i}"

  describe 'Directive', ->

  describe 'Simulation', ->
