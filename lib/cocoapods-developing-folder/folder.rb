require_relative 'folder_DSL'
require_relative 'local_pod_DSL'

module Pod
    class Podfile
        
        def use_folders(*skipped_top_level_folder_names)
            require_relative 'preserve_folder'
            names_to_skip = []
            first = skipped_top_level_folder_names.first
            if first.is_a? Hash
                names_to_skip = first[:skip_top_level_group]
            end
            Pod.set_skipped_top_level_folder_names (names_to_skip or [])    
        end
        
        
        def inhibit_warnings_with_condition(&condition) 
            require_relative 'inhibit_warnings_with_condition'
            Pod.set_inhibit_waning_condition_block  proc(&condition)
        end

    end
end
