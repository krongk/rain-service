#encoding: utf-8
# 该文件的目的是组装模板文件，生成一个演示预览：demo.html
#use $USAGE
$USAGE = <<EOT
 # 1. 请输入指定的模板文件名：-e theme
 # 2. 模板文件资源的文件结构为：
 #
 # |theme_name
 #        |assets
 #              _footer.html
 #              _header.html
 #              _index_content.html
 #              css_urls.txt
 #              js_urls.txt
 #        |css
 #        |js
 #        |img
 #        |pages
 #        |demo.default.html   
EOT

#or

#use RDoc::usage 
# == Synopsis
#
# This is a test
#
# == Usage
#
#    ruby <site>_data_extraction.rb -h
#    ruby <site>_data_extraction.rb -e <theme>
#

# mechanize lib
require 'rubygems'
require 'logger'
# command line argument parsing
require 'optparse'
#require 'rdoc/usage'
require 'pp'

# re-use Exception
class Exception
  attr_accessor :method_name
end

class ExtractException < Exception ; end

# define main class
class DataExtractor
  def print_and_exit(msg)
      puts
      puts '*** ERROR ***'
      puts msg
      puts
      exit
  end
  
  def initialize(args)
    print_and_exit($USAGE) if args.length == 0
    
    opt = OptionParser.new
    opt.on('-h', '--help') { print_and_exit($USAGE)}
    opt.on('-e', '--theme theme') { |theme| @theme = theme.downcase }
    opt.parse!(args)
    print_and_exit('please provide theme name with -e <theme>') if @theme.nil?
  end
  
  def run
    error_flag = false
    puts "generate #{@theme}........."

    #1. prepare files
    css_urls_path = File.join(File.dirname(__FILE__), @theme, 'assets', 'css_urls.txt')
    js_urls_path = File.join(File.dirname(__FILE__), @theme, 'assets', 'js_urls.txt')
    header_path = File.join(File.dirname(__FILE__), @theme, 'assets', '_header.html')
    index_content_path = File.join(File.dirname(__FILE__), @theme, 'assets', '_index_content.html')
    footer_path = File.join(File.dirname(__FILE__), @theme, 'assets', '_footer.html')
    demo_default_path = File.join(File.dirname(__FILE__), @theme, 'demo.default.html')
    puts "can not find css_urls_path #{error_flag = true}" unless File.exists?(css_urls_path)
    puts "can not find js_urls_path #{error_flag = true}" unless File.exists?(js_urls_path)
    puts "can not find header_path #{error_flag = true}" unless File.exists?(header_path)
    puts "can not find index_content_path #{error_flag = true}" unless File.exists?(index_content_path)
    puts "can not find footer_path #{error_flag = true}" unless File.exists?(footer_path)
    puts "can not find demo_default_path #{error_flag = true}" unless File.exists?(demo_default_path)
    return if error_flag

    #2. get all content
    puts "get demo content"
    demo_content = File.open(demo_default_path).read
    demo_content = demo_content.force_encoding("utf-8").sub(/{{title}}/, @theme)
    demo_content = demo_content.force_encoding("utf-8").sub(/{{css_urls}}/, encoded(File.open(css_urls_path).read))
    demo_content = demo_content.force_encoding("utf-8").sub(/{{js_urls}}/, encoded(File.open(js_urls_path).read))
    header_content = encoded(File.open(header_path).read)
    if header_content =~ /^\s*<body/i 
      demo_content = demo_content.force_encoding("utf-8").sub(/<body>/, header_content)
    else
      demo_content = demo_content.force_encoding("utf-8").sub(/{{header}}/, header_content)
    end
    demo_content = demo_content.force_encoding("utf-8").sub(/{{content}}/, encoded(File.open(index_content_path).read))
    demo_content = demo_content.force_encoding("utf-8").sub(/{{footer}}/, encoded(File.open(footer_path).read))

    #3. change links
    puts "change links"
    # <script src="/themes/cryption/js/jquery.min.js" => <script src="js/jquery.min.js"
    demo_content = demo_content.gsub(/"\/themes\/#{@theme}\//, '"') #"
    # change all link to "#"
    demo_content = demo_content.gsub(/href="\//, 'href="#') 

    #4. write to demo.html
    puts "write to demo.thml"
    File.open(File.join(File.dirname(__FILE__), @theme, 'demo.html'), 'w'){
      |f| f.write(demo_content)
    }
    puts "down"
    exit
  end

  def encoded(str)
    return str.force_encoding("utf-8")
  end
end

#run script
DataExtractor.new(ARGV).run if __FILE__ == $0