MRuby::Gem::Specification.new('chimay') do |spec|
  spec.license = 'MIT'
  spec.author  = 'MRuby Developer'
  spec.summary = 'chimay'
  spec.bins    = ['chimay']

  spec.add_dependency 'mruby-print', :core => 'mruby-print'
  spec.add_dependency 'mruby-eval',  :core => 'mruby-eval'

  spec.add_dependency 'mruby-mtest',       :mgem => 'mruby-mtest'
  spec.add_dependency 'mruby-io',          :mgem => 'mruby-io'
  spec.add_dependency 'mruby-httprequest', :mgem => 'mruby-httprequest'
  spec.add_dependency 'mruby-onig-regexp', :mgem => 'mruby-onig-regexp'
  spec.add_dependency 'mruby-aws-s3',      :mgem => 'mruby-aws-s3'
  spec.add_dependency 'mruby-polarssl',    :mgem => 'mruby-polarssl'
  spec.add_dependency 'mruby-env',         :mgem => 'mruby-env'
  spec.add_dependency 'mruby-base64',      :mgem => 'mruby-base64'
end
