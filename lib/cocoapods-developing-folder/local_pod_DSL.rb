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
                options[:path] = path.to_s
                pod(name, *requirements)
            end

        end
    end
end
