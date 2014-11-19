require 'date'
require 'open3'
require 'fileutils'
require 'rake'
require 'erb'

SCRIPT_PATH = File.split(File.expand_path(__FILE__))
SCRIPT_NAME = SCRIPT_PATH.last
CONFIG_DIR_PATH = SCRIPT_PATH.first
BACKUP_DIR_PATH = File.join(
  ENV['HOME'],
  '.dotfiles_backup',
  DateTime.now.strftime('%Y-%m-%d-%H-%M-%S'))
BUNDLE_DIR_PATH = File.join(CONFIG_DIR_PATH, 'vim/bundle')
VUNDLE_DIR_PATH = File.join(BUNDLE_DIR_PATH, 'vundle')
VUNDLE_REMOTE_URL = 'https://github.com/gmarik/vundle.git'

# Utility function for displaying messages
def info(text)
  STDOUT.puts text
end

# Utility function for displaying error messages
def error(text)
  STDERR.puts "Error: #{text}"
end

# Moves an existing dot file into the backup directory.
#
# @param [String] from the file to back up.
# @param [String] to the backup destination.
def backup(from, to)
  return unless File.exists? from
  FileUtils.mkdir_p(File.dirname(to))
  File.rename(from, to)
end

# Returns whether a command exists in PATH.
#
# @param [String] command the name of the command.
# @return [true, false] if true, the command exists; otherwise, it does not.
def exists?(command)
  ENV['PATH'].split(':').any? do |directory|
    File.exists?(File.join(directory, command))
  end
end

# Returns the absolute path to a Vim bundle.
#
# @param [String] line the line to be parsed.
# @return [String] the absolute path to a bundle.
def bundle_path(line)
  # Strip ANSI escape sequences (may output junk whitespace).
  line.gsub!(/\e\[?.*?[\@-~]/, '')
  if line =~ /Processing '([^']+)'/
    # Get the bundle URL.
    bundle_url = $1
    # Strip junk whitespace.
    bundle_url.gsub!(/\s+/, '')
    # Strip .git extension from full URLs.
    bundle_url.gsub!(/\.git$/, '')
    return File.join(BUNDLE_DIR_PATH, File.split(bundle_url).last)
  end
end

namespace :link do
  desc 'Symlink dot files'
  task :create do
    Dir["#{CONFIG_DIR_PATH}/*/_*"].each do |source|
      target_relative = source.gsub("#{CONFIG_DIR_PATH}/", '')
      target_backup = File.join(BACKUP_DIR_PATH, target_relative)
      target = File.join(ENV['HOME'], ".#{target_relative}")
      # Do not link if the source is a raw file, the target already exists and
      # is a symlink to the source.
      next if source =~ RAW_FILE_EXTENSION_REGEXP \
        or excluded?(target_relative) \
        or (File.exists?(target) \
          and File.ftype(target) == 'link' \
          and File.identical?(source, target))
      info "Linking: #{target}"
      begin
        backup(target, target_backup)
      rescue IOError
        error "Could not backup '#{target}', will skip symlinking '#{source}'"
        next
      end
      begin
        File.symlink(source, target)
      rescue IOError
        error "Could not symlink '#{source}' to '#{target}'"
      end
    end
  end

  desc 'Unlink broken symlinks'
  task :clean do
    Dir["#{ENV['HOME']}/.*"].each do |item|
      if File.ftype(item) == 'link'
        unless File.exists? item
          info "Unlinking: #{item}"
          begin
            File.unlink item
          rescue IOError
            error "Could not unlink '#{item}'"
          end
        end
      end
    end
  end
end

