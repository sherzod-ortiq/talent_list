# Talent list

## Description
App for listing talents and their details.

## Tech stack
Dart/Flutter
BLOC

## Architecture
Feature driven directory structure<br>
BLOC for state management and business logic<br>
Custom Dart package talent_api and custom Dart package remote_talent_api  which implements talent_api are used for providing data<br>
Custom Dart package talent_repository wraps remote_talent_api<br>


## Other notes
Run the command below in talent_api package repository after adding new model with json annotations
`dart run build_runner build`

## Demos

<p float="left">
  <img src="documentation_assets/screenshot1.png" width="259.2" height="547.2">
  <img src="documentation_assets/screenshot2.png" width="259.2" height="547.2">
</p>
<p float="left">
  <img src="documentation_assets/screenshot3.png" width="259.2" height="547.2">
  <img src="documentation_assets/screenshot4.png" width="259.2" height="547.2">
</p>
<p float="left">
  <img src="documentation_assets/screenshot5.png" width="259.2" height="547.2">
  <img src="documentation_assets/screenshot6.png" width="259.2" height="547.2">
</p>
