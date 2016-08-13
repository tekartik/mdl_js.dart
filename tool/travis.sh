#!/bin/bash

# Fast fail the script on failures.
set -e

dartanalyzer --fatal-warnings \
  lib/mdl_import.dart

pub run test -p vm,firefox