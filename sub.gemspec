$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "sub/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "sub"
  s.version     = Sub::VERSION
  s.authors     = ["h1u2i3"]
  s.email       = ["286390860@qq.com"]
  s.homepage    = "https://github.com/h1u2i3/sub"
  s.summary     = "A simple rails file upload gem."
  s.description = "A simple rails file upload gem. Write for fun."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", ">= 5.0.0.beta3", "< 5.1"

  s.add_development_dependency "sqlite3"
end
