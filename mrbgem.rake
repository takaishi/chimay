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
  spec.add_dependency 'mruby-json',        :mgem => 'mruby-json'

  if build.kind_of?(MRuby::CrossBuild) && %w(x86_64-pc-linux-gnu).include?(build.host_target)
    spec.cc.include_paths += ["/usr/include/openssl"]
    spec.linker.flags_before_libraries += ["/usr/lib/x86_64-linux-gnu/libcrypto.a"]
  end
end
