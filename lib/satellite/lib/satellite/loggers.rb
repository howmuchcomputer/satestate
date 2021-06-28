module Loggers
  class StdOut
    def info(msg)
      puts "SATELLITE: [INFO] #{msg}"
    end

    def error(msg)
      puts "SATELLITE: [ERROR] #{msg}"
    end
  end
end