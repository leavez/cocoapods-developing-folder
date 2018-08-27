require 'pathname'
require_relative 'utiltiy'

module Pod

    class_attr_accessor :local_pod_DSL_root_path

    class Podfile

        def local_pod_searching_root(path)
            Pod.local_pod_DSL_root_path = path
        end
    end
end



module Pod
    class Podfile
        module DSL

            def local_pod(name, *requirements)
                options = requirements.last

                rootPath = Pod.local_pod_DSL_root_path || "./"
                if options and options.kind_of? Hash and options[:root_path] != nil
                    rootPath = options[:root_path]
                end
                basePath = Pathname.new rootPath

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
                path = unify_path(path.parent)
                path = path.to_s
                
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
