describe 'Brick Directive', ->
  sut = null
  ctrlConstructor = null

  beforeEach module 'eau.simulation.brick'

  beforeEach inject ($controller) ->
    ctrlConstructor = $controller 'BrickCtrl', {}, true

  describe 'positionMultiplier', ->
    it 'should be 1 if it is undefined when constructing', ->
      sut = ctrlConstructor()
      expect(sut.positionMultiplier).to.equal 1

    it 'should be the construction value if larger than 1', ->
      ctrlConstructor.instance.positionMultiplier = 10
      sut = ctrlConstructor()
      expect(sut.positionMultiplier).to.equal 10

  describe 'getX', ->
    it 'should return the x value times the positionMultiplier', ->
      ctrlConstructor.instance.positionMultiplier = 10
      sut = ctrlConstructor()
      sut.x = 10
      expect(sut.getX()).to.equal 100

  describe 'getY', ->
    it 'should return the y value times the positionMultiplier', ->
      ctrlConstructor.instance.positionMultiplier = 5
      sut = ctrlConstructor()
      sut.y = 10
      expect(sut.getY()).to.equal 50

