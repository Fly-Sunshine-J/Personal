import React, { Component } from 'react'
import {
    RefreshControl,
    View,
    Text,
    ScrollView,
    StyleSheet,
    TouchableWithoutFeedback,
} from 'react-native'

class Row extends Component {

    _onClick() {
        this.props.onClick(this.props.data);
    }
    render() {
        return (
            <TouchableWithoutFeedback onPress={() => {this._onClick()}}>
                <View style={styles.row}>
                    <Text style={styles.text}>
                        {this.props.data.text + '(' + this.props.data.clicks + ')'}
                    </Text>
                </View>
            </TouchableWithoutFeedback>
        );
    }
}

export default class RefreshControlExample extends Component {

    constructor(props) {
        super(props);
        this.state = {
            isRefreshing: false,
            loaded: 0,
            rowData: Array.from(new Array(20)).map((value, index) => {
             return ({text: 'row' + index, clicks: 0})}
            )
        }
    }

    _onClick(row) {
        console.log(row);
        row.clicks += 1;
        this.setState({
            rowData: this.state.rowData,
        })
    }

    _onRefresh() {
        this.setState({isRefreshing: true});
        setTimeout(() => {
            const rowData = Array.from(new Array(10)).map((value, index) => {
                return ({
                    text: 'Loaded row' + (this.state.loaded + index),
                    clicks: 0,
                })
            }).concat(this.state.rowData);
            this.setState({
                rowData: rowData,
                isRefreshing: false,
                loaded: this.state.loaded + 10,
            })
        }, 5000)
    }

    render() {

        var rows = this.state.rowData.map((row, index) => {
            return (<Row key={index} data={row} onClick={() => {this._onClick(row)}}/>)
        })

        return (
            <ScrollView style={styles.scrollView} refreshControl={
                <RefreshControl refreshing={this.state.isRefreshing}
                                onRefresh={() => {this._onRefresh()}}
                                tintColor='red'
                                title='正在刷新...'
                                titleColor='green'
                                colors={['#ff0000', '#00ff00', '#0000ff']}
                                progressBackgroundColor='purple'

                />
            }>
                {rows}
            </ScrollView>
        );
    }
}


const styles = StyleSheet.create({
    row: {
        borderColor: 'grey',
        borderWidth: 1,
        padding: 20,
        backgroundColor: '#3a5795',
        margin: 5,
    },
    text: {
        alignSelf: 'center',
        color: 'white',
    },
    scrollView: {
        flex: 1,
        backgroundColor: 'yellow'
    }
})