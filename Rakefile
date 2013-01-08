require 'rake/testtask'

VERSION = '0.0.3'

def compile_coffee(name, append = false)
  `node_modules/.bin/coffee -p -c src/js/#{name}.coffee #{append ? '>>' : '>'} lib/#{name}.js`
end

task :build do
  abort 'src directory not found (on gh-pages branch?)' unless File.directory?('src')

  File.open('lib/hover.js', 'w') { |f| f.write "// hover.js v#{VERSION} https://github.com/lihanli/hover.js\n" }
  compile_coffee 'hover', true
  puts 'compile done'
end

task watch: [:build] do
  require 'listen'
  Listen.to('src') do |modified, added, removed|
    Rake::Task["build"].execute
  end
end

Rake::TestTask.new('test') do |t|
  t.libs << "test"
  t.test_files = FileList['test/tests/**/*.rb']
end

task :publish do
  require 'grit'
  # move lib to tmp directory, checkout gh-pages, move tmp directory into lib folder, push, then gco old branch or sha
  repo = Grit::Repo.new(Dir.pwd)

  old_branch_or_sha = repo.head ? repo.head.name : `git rev-parse HEAD`.chomp

  FileUtils.mkdir_p 'lib_tmp'
  FileUtils.cp Dir.glob('lib/*'), 'lib_tmp'
  `git checkout gh-pages`
  raise 'checkout error' unless repo.head.name == 'gh-pages'

  FileUtils.mv Dir.glob('lib_tmp/*'), 'lib'
  FileUtils.rmdir 'lib_tmp'
  `git add .`
  `git commit -m 'update hover'`
  `git push origin gh-pages`
  `git checkout #{old_branch_or_sha}`
end
