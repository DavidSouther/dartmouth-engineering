describe 'Engineering Around Us', ->
  describe 'Title Service', ->
    beforeEach module 'eau.title-service'

    it 'has a good title', inject (TitleSvc)->
      TitleSvc.title.should.equal 'Engineering Around Us'
