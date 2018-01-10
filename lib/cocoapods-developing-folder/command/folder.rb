require 'cocoapods-developing-folder/command/folder_DSL.rb'

module Pod
    class Podfile
        def use_folders(*skipped_top_level_folder_names)
            require 'cocoapods-developing-folder/command/preserve_folder.rb'
            names_to_skip = []
            first = skipped_top_level_folder_names.first
            if first.is_a? Hash
                names_to_skip = first[:skip_top_level_group]
            end
            Pod.set_skipped_top_level_folder_names (names_to_skip or [])    
        end
    end
end