namespace :module do
  desc 'Initialize submodules'
  task :init do
    if File.exists? '.gitmodules'
      unless exists?('git')
        error "Could not initialize submodules, Git is not found"
        next
      end
      # Popen3 does not return the exit status code.
      # Echo it onto the last line of stderr.
      Open3.popen3(
        "git submodule update --init --recursive; echo $? 1>&2"
      ) do |stdin, stdout, stderr|
        stdios = [stdin, stdout, stderr]
        threads = []
        threads << Thread.new do
          Thread.current.abort_on_exception = true
          stdout.each do |line|
            next if line !~ /^Cloning into .*\.{3}$/
            info line.gsub(/^Cloning into (.*)\.{3}$/, "Initializing: \\1")
          end
        end
        threads << Thread.new do
          Thread.current.abort_on_exception = true
          stderr.each do |line|
            if line =~ /Unable to checkout '[^']+' in submodule path '([^']+)'/
              error "Could not initialize submodule '#{$1}'"
            end
            if stderr.eof? and line.to_i != 0
              error "Could not initialize submodules"
            end
          end
        end
        begin
          threads.each(&:join)
          stdios.each(&:close)
        rescue Exception => e
          error e.message if e.class == IOError
        end
      end
    end
  end


  desc 'Update submodules'
  task :update do
    if File.exists? '.gitmodules'
      unless exists?('git')
        error "Could not update submodules, Git is not found"
        next
      end
      # Popen3 does not return the exit status code.
      # Echo it onto the last line of stderr.
      Open3.popen3(
        "git submodule foreach git pull origin master; echo $? 1>&2"
      ) do |stdin, stdout, stderr|
        stdios = [stdin, stdout, stderr]
        threads = []
        threads << Thread.new do
          stdout.each do |line|
            if line =~ /Entering '([^']+)'/
              info "Updating: #{$1}"
            end
          end
        end
        threads << Thread.new do
          stderr.each do |line|
            if line =~ /Stopping at '([^']+)'/
              error "Could not update submodule '#{$1}'"
            end
            if stderr.eof? and line.to_i != 0
              error "Could not update submodules"
            end
          end
        end
        begin
          threads.each(&:join)
          stdios.each(&:close)
          Rake::Task[:make].invoke
        rescue Exception => e
          error e.message if e.class == IOError
        end
      end
    end
  end
end

namespace :bundle do
  desc 'Initialize Vim bundles'
  task :init do
    next unless File.exists?('vimrc') and File.directory?('vim')
    next if File.directory?(File.join(VUNDLE_DIR_PATH, '.git'))
    unless exists?('git')
      error "Could not initialize Vim bundles, Git is not found"
      next
    end
    info "Initializing: #{VUNDLE_DIR_PATH}".gsub("#{CONFIG_DIR_PATH}/", '')
    Open3.popen3(
      "git clone '#{VUNDLE_REMOTE_URL}' '#{VUNDLE_DIR_PATH}'; echo $? 1>&2"
    ) do |stdin, stdout, stderr|
      vundle = File.basename VUNDLE_DIR_PATH
      stdios = [stdin, stdout, stderr]
      threads = []
      threads << Thread.new do
        Thread.current.abort_on_exception = true
        stderr.each do |line|
          if line =~ /^fatal: (.*)$/
            error "Could not initialize Vim bundle '#{vundle}'"
          end
          if stderr.eof? and line.to_i != 0
            error "Could not initialize Vim bundles"
          end
        end
      end
      begin
        threads.each(&:join)
        stdios.each(&:close)
      rescue Exception => e
        error e.message if e.class == IOError
      end
    end
  end

  desc 'Update Vim bundles'
  task :update => :init do
    next unless File.directory?(File.join(VUNDLE_DIR_PATH, '.git'))
    unless exists?('git')
      error "Could not update Vim bundles, Git is not found"
      next
    end
    Open3.popen3(
      "vim -c 'silent!" +
        "redir >> /dev/stdout " +
          "| execute \"BundleInstall!\" " +
          "| only " +
          "| quitall!';" +
      "echo $? 1>&2"
    ) do |stdin, stdout, stderr|
      stdios = [stdin, stdout, stderr]
      threads = []
      threads << Thread.new do
        Thread.current.abort_on_exception = true
        # Vim will not run without reading stdout,
        # might as well parse its output.
        stdout.each do |line|
          bundle = bundle_path(line)
          next unless bundle
          bundle_relative = bundle.gsub("#{CONFIG_DIR_PATH}/", '')
          info "Updating: #{bundle_relative}"
          if line =~ /Error processing '([^']+)'/
            error "Could not update Vim bundle '#{bundle_relative}'"
          end
        end
      end
      threads << Thread.new do
        Thread.current.abort_on_exception = true
        stderr.each do |line|
          if stderr.eof? and line.to_i != 0
            error "Could not update Vim bundles"
          end
        end
      end
      begin
        threads.each(&:join)
        stdios.each(&:close)
      rescue Exception => e
        error e.message if e.class == IOError
      end
    end
  end

  desc 'Clean Vim bundles'
  task :clean do
    next unless File.exists?('vimrc') and File.directory?('vim/bundle/vundle')
    Open3.popen3(
      "vim -c 'silent!" +
        "redir >> /dev/stdout " +
          "| execute \"BundleClean!\" "+
          "| only " +
          "| quitall!'; " +
      "echo $? 1>&2"
    ) do |stdin, stdout, stderr|
      stdios = [stdin, stdout, stderr]
      threads = []
      threads << Thread.new do
        Thread.current.abort_on_exception = true
        # Vim will not run without reading stdout,
        # might as well parse its output.
        stdout.each do |line|
          bundle = bundle_path(line)
          next unless bundle
          bundle_relative = bundle.gsub("#{CONFIG_DIR_PATH}/", '')
          info "Removing: #{bundle_relative}"
          if line =~ /Error processing '([^']+)'/
            error "Could not remove Vim bundle '#{bundle_relative}'"
          end
        end
      end
      threads << Thread.new do
        Thread.current.abort_on_exception = true
        stderr.each do |line|
          if stderr.eof? and line.to_i != 0
            error "Could not clean Vim bundles"
          end
        end
      end
      begin
        threads.each(&:join)
        stdios.each(&:close)
      rescue Exception => e
        error e.message if e.class == IOError
      end
    end
  end
