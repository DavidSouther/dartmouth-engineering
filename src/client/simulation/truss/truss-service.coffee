Math.cotan = (T)->
  Math.cos(T) / Math.sin(T)

class Beam
  constructor: (@from, @to, @load)->

angular.module('eau.simulation.truss.shapes', [
]).value 'Trusses',
  Pratt:
    Center: (span, height)->
      h = height
      P = 10 * span
      hP = 5 * span
      w = span / 4
      T = Math.atan(h / w)
      sT = Math.sin(T)
      cT = Math.cotan(T)

      V = 2 * w

      A = [-V, 0]
      B = [-w, h]
      C = [-w, 0]
      D = [ 0, h]
      E = [ 0, 0]
      F = [ w, h]
      G = [ w, 0]
      H = [ V, 0]

      FAB = -hP / sT
      FAC =  hP * cT
      FBD = -hP * cT
      FBC =  hP
      FCE =  hP * cT
      FCD = -hP / sT
      FED = P
      FEG = FCE
      FDG = FCD
      FDF = FBD
      FFG = FBC
      FFH = FAB
      FGH = FAC

      points: {
        A, B, C, D, E, F, G, H
      },
      beams:
        AB: new Beam A, B, FAB
        AC: new Beam A, C, FAC
        BD: new Beam B, D, FBD
        BC: new Beam B, C, FBC
        CE: new Beam C, E, FCE
        CD: new Beam C, D, FCD

        DE: new Beam D, E, FED

        DG: new Beam D, G, FDG
        EG: new Beam E, G, FEG
        DF: new Beam D, F, FDF
        FG: new Beam F, G, FFG
        FH: new Beam F, H, FFH
        GH: new Beam G, H, FGH

  Howe:
    flat: ->
      beams = []
      beams.push [[0, 0], [0, 1]] # center bar

      for i in [0...2]
        # Bays to the right
        beams.push [[i + 0, 1], [i + 1, 1]]
        beams.push [[i + 1, 1], [i + 1, 0]]
        beams.push [[i + 0, 0], [i + 1, 0]]
        beams.push [[i + 0, 0], [i + 1, 1]] # Diagonal

        # Bays to the left
        beams.push [[-(i + 0), 1], [-(i + 1), 1]]
        beams.push [[-(i + 1), 1], [-(i + 1), 0]]
        beams.push [[-(i + 0), 0], [-(i + 1), 0]]
        beams.push [[-(i + 0), 0], [-(i + 1), 1]] # Diagonal

      beams.push [[i + 0, 0], [i + 1, 0]]
      beams.push [[i + 0, 1], [i + 1, 0]] # Diagonal

      beams.push [[-(i + 0), 0], [-(i + 1), 0]]
      beams.push [[-(i + 0), 1], [-(i + 1), 0]] # Diagonal

      beams
