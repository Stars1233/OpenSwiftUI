#!/bin/bash

set -euo pipefail

result_bundle="${1:?Missing xcresult bundle path}"
test_identifier="${2:?Missing test identifier}"

xcrun xcresulttool get test-results summary --path "$result_bundle" --compact |
    ruby -rjson -e '
      summary = JSON.parse(STDIN.read)
      executed = summary.fetch("totalTestCount") - summary.fetch("skippedTests")
      if executed <= 0
        abort("::error::No UI tests ran for #{ARGV.fetch(0)}. Check the identifier, including (), and whether the test is disabled.")
      end
      puts "Executed #{executed} UI test(s) for #{ARGV.fetch(0)}."
    ' "$test_identifier"
