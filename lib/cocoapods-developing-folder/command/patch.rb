
# module Pod
#   class Project

#     attr_reader :development_pods_hierarchy

#     def add_pod_group(pod_name, path, development = false, absolute = false)
#       raise '[BUG]' if pod_group(pod_name)
#       puts name, path
#       parent_group = development ? development_pods : pods
#       source_tree = absolute ? :absolute : :group

#       group = parent_group.new_group(pod_name, path, source_tree)
#       group
#     end

#   end
# end
