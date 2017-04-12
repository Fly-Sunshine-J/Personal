import React, { Component} from 'react'
import {
    Text,
    View,
    Image,
    TouchableOpacity,
} from 'react-native'

import Model from './data/model'

export default class ListViewCell extends Component {

    static propTypes = {
        data: React.PropTypes.instanceOf(Model).isRequired,
        push: React.PropTypes.func.isRequired,
    }

    render() {
        return (
            <TouchableOpacity onPress={this.props.push}>
                <View>
                    <View style={styles.cell}>
                        <Image source={this.props.data.imageSource} style={{margin: 20}}/>
                        <Text style={{fontSize: 18}}>{this.props.data.name}</Text>
                    </View>
                    <View style={{height: 1, bottom: 0, backgroundColor:'gray'}}></View>
                </View>
            </TouchableOpacity>
        );
    }

}

const styles = StyleSheet.create({
    cell: {
        height: 80,
        flexDirection: 'row',
        alignItems: 'center',
        backgroundColor: 'yellow',
    }
})