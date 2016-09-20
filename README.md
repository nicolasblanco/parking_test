Parking lot problem
===================

Hi! This is my solution for the parking lot problem.

Executable client
-----------------

The executable client for the problem can be run via `./bin/parking_client`.

If no argument is given it will go into interactive mode where you can type commands and have direct output to the console.
If an argument is given, it should be a file name where each line is a command.

Please look at `spec/factories/commands.txt` for an example of a commands file.

Specs
-----

The solution to the challenge is provided entirely using Ruby specs.

Every class is unit tested in the `spec` folder.

Integration testing using the data provided in the challenge is found at `spec/integration_spec.rb`.

Basically the integration spec runs the command: `bin/parking_client spec/factories/commands.txt` and expects the output to be the same as `spec/factories/commands_expected_output.txt`.

All the specs should be self explanatory and also formatted as documentation, no other documentation is provided :).

Requirements
------------

* Ruby 2.3.1
* Bundler 1.12.5

Installation
------------

    bundle
    bin/rspec # To run all the specs, should be always green!
