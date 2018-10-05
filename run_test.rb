# RUBY_THREAD_VM_STACK_SIZE=400000000 ruby run_test.rb
require "minruby"

def check(cmd, f)
  expect = `ruby #{f}`
  answer = `#{cmd}`

  if expect == answer
    puts "\e[32m#{cmd} => OK!\e[0m"
  else
    puts "\e[31m#{cmd} => NG!\e[0m"
    puts "=== Expect ==="
    puts expect
    puts "=== Actual ==="
    puts answer
    code = File.read(f)
    puts "=== Test Program ==="
    puts code
    puts "=== AST ==="
    pp minruby_parse(code)
  end
end

MY_PROGRAM = 'interp.rb'
Dir.glob("test#{ARGV[0]}*.rb").sort.each do |f|
  if f != 'test4-4.rb'
    cmd = "ruby #{MY_PROGRAM} #{f}"
    cmd_self_host = "ruby #{MY_PROGRAM} #{MY_PROGRAM} #{f}"
    cmd_self_host2 = "ruby #{MY_PROGRAM} #{MY_PROGRAM} #{MY_PROGRAM} #{f}"
    cmd_self_host3 = "ruby #{MY_PROGRAM} #{MY_PROGRAM} #{MY_PROGRAM} #{MY_PROGRAM} #{f}"
    check(cmd, f)
    check(cmd_self_host, f)
    check(cmd_self_host2, f)
    check(cmd_self_host3, f)
  end
end
