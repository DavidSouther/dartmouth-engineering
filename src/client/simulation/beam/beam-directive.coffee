angular.module('eau.simulation.beam', [
  'simulation.beam.template'
  'eau.utilities.scientific'
  'graphing.scales'
  'graphing.svg'
  'ngMaterial'
  'eau.navigation',
  'eau.arrow'
]).config ['SimulationNavProvider', (sims)->
  sims.sim 'beam',
    title: 'Beam'
]
.directive 'beam', ->
  restrict: 'E'
  templateUrl: 'simulation/beam'
  controller: ($scope)->
    s = $scope.simulation =
      length: 10
      support: 8
      load:
        applied: 60
        point: 5
        loading: 'even'

    $scope.$watch 'simulation.length', (nv, ov)->
      if nv < 1
        s.length = nv = 1.0
      ratio = s.support / ov
      s.support = nv * ratio
      ratio = s.load.point / ov
      s.load.point = nv * ratio
      return

    $scope.$watch 'simulation.support', (v)->
      if v > s.length
        s.support = s.length

    $scope.$watch 'simulation.load.point', (v)->
      if v > s.length
        s.load.point = s.length

    $scope.forall = (n)->
      [0..Math.ceil(n)]

    $scope.getXs = ->
      l = s.support
      a = s.length - s.support
      if s.load.loading is 'even'
        interpolate = (arr, right)->
          if arr.length is 0
            [right]
          else
            left = arr[arr.length - 1]
            delta = right - left
            arr.concat [
              left + (delta / 4 * 1),
              left + (delta / 4 * 2),
              left + (delta / 4 * 3)
              right
            ]
        trim = (arr, x)->
          arr = arr.concat(x) if x > 0
          arr

        c1 = 0
        c2 = (l / 2) * (1 - (a * a / (l * l)))
        c3 = l * ( 1 - (a * a) / (l * l))
        c4 = l
        c5 = s.length

        arr =
          if l is 0
            [
              0,
              s.length / 2,
              s.length
            ]
          else if a is 0
            [
              0,
              # l/4,
              l/2,
              # l/4*3,
              l
            ]
          else
            [
              c1,
              c2,
              c3,
              c4,
              c5
            ]

        arr = arr
        .reduce interpolate, []
        .reduce trim, []
        arr.unshift 0
        arr

    $scope.getMs = ->
      l = s.support
      a = s.length - l
      if s.load.loading is 'even'
        w = s.load.applied * s.length
        xs = $scope.getXs()
        R1 = $scope.V(1)
        ms = xs.map (x)->
          if l is 0
            x = a - x
            - w * x * x / 2
          else if x <= l
            ((w * x) / (2 * l)) * ((l * l) - (a * a) - (x * l))
          else
            x = x - l
            -(w / 2) * (a - x) * (a - x)

    $scope.moment = ($scales)->
      xs = $scope.getXs()
      ms = $scope.getMs()
      zip = (x, i)-> [x, ms[i]]
      points = xs.map(zip)
      if s.support is 0
        points.push([0, 0])
      if $scales
        points = points.map((p)->[$scales.xa(p[0]), $scales.yme(p[1])])
        line = d3.svg.line()(points) + 'z'
        line
      else
        points

    $scope.pointMoment = ->
      a = s.load.point
      l = s.support
      P = s.load.applied
      if a <= l
        b = l - a
        P * a * b / l
      else
        -P * (a - l)

    $scope.V = (n)->
      l = s.support
      if s.load.loading is 'even'
        a = s.length - l
        w = s.load.applied * s.length
        switch n
          when 1
            (w / 2 * l) * (l * l - a * a)
          when 2
            w * a
          when 3
            (w / 2 * l) * (l * l + a * a)
      else if s.load.loading is 'point'
        P = s.load.applied
        a = s.load.point
        if l is 0
          -P
        else
          if a > l
            switch n
              when 1
                - P * (a - l) / l
              when 2
                P
          else
            b = l - a
            switch n
              when 1
                P * b / l
              when 2
                - P * a / l
