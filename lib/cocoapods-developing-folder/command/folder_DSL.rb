require 'pathname'

module Pod
    class Podfile
        module DSL

            def folder(path)
                basePath = Pathname.new path
                def import_pod(path)
                    podspec = path.children.find do |p|
                        !p.directory? and p.extname == ".podspec"
                    end
                    if podspec != nil 
                        pod podspec.basename(".podspec").to_s, :path => path.to_path
                    end
                    path.children.each do |p|
                        if p.directory?
                            import_pod(p)
                        end
                    end
                end
                import_pod basePath
            end

        end
    end
end
