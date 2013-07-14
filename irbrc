next_irbrc_candidates = %w{.irbrc irb.rc _irbrc}
next_irbrc_candidates += $irbrc if defined? $irbrc
next_irbrc_candidates.each do |cand|
  begin
    load cand if File.exists?(cand) unless File.expand_path(cand) == File.expand_path(__FILE__)
    break
  rescue
  end
end

require 'pp'
alias p pp

unless defined? ETC_IRBRC_LOADED
  require 'irb/completion'

  IRB.conf[:PROMPT_MODE] = :SIMPLE if IRB.conf[:PROMPT_MODE] == :DEFAULT

  require 'irb/ext/save-history'
  IRB.conf[:SAVE_HISTORY] = 100
  IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-history"

  IRB.conf[:USE_READLINE] = true
  IRB.conf[:AUTO_INDENT]=true

  ETC_IRBRC_LOADED=true
end

class Object
  def my_methods
    base_object = case self
                  when Class  then Class.new
                  when Module then Module.new
                  else             Object.new
                  end
    (methods - base_object.methods).sort
  end

  if RUBY_VERSION =~ /^1\.9/
    def wtf?(name)
      if m = method(name)
        m.source_location.join(':') if m.source_location
      end
    end
  else
    def wtf?(name)
      if m = method(name)
        [m.__file__, m.__line__].join(':')
      end
    end
  end
end

#ruby 1.9 only
def source_for(object, method_sym)
  if object.respond_to?(method_sym, true)
    method = object.method(method_sym)
  elsif object.is_a?(Module)
    method = object.instance_method(method_sym)
  end
  location = method.source_location
  `mvim #{location[0]} +#{location[1]}` if location
  #`subl #{location[0]}:#{location[1]}` if location
  location
rescue
  nil
end

if ENV['RAILS_ENV'] || defined? Rails

  require 'logger'
  logger = Logger.new(STDOUT)

  # Log to STDOUT if in Rails 3
  if defined?(Rails) && Rails.respond_to?(:logger=)
    Rails.logger = logger
    ActiveRecord::Base.logger = logger if defined? ActiveRecord::Base
    Mongoid.logger = logger if defined? Mongoid
  else # Rails 2
    RAILS_DEFAULT_LOGGER = logger
  end

  def greg
    Person.find_by_email("greg.vaughn@livingsocial.com")
  end

  def set_greg_roles
    p = greg
    ep = p.external_person
    ep.password = "password"
    ep.password_confirmation = "password"
    puts "Saving ExternalPerson with new password"
    ep.save!
    p.roles.clear
    p.roles << Role.all
  end
end