end

desc 'Make submodules and bundles'
task :make do
  Dir["#{CONFIG_DIR_PATH}/**/Rakefile"].each do |rake_file|
    next if SCRIPT_PATH.join('/') == rake_file
    submodule = File.dirname rake_file
    submodule_relative = submodule.gsub("#{CONFIG_DIR_PATH}/", '')
    read, write = IO.pipe
    pid = fork do
      Dir.chdir submodule
      Rake::Task.clear
      load rake_file
      next unless Rake::Task.task_defined?(:make)
      info "Making: #{submodule_relative}"
      # Redirect stdout, stderr since make is noisy.
      stdout_old = STDOUT.clone
      stderr_old = STDERR.clone
      begin
        STDOUT.reopen write
        STDERR.reopen STDOUT
        read.close
        Rake::Task[:make].invoke
      rescue Exception => e
        STDOUT.reopen stdout_old
        STDERR.reopen stderr_old
        error e.message
      end
    end
    begin
      write.close
      read.each do |line|
        if read.eof? and line =~ /error:/i
          error "Could not make '#{submodule_relative}'"
        end
      end
    rescue IOError => e
      error e.message
    end
    Process.waitpid pid
  end
end

desc 'Uninstall dot files'
task :uninstall => 'link:clean' do
  Dir["#{CONFIG_DIR_PATH}/*"].each do |source|
    target_relative = source.gsub("#{CONFIG_DIR_PATH}/", '')
    target = File.join(ENV['HOME'], ".#{target_relative}")
    next if source =~ RAW_FILE_EXTENSION_REGEXP or excluded?(target_relative)
    # Uninstall only if the target exists, is a symlink, and points to source.
    if File.exists?(target) \
      and File.ftype(target) == 'link' \
      and File.identical?(source, target)
      info "Unlinking: #{target}"
      begin
        File.unlink target
      rescue IOError
        error "Could not unlink '#{target}'"
      end
    end
  end
end

desc 'Install dot files'
task :install => [
  'module:init',
  'render',
  'link:create',
  'link:clean',
  'bundle:init',
  'bundle:update',
  'bundle:clean',
  'make'
] do
  info "Backup: #{BACKUP_DIR_PATH}" if File.directory? BACKUP_DIR_PATH
end

task :default => [:install]

