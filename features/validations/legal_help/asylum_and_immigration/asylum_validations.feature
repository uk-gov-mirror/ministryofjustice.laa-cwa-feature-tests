Feature: Validation for Asylum claims

    @delete_outcome_after @manual_submission @invalid
    Scenario Outline: Reject invalid Asylum claims
        Given user is on their submission details page
        When user adds an outcome for Asylum with "<case id>", "<mt>", "<ecs code>", "<ecf ref>", "<case start date>", "<pa>" and "<ap>"
        Then the outcome does not save and the error message "<error message>" appears
        Examples:
            | case id | mt        | ecs code | ecf ref   | case start date | pa      | ap      | error message                                                                                                                                                                                                                                          |
            | 800     | IACC:IASY |          | 1234567AB | 31/03/19        | PA00136 | AP00137 | Case start date too old                                                                                                                                                                                                                                |
            | 801     | IACC:IASY |          | 1234567AB | 01/04/19        | PA00136 | AP00137 | It has been indicated that the matter has Exceptional Case Funding (as an ECF Reference has been recorded in the outcome details). The PA and AP must be populated with the values: ECF Matter (PA20000/AP20000).                                      |
            | 802     | IACC:IASY |          |           | 01/04/19        | PA00136 | AP00137 | The combination of reporting codes can only be used for cases started on or after 01-APR-2013 if an Exceptional Case Funding reference is recorded or if an exemption criterion has been satisfied and this has been indicated in the outcome details. |
            | 803     | IACC:IASY |          |           | 01/04/19        | PA20000 | AP20000 | The combination of reporting codes can only be used for cases started on or after 01-APR-2013 if an Exceptional Case Funding reference is recorded or if an exemption criterion has been satisfied and this has been indicated in the outcome details. |
            | 804     | IACC:IASY | CM001    | 1234567AB | 01/04/19        | PA00136 | AP00137 | An Exceptional Case Funding Reference is not required.                                                                                                                                                                                                 |
            | 805     | IACC:IASY | CM001    | 1234567AB | 01/04/19        | PA20000 | AP20000 | An Exceptional Case Funding Reference is not required.                                                                                                                                                                                                 |
            | 806     | IACC:IASY | CM001    |           | 01/04/19        | PA20000 | AP20000 | The PA (PA20000) and/or AP (AP20000) fields have been populated with ECF Matter. This value can only be used if the ECF Reference field is also populated.                                                                                             |
            | 807     | IACC:IASY | LE001    | 1234567AB | 01/04/19        | PA00136 | AP00137 | It has been indicated that the matter has Exceptional Case Funding (as an ECF Reference has been recorded in the outcome details). The PA and AP must be populated with the values: ECF Matter (PA20000/AP20000).                                      |
            | 808     | IACC:IASY | LE001    |           | 01/04/19        | PA00136 | AP00137 | An Exceptional Case Funding Reference is required.                                                                                                                                                                                                     |
            | 809     | IACC:IASY | LE001    |           | 01/04/19        | PA20000 | AP20000 | The PA (PA20000) and/or AP (AP20000) fields have been populated with ECF Matter. This value can only be used if the ECF Reference field is also populated.                                                                                             |
            | 810     | IACC:IASY | TR001    | 1234567AB | 01/04/19        | PA00136 | AP00137 | For the case being reported it is not necessary to record an exemption criterion. Please leave the field blank.                                                                                                                                        |
            | 811     | IACC:IASY | TR001    | 1234567AB | 01/04/19        | PA20000 | AP20000 | For the case being reported it is not necessary to record an exemption criterion. Please leave the field blank.                                                                                                                                        |
            | 812     | IACC:IASY | TR001    |           | 01/04/19        | PA20000 | AP20000 | The PA (PA20000) and/or AP (AP20000) fields have been populated with ECF Matter. This value can only be used if the ECF Reference field is also populated.                                                                                             |

    @delete_outcome_after @manual_submission @valid
    Scenario Outline: Add valid Asylum claims
        Given user is on their submission details page
        When user adds an outcome for Asylum with "<case id>", "<mt>", "<ecs code>", "<ecf ref>", "<case start date>", "<pa>" and "<ap>"
        Then the outcome saves successfully
        Examples:
            | case id | mt        | ecs code | ecf ref   | case start date | pa      | ap      |
            | 813     | IACC:IOUT |          | 1234567AB | 01/04/19        | PA20000 | AP20000 |
            | 814     | IACC:IOUT | CM001    |           | 01/04/19        | PA00136 | AP00137 |
            | 815     | IACC:IOUT | LE001    | 1234567AB | 01/04/19        | PA20000 | AP20000 |
            | 816     | IACC:IOUT | TR001    |           | 01/04/19        | PA00136 | AP00137 |
