require 'cocoapods-developing-folder/command/folder_DSL.rb'

module Pod
    class Podfile
        def use_folders
            require 'cocoapods-developing-folder/command/preserve_folder.rb'
        end
    end
end
