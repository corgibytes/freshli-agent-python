# [Freshli CLI](https://github.com/corgibytes/freshli-cli) Python Agent

`freshli-agent-python` is the Python language agent that is used by the [Freshli CLI](https://github.com/corgibytes/freshli-cli) to analyze Python projects.

## Building and Installing

To build you'll need to have Ruby version 3.0.5 installed and run `bin/build.rb`. This will create an `exe` directory that contains the built executable. You should just be able to copy the contents of that directory or add it to your path to complete the installation. There is no binary installation provided at the moment.

## Testing

The full test suite can be run by executing `bin/test.rb`. This will first run the `pytest`-based unit test suite, and then, if the unit tests all pass, run the `cucumber`-based acceptance tests.

## Caution

I'm not super experienced with building Python executable programs. I've likely made some poor choices. Please point these out by creating issues, and I'll work on getting those addressed.

## License

This project is licensed under the [GNU Affero General Public License](./LICENSE).
