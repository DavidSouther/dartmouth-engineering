angular.module('eau.simulation.arch', [
  'eau.navigation'
  'eau.arrow'
  'simulation.arch.template'
])
.config ['SimulationNavProvider', (sims)->
  sims.sim 'arch',
    title: 'Arch'
]
.directive 'arch', ->
  restrict: 'E'
  templateUrl: 'simulation/arch'
  controller: ($scope)->
    $scope.simulation =
      applied: 1e2 # The applied load, w,  should be in ‘kN/m’
      height: 200
      span: 200

    $scope.appliedArrows = ->
      [0...Math.floor($scope.simulation.span / 2 / 30)]

    $scope.force =
      vertical: ->
        # vertical reaction will act upward and equal w*L/2 (where L= the span).
        w = $scope.simulation.applied
        L = $scope.simulation.span
        w * (L / 2)

      horizontal: ->
        # horizontal reaction will = w*L^2/(8*d) to the right where d = the depth or
        # height of the arch.
        d = $scope.simulation.height
        d8 = d * 8
        L = $scope.simulation.span
        w = $scope.simulation.applied
        w * L * L / d8

      compressive: ->
        # If possible, it would be great to add a compressive force at the midpoint of
        # the arch (to be consistent this would be a red arrow – again, Katherine drew
        # some). This compressive force, C, is equal to the horizontal reaction (
        # wL^2/(8d) ) . See below for a schematic.
        $scope.force.horizontal()

    $scope.force.vertical.max = 15000000
    $scope.force.horizontal.max = 58522500

# I think a simple start is good. My goal is to have students experiment with
# height and span to understand how they affect the compressive force in the
# arch and reactions. If we have time we can extend the simulation to include
# material, cross-sectional area, and allowable load but for now this will give
# the students somewhere to start experimenting.
#
# We may want to include a note stating that this simulation assumes the arch is
# an anti-funicular form (hence we can assume that the arch only carries
# compressive forces).
