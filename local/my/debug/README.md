# Vimspector

## Configuration


### Ruby Example

~~~ruby
 {
  "configurations": {
    "launch current file": {
      "adapter": "cust_vscode-ruby",
      "configuration": {
        "request": "launch",
        "program": "${file}",
        "args": [ "*${args}" ]
      }
    }
  }
}
~~~
~~~json
{
  "configurations": {
    "Ruby launch current file": {
      "adapter": "cust_vscode-ruby",
      "configuration": {
        "request": "launch",
        "program": "${file}",
        "args": [ "*${args}" ],
        "useBundler": true,
        "trace": true,
        "showDebuggerOutput": true
      }
    }
  }
}
~~~

~~~json
{
  "configurations": {
    "rails": {
      "adapter": "cust_vscode-ruby",
      "configuration": {
        "name": "Rails server",
        "type": "Ruby",
        "request": "launch",
        "cwd": "{path_do_dir}",
        "program": "{path_to_dir}/bin/rails",
        "useBundler": true,
        "pathToRDebugIDE": "~/.rbenv/shims/rdebug-ide",
        "showDebuggerOutput": true,
        "args": ["server"]
      }
    }
  }
}
~~~


#### Gadget install file:

cust_vscode-ruby.json
~~~json
{
  "cust_vscode-ruby":  {
    "download": {
      "url": "https://github.com/rubyide/vscode-ruby/releases/download/v${version}/${file_name}"
    },
    "all": {
      "version": "0.25.0",
      "file_name": "ruby-0.25.0.vsix",
      "checksum": "fc67efbdc7261e7e1ae53707ead9bda10ec19c498369ff8a3ccd2e7fb8125a68",
      "adapters": {
        "cust_vscode-ruby": {
          "command": [
            "node",
            "${gadgetDir}/cust_vscode-ruby/dist/debugger/main.js"
          ],
          "name": "vscode-ruby-debug",
          "configuration": {
            "cwd": "${workspaceRoot}",
            "showDebugOutput": false,
            "trace": false
          }
        }
      }
    }
  }
}
~~~


## Mappings

### SPCACE-d

* s - Start
* x - Terminate
* ENTER - Continue
* r - Run to Cursor
* b - Toggle Breakpoint
