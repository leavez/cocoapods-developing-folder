# cocoapods-developing-folder

A cocoapods plugin that:
- preserves the folder structure in `development pods`
- provides a new keyword `folder` to import all local pods in a specific folder and its subfolders


## Installation

    $ gem install cocoapods-developing-folder

## Usage

#### preserves the folder structure

Add the following to your podfile

```ruby
plugin 'cocoapods-developing-folder'
use_folders
```

####  import all local pods in specific folder

Use `folder` just like `pod` keyword. (In fact, they are just ruby functions)


```ruby
plugin 'cocoapods-developing-folder'

target "ABC" do 
    pod "SnapKit"
    folder "frameworks/core" # 'frameworks/core' is just a relative path to podfile
    folder "modules"         #  it will import all pod in 'modules' folder and its subfolders
end
```

It will import all local pods in that folder and its subfolders recrusively, equivalent of:

```
pod AAA, :path => "modules/AAA"
pod BBB, :path => "modules/BBB"
pod CCC, :path => "modules/some/path/to/CCC"
#...
```

# License

MIT

Appreciate a 🌟 if you like it. Another cocoapods plugin made by me [cocoapods-static-swift-framework](https://github.com/leavez/cocoapods-static-swift-framework).

