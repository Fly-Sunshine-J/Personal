import React, { Component } from 'react'
import {
    View,
    Text,
    PickerIOS,
    StyleSheet,

} from 'react-native'

var PickerItemIOS = PickerIOS.Item;

var CAR_MAKES_AND_MODELS = {
    amc: {
        name: 'AMC',
        models: ['AMX', 'Concord', 'Eagle', 'Gremlin', 'Matador', 'Pacer'],
    },
    alfa: {
        name: 'Alfa-Romeo',
        models: ['159', '4C', 'Alfasud', 'Brera', 'GTV6', 'Giulia', 'MiTo', 'Spider'],
    },
    aston: {
        name: 'Aston Martin',
        models: ['DB5', 'DB9', 'DBS', 'Rapide', 'Vanquish', 'Vantage'],
    },
    audi: {
        name: 'Audi',
        models: ['90', '4000', '5000', 'A3', 'A4', 'A5', 'A6', 'A7', 'A8', 'Q5', 'Q7'],
    },
    austin: {
        name: 'Austin',
        models: ['America', 'Maestro', 'Maxi', 'Mini', 'Montego', 'Princess'],
    },
    borgward: {
        name: 'Borgward',
        models: ['Hansa', 'Isabella', 'P100'],
    },
    buick: {
        name: 'Buick',
        models: ['Electra', 'LaCrosse', 'LeSabre', 'Park Avenue', 'Regal',
            'Roadmaster', 'Skylark'],
    },
    cadillac: {
        name: 'Cadillac',
        models: ['Catera', 'Cimarron', 'Eldorado', 'Fleetwood', 'Sedan de Ville'],
    },
    chevrolet: {
        name: 'Chevrolet',
        models: ['Astro', 'Aveo', 'Bel Air', 'Captiva', 'Cavalier', 'Chevelle', 'Corvair', 'Corvette', 'Cruze', 'Nova', 'SS', 'Vega', 'Volt'],
    },
};

export default class PickerIOSExample extends Component {
    constructor(props) {
        super(props);
        this.state = {
            carMake: 'austin',
            modelIndex: 3,
        }
    }

    _onValueChange(itemValuem, key) {
        var newState = {};
        newState[key] = itemValuem
        this.setState(newState)
    }

    render() {
        var make = CAR_MAKES_AND_MODELS[this.state.carMake];
        var selecteionString = make.name + ' ' + make.models[this.state.modelIndex];
        return (
            <View style={{marginTop: 64}}>
                <Text>Please choose a make for your car: </Text>
                <PickerIOS selectedValue={this.state.carMake}
                           onValueChange={(itemValue) => {this._onValueChange(itemValue, 'carMake')}}>
                    {Object.keys(CAR_MAKES_AND_MODELS).map((carMake) => {
                        return (
                            <PickerIOS label = {CAR_MAKES_AND_MODELS[carMake].name} value={carMake} key={carMake}/>
                        );
                    })}
                </PickerIOS>
                <Text>Please choose a model of {make.name}: </Text>
                <PickerIOS selectedValue={this.state.modelIndex}
                           itemStyle={{fontSize: 25, color: 'red', textAlign: 'left', fontWeight: 'bold'}}
                           key={this.state.carMake}
                           onValueChange={(modelIndex) => {this._onValueChange(modelIndex, 'modelIndex')}}>
                    {make.models.map((modelName, modelIndex) => {
                        return (
                            <PickerItemIOS label={modelName} value={modelIndex} key={this.state.carMake + ' ' + modelIndex}/>
                        );
                    })}
                </PickerIOS>
                <Text>You selected: {selecteionString}</Text>

            </View>
        );
    }
}