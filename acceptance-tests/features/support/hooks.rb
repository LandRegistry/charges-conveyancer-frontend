################################################################################
### This file contains any code that should be executed before and after     ###
### the acceptance tests are run, this could include things like taking a    ###
### screenshot if a scenario fails or getting through any initial            ###
### authentication for the app before running the tests.                     ###
################################################################################

### Code that should be executed before the acceptance tests have run.
Before do
end

### Code that is executed after acceptance tests for each feature have run
After do |scenario|
  ### If an acceptance test scenario has failed then take a screenshot
  save_screenshot("sshot-#{Time.new.to_i}.png", full: true) if scenario.failed?
end
