require 'yaml'
require 'date'

module MSUtil

    def self.load_which_payload
        File.open(File.expand_path("../../poco",__FILE__), 'r') do |f|
            f.each_line do |line|
                puts ">>>> #{line} <<<<"
                return line.strip
            end
        end
    end

end