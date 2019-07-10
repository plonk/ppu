#!/usr/bin/ruby
MAX_COMMANDS = 30
DELAY1 = 0.1 # キー押し下げ時間
DELAY2 = 0.25
DELAY_IDASH = 0.5
DELAY_ATTACK = 0.8
DELAY_ARROW = 1.2

COMMANDS = {
  "ih" => [[:down, "f"], [:press, "KP_Left"], [:up, "f"], [:delay, DELAY_IDASH]],
  "il" => [[:down, "f"], [:press, "KP_Right"], [:up, "f"], [:delay, DELAY_IDASH]],
  "ij" => [[:down, "f"], [:press, "KP_Down"], [:up, "f"], [:delay, DELAY_IDASH]],
  "ik" => [[:down, "f"], [:press, "KP_Up"], [:up, "f"], [:delay, DELAY_IDASH]],
  "iy" => [[:down, "f"], [:press, "KP_Home"], [:up, "f"], [:delay, DELAY_IDASH]],
  "iu" => [[:down, "f"], [:press, "KP_Prior"], [:up, "f"], [:delay, DELAY_IDASH]],
  "ib" => [[:down, "f"], [:press, "KP_End"], [:up, "f"], [:delay, DELAY_IDASH]],
  "in" => [[:down, "f"], [:press, "KP_Next"], [:up, "f"], [:delay, DELAY_IDASH]],

  "dh" => [[:down, "a"], [:press, "KP_Left"], [:up, "a"]],
  "dj" => [[:down, "a"], [:press, "KP_Down"], [:up, "a"]],
  "dk" => [[:down, "a"], [:press, "KP_Up"], [:up, "a"]],
  "dl" => [[:down, "a"], [:press, "KP_Right"], [:up, "a"]],
  "dy" => [[:down, "a"], [:press, "KP_Home"], [:up, "a"]],
  "du" => [[:down, "a"], [:press, "KP_Prior"], [:up, "a"]],
  "db" => [[:down, "a"], [:press, "KP_End"], [:up, "a"]],
  "dn" => [[:down, "a"], [:press, "KP_Next"], [:up, "a"]],

  "mh" => [[:check3, "h"]],
  "mj" => [[:check3, "j"]],
  "mk" => [[:check3, "k"]],
  "ml" => [[:check3, "l"]],
  "my" => [[:check3, "y"]],
  "mu" => [[:check3, "u"]],
  "mb" => [[:check3, "b"]],
  "mn" => [[:check3, "n"]],

  "h" => [[:press, "KP_Left"]],
  "j" => [[:press, "KP_Down"]],
  "k" => [[:press, "KP_Up"]],
  "l" => [[:press, "KP_Right"]],
  "y" => [[:press, "KP_Home"]],
  "u" => [[:press, "KP_Prior"]],
  "b" => [[:press, "KP_End"]],
  "n" => [[:press, "KP_Next"]],

  "i4" => [[:down, "f"], [:press, "KP_Left"], [:up, "f"], [:delay, DELAY_IDASH]],
  "i2" => [[:down, "f"], [:press, "KP_Down"], [:up, "f"], [:delay, DELAY_IDASH]],
  "i8" => [[:down, "f"], [:press, "KP_Up"], [:up, "f"], [:delay, DELAY_IDASH]],
  "i6" => [[:down, "f"], [:press, "KP_Right"], [:up, "f"], [:delay, DELAY_IDASH]],
  "i7" => [[:down, "f"], [:press, "KP_Home"], [:up, "f"], [:delay, DELAY_IDASH]],
  "i9" => [[:down, "f"], [:press, "KP_Prior"], [:up, "f"], [:delay, DELAY_IDASH]],
  "i1" => [[:down, "f"], [:press, "KP_End"], [:up, "f"], [:delay, DELAY_IDASH]],
  "i3" => [[:down, "f"], [:press, "KP_Next"], [:up, "f"], [:delay, DELAY_IDASH]],

  "d4" => [[:down, "a"], [:press, "KP_Left"], [:up, "a"]],
  "d2" => [[:down, "a"], [:press, "KP_Down"], [:up, "a"]],
  "d8" => [[:down, "a"], [:press, "KP_Up"], [:up, "a"]],
  "d6" => [[:down, "a"], [:press, "KP_Right"], [:up, "a"]],
  "d7" => [[:down, "a"], [:press, "KP_Home"], [:up, "a"]],
  "d9" => [[:down, "a"], [:press, "KP_Prior"], [:up, "a"]],
  "d1" => [[:down, "a"], [:press, "KP_End"], [:up, "a"]],
  "d3" => [[:down, "a"], [:press, "KP_Next"], [:up, "a"]],

  "m4" => [[:check3, "h"]],
  "m2" => [[:check3, "j"]],
  "m8" => [[:check3, "k"]],
  "m6" => [[:check3, "l"]],
  "m7" => [[:check3, "y"]],
  "m9" => [[:check3, "u"]],
  "m1" => [[:check3, "b"]],
  "m3" => [[:check3, "n"]],

  "4" => [[:press, "KP_Left"]],
  "2" => [[:press, "KP_Down"]],
  "8" => [[:press, "KP_Up"]],
  "6" => [[:press, "KP_Right"]],
  "7" => [[:press, "KP_Home"]],
  "9" => [[:press, "KP_Prior"]],
  "1" => [[:press, "KP_End"]],
  "3" => [[:press, "KP_Next"]],

  "H" => [[:down, "a"], [:press, "KP_Left"], [:up, "a"]],
  "J" => [[:down, "a"], [:press, "KP_Down"], [:up, "a"]],
  "K" => [[:down, "a"], [:press, "KP_Up"], [:up, "a"]],
  "L" => [[:down, "a"], [:press, "KP_Right"], [:up, "a"]],
  "Y" => [[:down, "a"], [:press, "KP_Home"], [:up, "a"]],
  "U" => [[:down, "a"], [:press, "KP_Prior"], [:up, "a"]],
  "B" => [[:down, "a"], [:press, "KP_End"], [:up, "a"]],
  "N" => [[:down, "a"], [:press, "KP_Next"], [:up, "a"]],

  "z" => [[:press, "z"], [:delay, DELAY_ATTACK]],
  "a" => [[:press, "a"]],
  "x" => [[:press, "x"]],
  "s" => [[:press, "s"]],
  "q" => [[:press, "q"], [:delay, DELAY_ARROW]],
  "w" => [[:press, "w"]],
  "space" => [[:down, "space"], [:delay, 1.0], [:up, "space"]],
  "menu" => [[:press, "minus"]],
  "minus" => [[:press, "minus"]],
  "hyphen" => [[:press, "minus"]],
  "enter" => [[:press, "KP_Enter"]],
  "e" => [[:press, "KP_Enter"]],
  "g" => [[:down, "g"], [:delay, 1.0], [:up, "g"]],
  "f" => [[:press, "f"]],
  "esc" => [[:press, "Escape"]],
  "." => [[:down, "a"], [:down, "z"], [:delay, 0.25], [:up, "z"], [:up, "a"], [:delay, 0.8], [:press, "g"]],

  "mizu"        => [[:aa2ch, :mizu]],
  "marindrive"  => [[:aa2ch, :marindrive]],
  "marinedrive" => [[:aa2ch, :marindrive]],
  "hizagakusai"       => [[:aa2ch, :hizagakusai]],
  "satakegawarui"       => [[:aa2ch, :satakegawarui]],
  "futon"       => [[:aa, :futon]],
  "atcoder"     => [[:aa, :atcoder]],
  "udon"        => [[:aa, :udon]],
  "onigiri"     => [[:aa2ch, :onigiri]],
  "typingspeedtest" => [[:aa, :typingspeedtest]],
  "tst" => [[:aa, :typingspeedtest]],
  "maitake" => [[:aa, :maitake]],
  "eringi" => [[:aa, :eringi]],
  # "kiri" => [[:aa, :kiri]],
  "kiri" => [[:kiri]],
  "bunasimeji" => [[:aa, :bunasimeji]],
  "bunashimeji" => [[:aa, :bunasimeji]],
  "simeji" => [[:aa, :bunasimeji]],
  "shimeji" => [[:aa, :bunasimeji]],

  "bunasimezi" => [[:aa, :bunasimeji]],
  "bunashimezi" => [[:aa, :bunasimeji]],
  "simezi" => [[:aa, :bunasimeji]],
  "shimezi" => [[:aa, :bunasimeji]],

  "mamuru" => [[:aa2ch, :mamuru]],

  "sukusho" => [[:sukusho]],
  "sukusyo" => [[:sukusho]],

  "name" => [[:name]],
  "namae" => [[:namae]],
  "memo" => [[:memo]],

  "say" => [[:say, :default]],
  "hikari" => [[:say, :hikari]],
  "haruka" => [[:say, :haruka]],
  "bear" => [[:say, :bear]],
  "santa" => [[:say, :santa]],
  "show" => [[:say, :show]],
  "takeru" => [[:say, :takeru]],

  "aques" => [[:aques]],

  "note" => [[:note, "/home/plonk/Dropbox/PPU/memo.txt"]],
  "soubi" => [[:note, "/home/plonk/Dropbox/PPU/soubi.txt"]],

  "mm" => [[:check8]],

  "furo"        => [[:aa2ch, :furo]],
  "unk"        => [[:aa2ch, :unk]],
  "unko"        => [[:aa2ch, :unk]],

  "anka" => [[:anka]],
}

