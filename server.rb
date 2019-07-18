require 'socket'
require_relative 'test'

# ----------------------------------------------------------------
# 定数、グローバル
# ----------------------------------------------------------------

PORT = 7143

# "ID" => :democracy | :anarchy
$policy = {}

$current_policy = :anarchy

$choices = []

$vote_ends_at = nil

$dry_run = false

# ----------------------------------------------------------------

def prefix_of(a, b)
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
  }.join(' ')
end

class Choice
  attr_accessor :count
  attr_accessor :votes

  def initialize()
    @votes = []
    @prefix = nil
  end

  def count
    @votes.size
  end

  def add_vote(id, cmds)
    @votes << [id, cmds]
    if @prefix
      @prefix = prefix_of(@prefix, cmds)
    else
      @prefix = cmds
    end
  end

  def remove_vote_by(voter)
    @votes.delete_if { |id, cmds|
      id == voter
    }

    if @votes.empty?
      @prefix = nil
    else
      @prefix = @votes.map(&:last).reduce { |acc, x|
        prefix_of(acc, x)
      }
    end
  end

  def prefix
    @prefix
  end
end

def print_choices
  puts "#{$choices.size}案"
  $choices.sort_by.with_index { |c,i| [c.count,-i] }
    .reverse.each do |choice|
    puts "【#{choice.count}】#{to_string(choice.prefix)}"
  end
end

# ----------------------------------------------------------------

def embolden(str)
  "\e[1m#{str}\e[0m"
end

def print_policy_balance
  total = $policy.size
  nanarchy = $policy.count { |k,v| v == :anarchy }
  ndemocracy = total - nanarchy

  if total == 0
    bar = "\e[91m" + "*" * 30 + "\e[0m"
  else
    left = "*" * (nanarchy.fdiv(total) * 30).round
    right = "+" * (ndemocracy.fdiv(total) * 30).round
    bar = "\e[91m#{left}\e[0m\e[94m#{right}\e[0m"
  end

  case $current_policy
  when :anarchy
    STDERR.puts "#{embolden('anarchy')} #{bar} democracy"
  when :democracy
    STDERR.puts "anarchy #{bar} #{embolden('democracy')}"
  end
end

def update_policy
  if $policy.size == 0
    $current_policy = :anarchy
  else
    total = $policy.size
    nanarchy = $policy.count { |k,v| v == :anarchy }
    ndemocracy = total - nanarchy

    case $current_policy
    when :anarchy
      if ndemocracy.to_f / total > 2.0/3
        $current_policy = :democracy
        $vote_ends_at = Time.now + 30
        print_vote_end($vote_ends_at)
        system_message("democracy が始まる。")
      end
    when :democracy
      if nanarchy.to_f / total > 1.0/2
        $current_policy = :anarchy
        $vote_ends_at = nil
        $choices = []
        system_message("anarchy が始まる。")
      end
    end
  end
end

def print_vote_end(t)
  puts "次の採決時刻： #{t.inspect}"
end

def vote_on_action(message)
  header, body = header_body(message)

  if header =~ /ID:(.{8})\z/
    id = $1
  else
    STDERR.puts("IDがないので投票できません。")
    return
  end
  cmds = parse_word(body)

  add_choice(id, cmds)
  print_choices
end

def add_choice(id, cmds)
  $choices.each do |c|
    c.remove_vote_by(id)
  end
  $choices.delete_if do |c|
    c.count == 0
  end

  choice = $choices.max_by { |c|
    prefix_of(c.prefix, cmds).size
  }
  if choice.nil? || prefix_of(choice.prefix, cmds).empty?
    new_choice = Choice.new
    new_choice.add_vote(id, cmds)
    $choices << new_choice
  else
    choice.add_vote(id, cmds)
  end
end

def header_body(message)
  message.split("\n",2)
end

def vtsay(body)
  body = body
           .gsub(/<a.*?>>>(.*?)<\/a>/, "\\1番")
           .gsub(/https?:\/\/[a-zA-Z0-9\/?=\-.]+/,"リンク")
  system("vtsay", body)
end

def print_message(message)
  message = message.gsub(/<a.*?>(.*?)<\/a>/, "\\1")
  message = message.sub(/\A\d+/) { |s| "\e[95m#{s}\e[0m" }
  print message
end

def process_request(sock)
  data = Marshal.load(sock.read)

  case data[:type]
  when :post
    message = data[:message]
    header, body = header_body(message)

    print_message(message)

    if policy_message?(message)
      vote_on_policy(message)
    elsif (cmds = parse_word(body)).any?
      case $current_policy
      when :democracy
        vote_on_action(data[:message])
      when :anarchy
        if $dry_run
          p [:process_commands_capped, cmds]
        else
          process_commands_capped(cmds)
        end
      end
    else
      vtsay(body)
    end
    puts
  when :eval
    begin
      print "> "
      puts data[:string]
      r = eval(data[:string])
      print "=> "
      p r
    rescue => e
      p e
    end
  else
    STDERR.puts "unknown message type #{data[:type].inspect}"
  end
  puts "\e[92m———————————————————————————————————————————————————————————\e[0m"
end

def policy_message?(message)
  header, body = header_body(message)
  body.strip == "democracy" || body.strip == "anarchy"
end

def vote_on_policy(message)
  header, body = message.split("\n",2)
  fail "no body" unless body

  if header =~ /ID:(.{8})\z/
    id = $1
  else
    STDERR.puts("IDがないのでポリシーに投票できません。")
    return
  end

  policy = body.strip
  case policy
  when "democracy", "anarchy"
    STDERR.puts("ID:#{id}は#{policy}を望む。")
    $policy[id] = policy.to_sym
  else
    STDERR.puts("#{policy.inspect}とは？")
  end
  update_policy
  print_policy_balance
end

def decide_action
  choice = $choices.sort_by.with_index { |c,i| [c.count,-i] }[-1]
  if choice.nil? # 誰も投票してない。
    system_message("投票時間延長。")
    return
  else
    system_message("採決です。")
  end

  if $dry_run
    p [:process_commands_capped, choice.prefix]
  else
    process_commands_capped(choice.prefix)
  end
  puts
  $choices.clear
  choice.votes.each do |id, cmds|
    cmds = cmds[choice.prefix.size .. -1]
    if cmds.any?
      puts "#{id} → #{to_string(cmds)}"
      add_choice(id, cmds)
    end
  end
end

def timeout_callback
  case $current_policy
  when :democracy
    if Time.now >= $vote_ends_at
      decide_action
      if $choices.size > 0
        print_choices
      end
      $vote_ends_at = Time.now + 30
      print_vote_end($vote_ends_at)
      puts "\e[92m———————————————————————————————————————————————————————————\e[0m"
    end
  when :anarchy
  end
end

def main
  serv = TCPServer.new(PORT)

  while true
    begin
      $id = nil
      sock = serv.accept_nonblock

      process_request(sock)
    rescue IO::WaitReadable, Errno::EINTR
      r = IO.select([serv], [], [], 1.0)
      if r == nil
        timeout_callback
      end
      retry
    end
  end
end

if __FILE__ == $0
  main
end
