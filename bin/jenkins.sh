#!/bin/bash -l
export PATH=$PATH:/usr/local/bin

env_dir="$JENKINS_HOME/virtualenv/${JOB_NAME// /_}"

#create and activate a virtualenv
virtualenv $env_dir
. $env_dir/bin/activate

#install requirements
pip install -r requirements.txt

#install test only requirements
pip install -r requirements_test.txt

#ensure submodules are cloned
git submodule update --init

./acceptance-tests/run_linting.sh

rubocop=$?

export CASE_API_BASE_HOST="http://caseapi.lrdigitalmortgage-int.com:20100"

coverage run --source=app tests.py --xml

test_pass=$?

./run_linting.sh

python_linting=$?

coverage xml
coverage -rm

e_code=$((test_pass + rubocop + python_linting))

exit $e_code
