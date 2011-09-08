rails_running = ENV.include?('RAILS_ENV') && !(IRB.conf[:LOAD_MODULES] && IRB.conf[:LOAD_MODULES].include?('console_with_helpers'))
irb_standalone_running = !script_console_running && !rails_running

if script_console_running
  require 'logger'
  Object.const_set(:RAILS_DEFAULT_LOGGER, Logger.new(STDOUT))
end


# Useful for running specs in console
# not rails specific
@specs = [] # Array of paths to spec files
@spec_dir = '' # set to a path to prefix specs in @specs

def run_spec(spec_file)
  puts "no @spec_dir set" if @spec_dir == ''
  puts "Running #{spec_file}"
  `spec #{@spec_dir}#{spec_file}`.each {|line| puts line}; nil
end

def run_specs
  puts "no @specs set" if @specs == []
  @specs.each {|spec| run_spec(spec) }
end
