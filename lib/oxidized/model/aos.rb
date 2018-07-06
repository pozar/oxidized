class AOS < Oxidized::Model
  # Alcatel-Lucent Operating System
  # used in OmniSwitch

  comment  '! '

  cmd :all do |cfg|
    cfg.each_line.to_a[1..-2].join
  end

  cmd 'show system' do |cfg|
    cfg = cfg.each_line.find { |line| line.match 'Description' }
    comment cfg.to_s.strip
  end

  cmd 'show chassis' do |cfg|
    raise "AOS ERROR:" if cfg.match /ERROR:/
    comment cfg
  end

  cmd 'show hardware info' do |cfg|
    raise "AOS ERROR:" if cfg.match /ERROR:/
    comment cfg
  end

  cmd 'show configuration snapshot' do |cfg|
    raise "AOS ERROR:" if cfg.match /ERROR:/
    cfg
  end

  cfg :telnet do
    username /^login : /
    password /^password : /
  end

  cfg :telnet, :ssh do
    pre_logout 'exit'
  end
end
