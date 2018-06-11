def unify_path(path)
    path.realpath.relative_path_from (Pathname.new "./").realpath
end