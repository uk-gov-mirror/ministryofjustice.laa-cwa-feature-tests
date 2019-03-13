require_relative '../pages/outcome_page.rb'
include OutcomePage

Given('user is on their sumission details page') do
  steps %(
    Given user is on the portal login page
    When user Logs in
    Then Portal application page is displayed
    When user clicks on CWA link
    Then CWA application page is displayed
    When user navigates to Submissions page
    Then Submission Search Page displayed
    When user searches for their provider submission
    Then their submission details are displayed
  )
end

When('user adds a valid outcome') do
  values = {
    matter_type: 'FAMA:FADV',
    submission_reference: ENV['SUBMISSION_REF'],
    case_ref_number: 'TestCaseRef',
    case_start_date: '01-Jul-2019',
    case_id: '001',
    procurement_area: 'PA00002',
    access_point: 'AP00000',
    client_forename: 'Test',
    client_surname: 'Person',
    client_dob: '01-May-1980',
    ucn: '01051980/T/PERS',
    postal_application_accepted: 'N',
    gender: 'Male',
    ethnicity: '00-Other',
    disability: 'NCD-Not Considered Disabled',
    postcode: 'SW1H 9AJ',
    case_concluded_date: '05-Jul-2019',
    advice_time: '0',
    travel_time: '0',
    waiting_time: '0',
    profit_costs_excluding_vat: '100.00',
    disbursements_excluding_vat: '0',
    counsel_costs_excluding_vat: '0',
    disbursements_vat_amount: '0',
    profit_and_counsel_vat_indicator: 'No',
    london_rate: 'No',
    travel_and_waiting_costs_excluding_vat: '0',
    value_of_costs_damages_awarded: '0',
    local_authority_number: '1234',
    client_type: 'P-Parent',
    outcome_for_client: 'FF-Settlement with no benefit for the client',
    case_stage_level: 'FPL01-Priv',
    exemption_criteria_satisfied: 'DV001'
  }
  OutcomePage.add_outcome(values, page)
end

Then('the outcome saves sucessfully') do
  expect(page).to_not have_content('Error')
  expect(page).to_not have_content('Warning')
  expect(page).to have_content('010719/001')
end
