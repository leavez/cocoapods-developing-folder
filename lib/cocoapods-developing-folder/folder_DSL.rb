require 'pathname'

module Pod
    class Podfile
        module DSL

            def folder(path, *requirements)
                basePath = Pathname.new path
                def import_pod(path, *requirements)
                    podspec = path.children.find do |p|
                        !p.directory? and p.extname == ".podspec"
                    end
                    if podspec != nil 
                        options = (requirements.last || {}).clone 
                        options[:path] = path.to_path
                        pod(podspec.basename(".podspec").to_s, options)
                    end
                    path.children.each do |p|
                        if p.directory?
                            import_pod(p, *requirements)
                        end
                    end
                end
                import_pod basePath, *requirements
            end

        end
    end
end