AA = {
  :satakegawarui => [
    ["　 　┏┓┏┓　 ┏━━┓┏┓　 　 　 　 ┏┓　 　 ┏┳┓┏━━━┓┏┳┓　 　 　 　 ┏┓"],
    ["　┏┛┗┛┗┓┃┏┓┃┃┗━━┓┏┛┗━┓┃┃┃┃┏━┓┃┃┃┃　 　 　 ┏┛┃"],
    ["　┗┓┏┓┏┛┃┗┛┃┃┏┓┏┛┗┓┏┓┃┗┻┛┗┛　 ┃┃┃┃┃　 　 ┏┛┏┛"],
    ["　　 ┗┛┃┃　 ┃┏┓┃┗┛┃┃　 　 ┃┃┃┃　 　 　 　 　 ┏┛┃┃┃┃┏┓┗┫┃　"],
    ["　 　　 　 ┃┃　 ┗┛┃┃　 ┏┛┃　 　 ┃┃┃┃　 　 　 　 ┏┛┏┛┃┃┗┛┃　 ┃┃　"],
    ["　　 　 　 ┗┛　 　 　 ┗┛　 ┗━┛　 　 ┗┛┗┛　 　 　 　 ┗━┛　 ┗┻━━┛　 ┗┛"],
  ],

  :hizagakusai => [
    [%q[　　　　vﾚvNW|ﾚWWYWVMVYﾚ、]],
    [%q[　　　 ｲYW,-k'''￣￣￣￣ヾ、WＹＶＷ]],
    [%q[　　　NWﾚ　　　　＿＿　　　　ヾWＹV彡]],
    [%q[　　 ｲW　　　　￣＿＿_￣　　　 ヾＹＷ|]],
    [%q[　　Ｎj'　　　　―-----､＿＿,-　　Ｗri]],
    [%q[　 ./｀i　　 ,-――-､　 ,-――--､　 Ｗ.]],
    [%q[　 .| り＝〈　　ｨtｧゝ j=i　　 ｨtｧ> .ｊ＝|ｩ|]],
    [%q[　 .ヽ.|　　ヽ＿＿_ イ .iヽ------'　　ﾄ/]],
    [%q[　　　l|　　　　　　 _/　 |、　　　　　　 |j]],
    [%q[　　　.|　　　　　 人,-､,-,入　　　　　 |]],
    [%q[　　　 i　　　　 ./　 ⌒⌒　ヽ.　　　　/]],
    [%q[　　　 |　　　　 l　 ､＿＿_,　 .i　　　 j]],
    [%q[　　　 ヽ、　　/　　i、＿_j　　.|　　　i]],
    [%q[　　　　　ヽ ノ　　　　　　　　　ヽ ノ´]],
    [%q[　　　　　　　｀ー---------‐´]],
  ],

  :mizu => [
    ["　　 　 　 　 　 　 /￣ﾌ"],
    ["　　　 　 　 　 　 /　 /　　　__"],
    ["　　_________i'\"ヽ./　 /　 ,／　._＞"],
    ["　　｀￣´ﾞ/゛ ./ﾌ　　レ'彡-'\""],
    ["　　　　 ./　/ ./　 /| .ヽ."],
    ["　　　／.／　/　./　.ｌ　.ヽ."],
    ["　,／／　　 /　./　　ヽ　 .｀_､"],
    ["　｀'´　 -―′./　　　 `-'´"],
    ["　　　　 ｀ゝ__ノ"]
  ],

  :marindrive => [
    [%q[  /￣￣￣￣/　 /'''７ /'''７　 /￣/　/'''７　　/￣/　　/''７''７　/二二二/_　　 _ノ￣,/　 /￣￣￣ ﾌ./''７''７]],
    [%q[  ￣￣ノ　／　　/__/ /　 / 　 ￣　　/　./ 　 /　　ﾞー-;ー'ｰ'　/　＿＿　　//￣　　,／ 　 ￣￣./　/　ー'ｰ'　]],
    [%q[  　　<　 <..　　　＿__ノ　/　　＿___.ノ　./　　/　 /ｰ--'ﾞ　　　　￣　 __,ノ　/ ￣/　/　　 　 ＿__ノ　/ 　　　　　]],
    [%q[  　　 ヽ､_/　　/＿___,.／ 　/＿_____.／　　/＿/　　　　　　　　　　/____,／　　/__/　　　/＿___,.／]],
  ],

  :futon => [
    ["　　 ＜⌒／ヽ＿＿＿"],
    ["　／＜_/＿＿＿＿／"],
    ["　￣￣￣￣￣￣￣"],
  ],

  :atcoder => [
    ["   ##     #####   ####    ####   #####   ######  #####"],
    ["  #  #      #    #    #  #    #  #    #  #       #    #"],
    [" #    #     #    #       #    #  #    #  #####   #    #"],
    [" ######     #    #       #    #  #    #  #       #####"],
    [" #    #     #    #    #  #    #  #    #  #       #   #"],
    [" #    #     #     ####    ####   #####   ######  #    #"],
  ],

  :udon => [
    ["  うどん"],
    ["　∫∫＿__"],
    ["　＼≠≠／"],
    [" 　 ‾‾"],
  ],

  :onigiri => [
    ["　　　　　 ,.-、"],
    ["　　　　　(,,■)"],
  ],

  :typingspeedtest => [
    ["  #####   #   #  #####      #    #    #   ####"],
    ["    #      # #   #    #     #    ##   #  #    #"],
    ["    #       #    #    #     #    # #  #  #"],
    ["    #       #    #####      #    #  # #  #  ###"],
    ["    #       #    #          #    #   ##  #    #"],
    ["    #       #    #          #    #    #   ####"],
    [""],
    ["  ####   #####   ######  ######  #####"],
    [" #       #    #  #       #       #    #"],
    ["  ####   #    #  #####   #####   #    #"],
    ["      #  #####   #       #       #    #"],
    [" #    #  #       #       #       #    #"],
    ["  ####   #       ######  ######  #####"],
    [""],
    ["  #####  ######   ####    #####"],
    ["    #    #       #          #"],
    ["    #    #####    ####      #"],
    ["    #    #            #     #"],
    ["    #    #       #    #     #"],
    ["    #    ######   ####      #"],
  ],

  :maitake => [
    ["　ミ彡ミ彡ミ"],
    ["　彡ミ彡ミ彡"],
    ["　 ヽ(ﾟДﾟ)"],
    ["　　|(ﾉ　|)"],
    ["　　ヽ＿ノ"],
    ["　　 ∪∪"],
  ],

  :eringi => [
    ["　(二二二ﾆつ"],
    ["　 ヽ　　 /"],
    ["　　|(ﾟДﾟ)"],
    ["　　|(ﾉ　|)"],
    ["　　|　　|"],
    ["　　ヽ＿ノ"],
    ["　　 ∪∪"],
  ],

  :bunasimeji => [
    [" 　 ／⌒＼"],
    [" 　(＿＿＿)"],
    [" 　 |(ﾟДﾟ)"],
    [" 　 |(ﾉ　|)"],
    [" 　 ヽ＿ノ"],
    [" 　　∪∪"],
  ],

  :kiri => [
    ["(`･ω･´)ｷﾘｯ"],
  ],

  :mamuru => [
    [" 　|ヽ‐〃l"],
    ["　（・∀・ ,）つ"],
  ],

  :furo => [
    ["  　　ｏ　　Ｏ　　○。"],
    ["  ∞　　。 ｏ　　 。"],
    ["  ┻┓∬(。) 　彡⌒ミ"],
    ["  　川 。o∬∩(･ω･∩)"],
    ["  (￣￣￣)￣￣￣￣O￣)"],
    ["  ﾟi￣o￣Г￣○￣￣oﾟi"],
    ["  （＿＿ノ＿O＿_ﾟ＿｡ノ"],
    ["  　))　((。ｏ))○(("]
  ],

  :unk => [
    ["　　　 　　.彡⌒ ミ"],
    ["　/⌒　　(´・ω・｀)"],
    ["　{　　 　ノっ　　 ﾉつ"],
    ["　 ヽ　　（_　⌒)^)　 (￣◎"],
    ["　　に二二二つっ　.|￣|゛"],
    ["　　 _）　　　r'　　　 　~~~"],
    ["　 └───`"],
  ],

}

VTSAY_OPTIONS = {
  :default => ["--speaker=haruka", "--emotion=happiness", "--emotion_level=4"],
  :haruka => ["--speaker=haruka"],
  :hikari => ["--speaker=hikari"],
  :bear=> ["--speaker=bear", "--volume=150"],
  :show=> ["--speaker=show", "--volume=150"],
  :takeru=> ["--speaker=takeru", "--volume=150"],
  :santa=> ["--speaker=santa"],
}

def parse_word(w)
  command_names = COMMANDS.keys.sort.reverse
  s = command_names.map { |n| Regexp.escape(n) }.join("|")
  regexp = /\A(#{s})/

  res = []
  until w.empty?
    case w
    when regexp
      res << [$&]
      w = $'
    when /\A\[(.*?)\]/m, /\A\((.*?)\)/m
      if res.empty?
        # コマンド名が指定されていない。
        return []
      end
      res.last << $1
      w = $'
    when /\A\s+/ # 改行文字にもマッチする。
      w = $'
    else
      return []
    end
  end
  return res
end

def to_seq(cmd)
  COMMANDS[cmd]
end

def name(param)
  require 'shellwords'
  param = Shellwords.escape(param)
  body = `asuka-name #{param}`
  if $? == 0
    cmds = parse_word(body)
    process_commands(cmds)
  end
end

def namae(param)
  require 'shellwords'
  param = Shellwords.escape(param)
  body = `asuka-name --name #{param}`
  if $? == 0
    cmds = parse_word(body)
    process_commands(cmds)
  end
end

def memo(param)
  require 'shellwords'
  param = Shellwords.escape(param)
  body = `asuka-name --memo #{param}`
  if $? == 0
    cmds = parse_word(body)
    process_commands(cmds)
  end
end

DIRS = %w[k u l n j b h y]
def check3(dir)
  i = DIRS.index(dir)
  unless i
    STDERR.puts("invalid #{dir.inspect}")
    return
  end
  cmds = [dir, DIRS[(i-1)%8], DIRS[(i+1)%8]].flat_map { |d|
    ["a", d, "e"]
  }
  process_commands(cmds)
end

def check8
  cmds = DIRS.flat_map { |d| ["a",d,"e"] }
  process_commands(cmds)
end

def process_commands(cmds)
  cmds.each do |cmd, param|
    seq = to_seq(cmd)

    print "\e[1;36;49m"
    print "#{cmd} "
    print "\e[0m"

    seq.each do |exp|
      name, arg = exp
      case name
      when :press
        system("xdotool keydown --clearmodifiers --window #{id()} #{arg}")
        sleep DELAY1
        system("xdotool keyup --clearmodifiers --window #{id()} #{arg}")
        sleep DELAY2
      when :down
        system("xdotool keydown --clearmodifiers --window #{id()} #{arg}")
      when :up
        system("xdotool keyup --clearmodifiers --window #{id()} #{arg}")
      when :delay
        sleep arg
      when :aa2ch
        puts
        open("|t2i", "w") do |f|
          AA[arg].each do |line|
            f.puts line
          end
        end
      when :aa
        puts
        puts
        print "\e[1;35;49m"
        AA[arg].each do |line|
          puts line
          sleep 0.1
        end
        print "\e[0m"
      when :kiri
        system("aplay -q /home/plonk/.sounds/kiri.wav")
      when :sukusho
        fn = `date +ss-%m%d-%H%M%S.jpg`.chomp
        system("xwd -id #{id()} > /tmp/sukusho.xwd && convert -quality 50 /tmp/sukusho.xwd /home/plonk/Dropbox/PPU/#{fn}")
        system("rm /tmp/sukusho.xwd")
        link = `dropbox sharelink /home/plonk/Dropbox/PPU/#{fn}`
        system("shit", "post", "nichan://genkai.pcgw.pgw.jp/shuuraku/PeerCast*:postable,oldest",
               "--name", "test.rb",
               "--body", ">>#{$res}\nスクショ撮ったよ。\n#{link}",
               "--verbose")
      when :name
        name(param)
      when :namae
        namae(param)
      when :memo
        memo(param)
      when :say
        opts = VTSAY_OPTIONS[arg] || []
        system("vtsay", *opts, param) if param
      when :aques
        system("say", param) if param
      when :note
        File.open(arg, "w") do |memo|
          memo.write(param)
        end
        puts "#{arg}を更新しました。"
      when :check3
        check3(arg)
      when :check8
        check8
      when :anka
        anka(param)
      end
    end
  end
end

def id
  if $id
    $id
  else
    if anka_mode?
      STDERR.puts "できねーよm9(^Д^)"
      exit 1
    else
      $id = `xdotool search "アスカ" 2>/dev/null`
      if $id.empty?
        puts "アスカのウィンドウがみつかりません。"
        exit 1
      end
      $id = $id.to_i
      system("xdotool windowactivate --sync #{id()}")
    end
  end
end

ANKA_PATH = File.join(File.dirname(__FILE__), "anka.txt")

def anka(param)
  if param =~ /\d+/
    n = $&.to_i
  else
    STDERR.puts "ankaへの引数に数字がないよ。"
    return
  end

  if anka_mode?
    STDERR.puts "おかしいな。もうアンカモードだよ？"
    return
  end

  unless n > $res
    STDERR.puts "過去のレス番(#{n})が指定されているよ。"
    return
  end

  if n > 1000
    STDERR.puts "レス番でかすぎぃ！"
    return
  end

  if n > $res + 20
    STDERR.puts "レス番遠すぎ。"
    return
  end

  File.open(ANKA_PATH, "w") do |f|
    f.puts n
  end
  system_message("アンカモードに移行します。\n>>#{n}番までのゲーム操作コマンドは実行されません。")
end

def system_message(msg)
  STDERR.puts "\e[33;49m#{msg}\e[0m"
  system("vtsay", msg)
end

def anka_mode?
  File.exist?(ANKA_PATH)
end

def process(summary, body)
  if anka_mode?
    fail 'logic error' unless anka_mode?

    if $res >= File.read(ANKA_PATH).to_i
      File.unlink(ANKA_PATH)
      if parse_word(body).any?
        process(summary, body)
      else
        system("vtsay", body)
        system_message("コマンドレスではなかったので再アンカ(>>#{$res+1})。")
        File.open(ANKA_PATH, "w") do |f|
          f.puts($res + 1)
        end
      end

      unless anka_mode?
        system_message("オアシスモードに戻ります。")
      end
      return
    end
  end

  cmds = parse_word(body)
  if cmds.any?
    process_commands(cmds.take(MAX_COMMANDS))

    if cmds.size > MAX_COMMANDS
      print "\e[1;31;49m"
      print "(長コマンドの為以下省略)"
      print "\e[0m"
      puts
    end
  else
    system("vtsay", body)
  end
end

def main
  # サマリにはスレッド名が入っている。
  summary, body = ARGV

  body1 = body.gsub(/<a.*?>(.*?)<\/a>/, "\\1")

  $res = body.each_line.first.split(/:/,2)[0].to_i
  # レス番、投稿時刻などが含まれる最初の行を削除。
  body = body.each_line.drop(1).join
  # アンカのリンクを削除。
  body = body.gsub(/<a.*?>>>(.*?)<\/a>/, "\\1番")
  body = body.gsub(/https?:\/\/[a-zA-Z0-9\/?=\-.]+/,"リンク")

  if anka_mode?
    puts "\e[33;49m[安価 >>#{File.read(ANKA_PATH).chomp}]\e[0m"
  end

  # open("|t2i", "w") do |f|
  #   f.write(body1)
  # end
  print body1

  process(summary, body)
  puts
end

if __FILE__ == $0
  main
end
