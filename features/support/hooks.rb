require_relative '../pages/outcome_page.rb'
include OutcomePage

After('@delete_outcome_after')
  delete_all_outcomes
end

After do
  visit('https://portal.tst.legalservices.gov.uk/oam/server/logout?')
end

After do |scenario|
  byebug if scenario.failed? && ENV['DEBUG_FAILURES'] == 'true'
end
