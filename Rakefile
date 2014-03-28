require 'rake'

namespace :middleman do

  desc "Install gem bundles and bower packages"
  task :install do |t, args|
    sh "bundle install --path vendor/bundle"
    sh "bower install"
  end

  desc "Update gem bundles and bower packages"
  task :update do |t, args|
    sh "bundle clean"
    sh "bower prune"
    sh "bower install"
  end
end
