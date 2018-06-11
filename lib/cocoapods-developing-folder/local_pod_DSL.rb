require 'pathname'

module Pod
    class Podfile
        module DSL

            def local_pod(name, *requirements)
                basePath = Pathname.new "./"

                path = nil
                basePath.find do |p|
                    if p.basename.to_s == "#{name}.podspec"
                        path = p
                        break
                    end
                end

                if path == nil 
                    raise "\ncannot find local pod: #{name}"
                    return 
                end
                path = path.parent.to_s[2..-1]
                options = requirements.last
                if options and options.kind_of? Hash
                    options[:path] = path
                    pod(name, *requirements)
                else 
                    pod(name, *requirements, :path => path)
                end
            end

        end
    end
end
