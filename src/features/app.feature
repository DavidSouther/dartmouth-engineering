Feature: Rupert Application

    Scenario: Smoke
        Given I have my browser open
        When I go to the site
        Then I should see "Engineering" in the title
