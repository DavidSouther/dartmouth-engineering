angular.module('eau.simulation.truss.shapes', [

]).value 'Trusses',
  Pratt:
    flat: (bays = 2)->
      beams = []
      beams.push [[0, 0], [0, 1]] # center bar

      for i in [0...bays]
        # Bays to the right
        beams.push [[i + 0, 1], [i + 1, 1]]
        beams.push [[i + 1, 1], [i + 1, 0]]
        beams.push [[i + 0, 0], [i + 1, 0]]
        beams.push [[i + 0, 1], [i + 1, 0]] # Diagonal

        # Bays to the left
        beams.push [[-(i + 0), 1], [-(i + 1), 1]]
        beams.push [[-(i + 1), 1], [-(i + 1), 0]]
        beams.push [[-(i + 0), 0], [-(i + 1), 0]]
        beams.push [[-(i + 0), 1], [-(i + 1), 0]] # Diagonal

      beams.push [[i + 0, 0], [i + 1, 0]]
      beams.push [[i + 0, 1], [i + 1, 0]] # Diagonal

      beams.push [[-(i + 0), 0], [-(i + 1), 0]]
      beams.push [[-(i + 0), 1], [-(i + 1), 0]] # Diagonal

      beams

  Howe:
    flat: (bays = 2)->
      beams = []
      beams.push [[0, 0], [0, 1]] # center bar

      for i in [0...bays]
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
