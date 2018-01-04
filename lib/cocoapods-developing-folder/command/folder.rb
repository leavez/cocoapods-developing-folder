module Pod
    class Podfile
        def use_folders
            require 'cocoapods-developing-folder/command/patch.rb'
        end
    end
end
