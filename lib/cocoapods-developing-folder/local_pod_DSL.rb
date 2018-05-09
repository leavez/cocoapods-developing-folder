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
                options = requirements.last
                if options and options.kind_of? Hash
                    options[:path] = path.to_s
                    pod(name, *requirements)
                else 
                    pod(name, *requirements, :path => path.to_s)
                end
            end

        end
    end
end
