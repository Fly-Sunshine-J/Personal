import React, {Component} from 'react'
import {
    Text,
    View,
    TouchableOpacity,
    StyleSheet,
} from 'react-native'


export default class ListViewCell extends Component {

    static propTypes = {
        data: React.PropTypes.string.isRequired,
        push: React.PropTypes.func.isRequired,
    }

    render() {
        return (
            <TouchableOpacity onPress={this.props.push}>
                <View>
                    <View style={styles.cell}>
                        <Text style={{fontSize: 18}}>{this.props.data}</Text>
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