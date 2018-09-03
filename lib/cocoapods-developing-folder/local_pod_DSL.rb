require 'pathname'
require_relative 'utiltiy'

module Pod

    class_attr_accessor :local_pod_DSL_root_paths

    class Podfile

        def local_pod_searching_root(path)
            if path.kind_of? Array
                Pod.local_pod_DSL_root_paths = path
            elsif path.kind_of? String
                Pod.local_pod_DSL_root_paths = [path]
            else
                raise "[Error] wrong type for `local_pod_searching_root`"
            end
        end
    end
end



module Pod
    class Podfile
        module DSL

            def local_pod(name, *requirements)
                options = requirements.last

                rootPaths = Pod.local_pod_DSL_root_paths || ["./"]
                if options and options.kind_of? Hash and options[:root_path] != nil
                    rootPaths = [ options[:root_path] ]
                end

                rootPodName = Specification.root_name name
                found = false

                rootPaths.each do |rootPath|
                    basePath = Pathname.new rootPath
    
                    path = nil
                    basePath.find do |p|
                        if p.basename.to_s == "#{rootPodName}.podspec"
                            path = p
                            break
                        end
                    end
                    next if path.nil?
    
                    path = unify_path(path.parent)
                    path = path.to_s
                    
                    if options and options.kind_of? Hash
                        options[:path] = path
                        pod(name, *requirements)
                    else 
                        pod(name, *requirements, :path => path)
                    end
                    found = true
                    break
                end
                if not found
                    raise "\ncannot find local pod: #{name}. Searching roots: #{rootPaths}"
                end
            end

        end
    end
end
