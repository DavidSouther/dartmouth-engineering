START_SPAN_TRUSS = 40
START_HEIGHT_TRUSS = 3
START_LOAD = 120
START_LOADING = 'Center'
START_FORM = 'Howe'

trussData =
  howe:
    left:
      AB: -127
      AC: 90
      BD: -90
      BC: 90
      CD: 42
      CE: 60
      DE: 0
      EG: 60
      DG: -42
      DF: -30
      FH: -42
      FG: 30
      GH: 30
    center:
      AB: -85
      AC: 60
      BD: -60
      BC: 60
      CD: -85
      CE: 120
      DE: 120
      EG: 120
      DG: -85
      DF: -60
      FH: -85
      FG: 60
      GH: 60
    triple:
      AB: -85
      AC: 60
      BD: -60
      BC: 60
      CD: -28
      CE: 80
      DE: 40
      EG: 80
      DG: -28
      DF: -60
      FH: -85
      FG: 60
      GH: 60
  pratt:
    left:
      AB: -127
      AC: 90
      BD: -60
      BC: 120
      BE: -42
      CE: 90
      DE: 0
      EG: 30
      EF: 42
      DF: -60
      FH: -42
      FG: 0
      GH: 30
    center:
      AB: -85
      AC: 60
      BD: -120
      BC: 0
      BE: 85
      CE: 60
      DE: 0
      EG: 60
      EF: 85
      DF: -120
      FH: -85
      FG: 0
      GH: 60
    triple:
      AB: -85
      AC: 60
      BD: -80
      BC: 40
      BE: 28
      CE: 60
      DE: 0
      EG: 60
      EF: 28
      DF: -80
      FH: -85
      FG: 40
      GH: 60

describe 'Truss Simulation', ->
  beforeEach module 'eau.simulation.truss'

  describe 'Controller', ->
    it 'sets default simulation properties', ->
      el = renderElement('truss')
      sut = el.$scope
      sut.simulation.span.should.equal START_SPAN_TRUSS
      sut.simulation.height.should.equal START_HEIGHT_TRUSS
      sut.simulation.load.should.equal START_LOAD
      sut.simulation.loading.should.equal START_LOADING
      sut.simulation.form.should.equal START_FORM

    compare = (expectDE, loading, form)->
      describe form, ->
        sut = null
        beforeEach ->
          el = renderElement 'truss'
          sut = el.$scope
          sut.simulation.height = 3
          sut.simulation.span = 12
          sut.simulation.load = 120
          sut.simulation.form = form
          sut.simulation.loading = loading

        describe loading, ->
          assertSL = (span, load)->
            it "spans #{span} at #{load}kN", ->
              actual = sut.truss().beams[span].load
              Math.round(actual).should.equal load
          for span, load of expectDE
            assertSL span, load

    test = (data, form)->
      compare data.triple, 'Even', form
      compare data.center, 'Center', form
      compare data.left, 'Left', form

    test trussData.howe, 'Howe'
    test trussData.pratt, 'Pratt'
