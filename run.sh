#!/bin/sh
$(npm bin)/cypress run CYPRESS_BASE_URL='https://epassapi.egovernments.org' --spec "cypress/integration/Org-Onboarding-Tests/*.ts"
$(npm bin)/cypress run CYPRESS_BASE_URL='https://epassapi.egovernments.org' --spec "cypress/integration/Orders/*.ts"
