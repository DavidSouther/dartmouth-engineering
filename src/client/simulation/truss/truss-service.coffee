Math.cotan = (T)->
  Math.cos(T) / Math.sin(T)

class Beam
  constructor: (@from, @to, @load)->

angular.module('eau.simulation.truss.shapes', [
]).value 'Trusses',
  Howe:
    Center: (span, height, load)->
      h = height
      P = load
      hP = 0.5 * P
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

    Left: (span, height, load)->
      h = height
      P = load
      tP = 0.75 * P
      hP = 0.50 * P
      qP = 0.25 * P
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

      FAB = -tP / sT
      FAC =  tP * cT
      FBD = -tP * cT
      FBC =  tP
      FCD =  qP / sT
      FCE =  hP * cT
      FED = 0 # Actually zero, but that breaks the log scale.
      FEG =  hP
      FDG = -qP / sT
      FDF = -qP * cT
      FFH = -qP / sT
      FFG = qP
      FGH = qP * cT

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

    Even: (span, height, load)->
      h = height
      P = load / 3
      hP = 0.5 * P
      oP = 1.5 * P
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

      FAB = -oP / sT
      FAC =  oP * cT
      FBD = -oP * cT
      FBC =  oP
      FCE = 2*P * cT
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

  Pratt:
    Center: (span, height, load)->
      h = height
      P = load
      hP = 0.5 * P
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
      FBC =  0
      FBD = -P * cT
      FBE = -hP / sT
      FCE =  hP * cT
      FED = 0
      FEF = FBE
      FEG = FCE
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
        BC: new Beam B, C, FBC
        BD: new Beam B, D, FBD
        BE: new Beam B, E, FBE
        CE: new Beam C, E, FCE

        DE: new Beam D, E, FED

        DF: new Beam D, F, FDF
        EF: new Beam E, F, FEF
        EG: new Beam E, G, FEG
        FG: new Beam F, G, FFG
        FH: new Beam F, H, FFH
        GH: new Beam G, H, FGH

    Left: (span, height, load)->
      h = height
      P = load
      tP = 0.75 * P
      hP = 0.50 * P
      qP = 0.25 * P
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

      FAB = -tP / sT
      FAC =  tP * cT
      FBC =  P
      FBD = -hP * cT
      FBE = -qP / sT
      FCE =  hP * cT
      FED = 0
      FEF =  qP * cT
      FEG =  qP / sT
      FDF = -hP * cT
      FFG = 0
      FFH = -qP / sT
      FGH =  qP * cT

      points: {
        A, B, C, D, E, F, G, H
      },
      beams:
        AB: new Beam A, B, FAB
        AC: new Beam A, C, FAC
        BC: new Beam B, C, FBC
        BD: new Beam B, D, FBD
        BE: new Beam B, E, FBE
        CE: new Beam C, E, FCE

        DE: new Beam D, E, FED

        DF: new Beam D, F, FDF
        EF: new Beam E, F, FEF
        EG: new Beam E, G, FEG
        FG: new Beam F, G, FFG
        FH: new Beam F, H, FFH
        GH: new Beam G, H, FGH

    Even: (span, height, load)->
      h = height
      P = load / 3
      hP = 0.5 * P
      oP = 1.5 * P
      tP = 3.0 * P
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

      FAB = -oP / sT
      FAC =  oP * cT
      FBC =   P
      FBD = -tP * cT
      FBE =  hP / sT
      FCE =  oP * cT
      FED = 0
      FEF = FBE
      FEG = FCE
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
        BC: new Beam B, C, FBC
        BD: new Beam B, D, FBD
        BE: new Beam B, E, FBE
        CE: new Beam C, E, FCE

        DE: new Beam D, E, FED

        DF: new Beam D, F, FDF
        EF: new Beam E, F, FEF
        EG: new Beam E, G, FEG
        FG: new Beam F, G, FFG
        FH: new Beam F, H, FFH
        GH: new Beam G, H, FGH
