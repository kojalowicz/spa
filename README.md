# HelloSpa

This project was generated with [Angular CLI](https://github.com/angular/angular-cli) version 9.1.0.

## Requirements
installed vagrant and docker provider for vagrant

## Deploy environment

Run `./nike_runner up` for a set-up environment.
    In environment your application will be downloaded from git repository then built, tested, containerized, published in the docker registry and on the end run. 

## Debugging environment

Run `./nike_runner up debug` for a debug module.
     Virtual machines (names - "build") will be left to debugging

## Destroy environment

Run `./nike_runner down` for a turn it down environment.

## Deploy test environment

Run `./nike_runner test` on to test your application.

## Destroy test environment

Run `./nike_runner test-down` on to test your application.

