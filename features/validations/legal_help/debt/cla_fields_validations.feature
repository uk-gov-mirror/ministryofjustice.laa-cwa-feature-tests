Feature: Debt Bulk load validations

  Background:
    Given a test firm user is logged in CWA
    And user prepares to submit outcomes for test provider "LEGAL HELP.DEB#1"

  Scenario: Bulkload Civil Debt outcomes with CASE_START_DATE before April 2013
    Given the following Matter Types are chosen:
      | DIVB:DIBP |
    And the following outcomes are bulkloaded:
      | # | CASE_START_DATE | CLA_REF_NUMBER | CLA_EXEMPTION |
      | 1 | 31/03/2013      | <blank>        | <blank>       |
      | 2 | 31/03/2013      | <blank>        | ANYVALUE      |
      | 3 | 31/03/2013      | ANYVALUE       | ANYVALUE      |
    Then the following results are expected:
      | # | MATTER_TYPE | ERROR_CODE_OR_MESSAGE       |
      | 1 | DIVB:DIBP   | <none>                      |
      | 2 | DIVB:DIBP   | XXLSC_AM_LAR2_CLA_EXEMP_MSG |
      | 3 | DIVB:DIBP   | XXLSC_AM_LAR2_CLA_REF_MSG   |

  Scenario: Bulkload Civil Debt outcomes with CASE_START_DATE after April 2013
    Given the following Matter Types are chosen:
      | DIVB:DIBP |
    And the following outcomes are bulkloaded:
      | # | CASE_START_DATE | CLA_REF_NUMBER | CLA_EXEMPTION |
      | 1 | 01/04/2013      | <blank>        | <blank>       |
      | 2 | 01/04/2013      | 1234567        | <blank>       |
      | 3 | 01/04/2013      | 0000000        | <blank>       |
    Then the following results are expected:
      | # | MATTER_TYPE | ERROR_CODE_OR_MESSAGE        |
      | 1 | DIVB:DIBP   | XXLSC_AM_LAR2_CLA_REF_REQ    |
      | 2 | DIVB:DIBP   | <none>                       |
      | 3 | DIVB:DIBP   | XXLSC_AM_LAR2_CLA_REF_FORMAT |

  Scenario: Bulkload Civil Debt outcomes with CASE_START_DATE after April 2013, CLA_EXEMPTION: EPRE
    Given the following Matter Types are chosen:
      | DIVB:DIBP |
    And the following outcomes are bulkloaded:
      | # | CASE_START_DATE | CLA_REF_NUMBER | CLA_EXEMPTION |
      | 1 | 01/04/2013      | <blank>        | EPRE          |
      | 2 | 01/04/2013      | 1234567        | EPRE          |
      | 3 | 01/04/2013      | 0000000        | EPRE          |
    Then the following results are expected:
      | # | MATTER_TYPE | ERROR_CODE_OR_MESSAGE          |
      | 1 | DIVB:DIBP   | XXLSC_AM_LAR2_CLA_REF_EPRE_REQ |
      | 2 | DIVB:DIBP   | <none>                         |
      | 3 | DIVB:DIBP   | XXLSC_AM_LAR2_CLA_REF_FORMAT   |

  Scenario: Bulkload Civil Debt outcomes with CASE_START_DATE after April 2013, CLA_EXEMPTION: ECHI
    Given the following Matter Types are chosen:
      | DIVB:DIBP |
    And the following outcomes are bulkloaded:
      | # | CASE_START_DATE | CLA_REF_NUMBER | CLA_EXEMPTION | CLIENT_DATE_OF_BIRTH |
      | 1 | 01/04/2013      | <blank>        | ECHI          | 02/04/1995           |
      | 2 | 01/04/2013      | 1234567        | ECHI          | 02/04/1995           |
      | 3 | 01/04/2013      | 0000000        | ECHI          | 02/04/1995           |
      | 4 | 01/04/2013      | <blank>        | ECHI          | 01/04/1995           |
    Then the following results are expected:
      | # | MATTER_TYPE | ERROR_CODE_OR_MESSAGE        |
      | 1 | DIVB:DIBP   | <none>                       |
      | 2 | DIVB:DIBP   | <none>                       |
      | 3 | DIVB:DIBP   | XXLSC_AM_LAR2_CLA_REF_FORMAT |
      | 4 | DIVB:DIBP   | XXLSC_AM_LAR2_ECHI_CAGE_MSG  |

  Scenario: Bulkload Civil Debt outcomes with CASE_START_DATE after April 2013, CLA_EXEMPTION: EDET
    Given the following Matter Types are chosen:
      | DIVB:DIBP |
    And the following outcomes are bulkloaded:
      | # | CASE_START_DATE | CLA_REF_NUMBER | CLA_EXEMPTION |
      | 1 | 01/04/2013      | <blank>        | EDET          |
      | 2 | 01/04/2013      | 1234567        | EDET          |
      | 3 | 01/04/2013      | 0000000        | EDET          |
    Then the following results are expected:
      | # | MATTER_TYPE | ERROR_CODE_OR_MESSAGE        |
      | 1 | DIVB:DIBP   | <none>                       |
      | 2 | DIVB:DIBP   | <none>                       |
      | 3 | DIVB:DIBP   | XXLSC_AM_LAR2_CLA_REF_FORMAT |

  Scenario: Bulkload Civil Debt outcomes with CASE_START_DATE after April 2013, CLA_EXEMPTION: <NONEXISTENT>
    Given the following Matter Types are chosen:
      | DIVB:DIBP |
    And the following outcomes are bulkloaded:
      | # | CASE_START_DATE | CLA_REF_NUMBER | CLA_EXEMPTION |
      | 1 | 01/04/2013      | 1234567        | <NONEXISTENT> |
    Then the following results are expected:
      | # | MATTER_TYPE | ERROR_CODE_OR_MESSAGE                      |
      | 1 | DIVB:DIBP   | <NONEXISTENT> is not a valid CLA_EXEMPTION |

  Scenario: Bulkload Civil Debt outcomes with CASE_START_DATE after 15 May 2020
    Given the following Matter Types are chosen:
      | DIVB:DIBP |
    And the following outcomes are bulkloaded:
      | # | CASE_START_DATE | CLA_REF_NUMBER | CLA_EXEMPTION |
      | 1 | 15/05/2020      | <blank>        | <blank>       |
    Then the following results are expected:
      | # | MATTER_TYPE | ERROR_CODE_OR_MESSAGE |
      | 1 | DIVB:DIBP   | <none>                |

