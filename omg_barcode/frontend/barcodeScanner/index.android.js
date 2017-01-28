import React, { Component } from 'react';
import { AppRegistry } from 'react-native';

import Header from './src/components/header';

const App = () => (
  <Header headerText={'Barcode Scanner'}/>
);

AppRegistry.registerComponent('barcodeScanner', () => App);
