# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard :rspec do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/mining_depot/entities/(.+)\.rb$})     { |m| "spec/entities/#{m[1]}_spec.rb" }
  watch(%r{^lib/mining_depot/interactors/(.+)\.rb$})     { |m| "spec/interactors/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { "spec" }

  watch(%r{^spec/support/(.+)\.rb$})                  { "spec" }

  # Turnip features and steps
  watch(%r{^spec/acceptance/(.+)\.feature$})
  watch(%r{^spec/acceptance/steps/(.+)_steps\.rb$})   { |m| Dir[File.join("**/#{m[1]}.feature")][0] || 'spec/acceptance' }
end


guard :rubocop do
  watch(%r{^lib/(.+)\.rb$})
  watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
end
