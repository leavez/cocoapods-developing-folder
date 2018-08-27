def unify_path(path)
    path.realpath.relative_path_from (Pathname.new "./").realpath
end

def class_attr_accessor(symbol)
    self.class.send(:attr_accessor, symbol)
end