# cocoapods-developing-folder

A cocoapods plugin  provide a branch of tools for who heavily use development pods in project. You can do these:

- new keyword `local_pod` to import a local pod without specifying path
- new keyword `folder` to import all local pods in a specific folder and its subfolders
- preserves the folder structure in `development pods`
- inhibit warnings for specific pods with a block.


## Installation

    $ gem install cocoapods-developing-folder

## Usage

Firstly, you should add this in head of Podifle:

```ruby
plugin 'cocoapods-developing-folder'
```

#### 🔸 Import a local pods without specifying path

Use `local_pod` just like `pod` keyword. No need to adding path. E.g.

```ruby
local_pod "Evangelion" # no need for `:path => "modules/Evangelion"`
```

It will search your project root path. If you want smaller or larger search range, set `local_pod_searching_root`, e.g.
``` ruby
# in the podfile
local_pod_searching_root "../Libs"
# Array is also supported.
# local_pod_searching_root ["../Libs", "../../modules"]
```

#### 🔸 Import all local pods in specific folder

Use `folder` just like `pod` keyword. (In fact, they are just ruby functions)


```ruby
plugin 'cocoapods-developing-folder'

target "ABC" do 
    pod "SnapKit"
    folder "frameworks/core" # 'frameworks/core' is just a relative path to podfile
    folder "modules"         #  it will import all pod in 'modules' folder and its subfolders
    folder "libs", :inhibit_warnings => true  #  the option will apply to all pods in the libs folder
end
```

It will import all local pods in that folder and its subfolders recrusively, equivalent of:

```
pod "Ayanami", :path => "modules/Ayanami"
pod "Asuka",   :path => "modules/Asuka"
pod "Shinji",  :path => "modules/some/path/to/Shinji"
#...
```

#### 🔸 Preserves the folder structure

Add the following to your podfile

```ruby
use_folders
```

If you don't want to create groups for top level folders (Local pods are usually grouped in the same folder):
```ruby
use_folders :skip_top_level_group => ["modules"]
```

#### 🔸 Inhibit warnings for specific pods

Add the following to your podfile

```ruby
plugin 'cocoapods-developing-folder'

inhibit_warnings_with_condition do |pod_name, pod_target|
    # your condition written in ruby, like:
    # `not pod_name.start_with? "LE"` or
    # `['Asuka', 'Ayanami', 'Shinji'].include? pod_name`
end
```
`pod_target` is a instance of `Pod::PodTarget` [class](https://github.com/CocoaPods/CocoaPods/blob/93011ece10dd76b8d783bc80db742dfd03f7cbac/lib/cocoapods/target/pod_target.rb), containing many more info than the name. You can use it to set up complex rules.

This function will override the warning inhibition settings by the original methods, like: `inhibit_all_warnings!`, `pod 'Ayanami', :inhibit_warnings => true`

This function is usually used for disabling warning inhibition for development pods and enabling for the others. When you try to implement this with offical methods, cocoapods may warn you at `pod install`:

> The pod #{pod_name} is linked to different targets which contain different settings to inhibit warnings. CocoaPods does not currently support different settings and will fall back to your preference set in the root target definition.

This function solve the problem.


# License

MIT

Appreciate a 🌟 if you like it. Another cocoapods plugin made by me [cocoapods-static-swift-framework](https://github.com/leavez/cocoapods-static-swift-framework).

