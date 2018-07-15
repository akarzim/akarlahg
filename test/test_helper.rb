# Minitest init
require "minitest/autorun"
require "minitest/spec"

# Minitest Reporters for better looking output
require "minitest/reporters"
Minitest::Reporters.use!(
  Minitest::Reporters::SpecReporter.new,
  ENV,
  Minitest.backtrace_filter
)

# Require the sources
require_relative "../akarlahg/akarlahg"
