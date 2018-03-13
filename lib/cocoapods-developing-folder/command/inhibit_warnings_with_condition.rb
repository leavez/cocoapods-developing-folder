

module Pod
    def self.inhibit_waning_condition_block
        @inhibit_waning_condition_block
    end
    def self.set_inhibit_waning_condition_block(block)         
        @inhibit_waning_condition_block = block
    end
end

module Pod
    class PodTarget
  
      # the original code 
      # https://github.com/CocoaPods/CocoaPods/blob/93011ece10dd76b8d783bc80db742dfd03f7cbac/lib/cocoapods/target/pod_target.rb

      # ---- patch ----
      old_method = instance_method(:inhibit_warnings?)

      define_method(:inhibit_warnings?) do
        if Pod.inhibit_waning_condition_block == nil
            # return the original 
            return old_method.bind(self).()
        else 
            return Pod.inhibit_waning_condition_block.call(pod_name)
        end
      end

    end
end