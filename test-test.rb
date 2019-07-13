require_relative 'test.rb'

def prefix(a, b)
  res = []
  until a.empty? || b.empty?
    if a[0] == b[0]
      res << a[0]
    else
      return res
    end
    a = a.drop(1)
    b = b.drop(1)
  end
  return res
end

def quote(str)
  if str =~ /\[/
    "(#{str})"
  else
    "[#{str}]"
  end
end

def to_string(cmd)
  cmd.map { |name, *args|
    name + args.map { |a| quote(a) }.join
  }.join
end

class Choice
  attr_accessor :cmd, :count
  def initialize(cmd, count = 1)
    @cmd = cmd
    @count = count
  end
end

def start_vote(s)
  s[:vote] = {
    :started_at => Time.now,
    :choices => [],
  }
end

def merge_choices(vote, cmd)
  choice = vote[:choices].max_by { |c|
    prefix(c.cmd, cmd).size
  }
  if choice.nil? || prefix(choice.cmd, cmd).empty?
    vote[:choices] << Choice.new(cmd)
  else
    choice.cmd = prefix(choice.cmd, cmd)
    choice.count += 1
  end
end

def choose(s)
  s[:vote][:choices]
end

def print_vote(vote)
  vote[:choices].sort_by.with_index { |c,i| [c.count,-i] }
    .reverse.each do |choice|
    puts "【#{choice.count}】#{to_string(choice.cmd)}"
  end
end

def decide_cmd(vote)
  vote[:choices].sort_by.with_index { |c,i| [c.count,-i] }[-1].cmd
end

# p prefix(parse_word('sz'), parse_word('slz'))
# [parse_word('sz'),
#  parse_word('slz'),
#  parse_word("say (ほげ)"),
#  parse_word("soubi[薬]"),
#  parse_word("soubi([薬])"),
#  parse_word("soubi[(薬)]"),
# ].each do |c|
#   p to_string(c)
# end

state = {}
start_vote(state)
[
  parse_word('xz'),
  parse_word('xx'),
  parse_word('sz'),
  parse_word('slz'),
  parse_word("say (ほげ)"),
  parse_word("say (ほげ)"),
  parse_word("say (ほげ)"),
  parse_word("say (ほげ)"),
  parse_word("soubi[薬]"),
  parse_word("soubi([薬])"),
  parse_word("soubi[(薬)]"),
].each do |cmd|
  merge_choices(state[:vote], cmd)
end


print_vote(state[:vote])
p to_string(decide_cmd(state[:vote]))
