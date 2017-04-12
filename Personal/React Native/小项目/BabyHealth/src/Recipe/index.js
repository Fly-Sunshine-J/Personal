import React, {Component, PropTypes} from 'react'
import {
    View,
    Text,
    Image,
    TouchableOpacity,
    StyleSheet,
    InteractionManager,
} from 'react-native'

import Navigator from '../Common/Navigator'
import ListView from '../Common/MyListView'
import RecipeSection from '../Data/RecipeSection.json'
import RecipeItem from '../Recipe/RecipeItem'
import Model from '../Data/RecipeItemModel'


const imageSize = 60;

export class ListViewCell extends Component {
    static PropTypes = {
        data: PropTypes.object,
        push: PropTypes.func,
    }

    render() {
        return (
            <TouchableOpacity style={styles.cell} onPress={this.props.push}>
                <View style={styles.imageAndText}>
                    <Image style={this.props.data.url.indexOf('wenda') < 0 ? styles.image : [styles.image, {borderRadius: imageSize / 2}]} source={{uri: this.props.data.url.indexOf('wenda') < 0 ? this.props.data.url : this.props.data.url + '.jpg'}}/>
                    <Text>{this.props.data.name}</Text>
                </View>
                <View style={styles.indicator}>
                    <Image style={styles.indicator_right} source={{uri: 'indicator_right.png'}}/>
                </View>
            </TouchableOpacity>
        );
    }
}

class RecipeContainer extends Component {

    constructor(props) {
        super(props)
        this.state = {
            dataSource: [],
        }
    }

    componentDidMount() {
        this.setState({dataSource: RecipeSection.section})
    }

    _renderRow = (rowData, sectionID, rowID) => {
        return (
            <ListViewCell data={rowData} push={() => {this._push(rowData, rowID)}}/>
        );
    }

    _push = (rowData, rowID) =>{

        InteractionManager.runAfterInteractions(() => {
            var Items = []
            rowData.item.map((item) => {
                Items.push(Model.fromItem(item));
            })
            this.props.navigator.push({
                title: rowData.name,
                component: RecipeItem,
                passProps: {dataSource: Items},
                backButtonTitle: '返回',
                tintColor: 'white'
            })
        })
    }



    render() {
        return (
            <ListView dataSource={this.state.dataSource}
                      renderRow={this._renderRow}/>
        )
    }
}

export default class Recipe extends Component{

    render() {
        return (
            <Navigator title='每日食谱' component={RecipeContainer}/>
        )
    }
}

const styles = StyleSheet.create({
    cell: {
        height: 80,
        flexDirection: 'row',
    },
    imageAndText: {
        flex: 2,
        alignItems: 'center',
        flexDirection: 'row',
    },
    image: {
        height: imageSize,
        width: imageSize,
        marginLeft: 30,
        marginRight: 30,
    },
    indicator: {
        flex: 1,
        alignItems: 'center',
        flexDirection: 'row',
        justifyContent: 'flex-end'
    },
    indicator_right: {
        width: 18,
        height: 30,
        margin: 15,
    }
})


