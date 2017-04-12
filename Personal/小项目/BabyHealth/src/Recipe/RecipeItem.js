import React, {Component, PropTypes} from 'react'
import {
    View,
    Text,
    Image,
    StyleSheet,
    TouchableWithoutFeedback,
    TextInput,
    PanResponder,
} from 'react-native'

import MyListView from '../Common/MyListView'
import Detail from '../Recipe/RecipeItemDetail'
import Common from '../Common/Common'

const screenWidth = Common.screenWidth

export class ListViewCell extends Component {

    static PropTypes = {
        data: PropTypes.object,
        push: PropTypes.func,
    }

    _panResponder = {};
    _previousLeft = 0;
    _cell = {};
    _cellStyle={};

    componentWillMount() {
        if (this.props.edit) {
            this._panResponder = PanResponder.create({
                onMoveShouldSetPanResponder: this._onMoveShouldSetPanResponder,
                onPanResponderMove: this._onPanResponderMove,
                onPanResponderRelease: this._onPanResponderEnd,
                onPanResponderTerminate: this._onPanResponderEnd,
            })
            this._cellStyle = {style:{
                left: this._previousLeft,
            }}
        }
    }

    // 如果View不是响应者，那么在每一个触摸点开始移动（没有停下也没有离开屏幕）时再询问一次：是否愿意响应触摸交互呢？
    _onMoveShouldSetPanResponder= (e, gestureState) => {
        const { dx } = gestureState;
        return Math.abs(dx) > 2;
    }

    // 用户正在屏幕上移动手指时（没有停下也没有离开屏幕）
    _onPanResponderMove = (e, gestureState) => {
        this._cellStyle.style.left = this._previousLeft + gestureState.dx;
        this._updataNativeStyles()
    }

    // 触摸操作结束时触发，比如"touchUp"（手指抬起离开屏幕）响应者权力已经交出。这可能是由于其他View通过
    _onPanResponderEnd = (e, gestureState) => {
        if (gestureState.dx < 0) {
            this._previousLeft = -90
        }else if(gestureState.dx > 0) {
            this._previousLeft = 0
        }
        this._cellStyle.style.left = this._previousLeft;
        this._updataNativeStyles()
    }

    componentDidMount() {
        this._updataNativeStyles();
    }

    _updataNativeStyles() {
        this._cell && this._cell.setNativeProps(this._cellStyle)
    }

    render() {
        return (

                <View style={{flex: 1}} {...this._panResponder.panHandlers}>
                    <TouchableWithoutFeedback onPress={this.props.edit && this.props.delete ? this.props.delete : null}>
                        <View style={{height: 90, width: 90, backgroundColor:'red', top: 0, right: 0, position:'absolute', opacity: this.props.edit ? 1 : 0, justifyContent: 'center', alignItems: 'center'}}>
                            <Text style={{fontSize: 20, color: 'white'}}>删除</Text>
                        </View>
                    </TouchableWithoutFeedback>
                    <TouchableWithoutFeedback onPress={this.props.push}>
                    <View  style={[styles.cell, {backgroundColor: this.props.edit ? 'rgb(255, 250, 196)' : null}]} ref={(cell) => {this._cell = cell}}>
                        <Image style={styles.image} source={{uri: this.props.data.id + '.jpg'}}/>
                        <View style={{height: 90, width: screenWidth - 140}}>
                            <Text style={{fontSize: 20, color: 'rgb(241, 82, 116)'}}>{this.props.data.name}</Text>
                            <Text style={{fontSize: 12, color: 'lightgray'}} numberOfLines={3}>{this.props.data.prompt}</Text>
                            <Text style={{fontSize: 14, color: 'gray', textAlign: 'right', paddingTop: 10}}>{'适合' + this.props.data.month + '宝宝'}</Text>
                        </View>
                        <View style={styles.indicator_view}>
                            <Image style={styles.indicator} source={{uri: 'indicator_right.png'}}/>
                        </View>
                    </View>
                    </TouchableWithoutFeedback>
                </View>
        );
    }
}


export default class RcipeItem extends Component {

    _dataSource = [];

    constructor(props) {
        super(props)
        this.state = {
            dataSource: [],
            rightButtonIcon: 'has_collect'
        }
    }

    _renderRow = (rowData, sectionID, rowID) => {
        return (
            <ListViewCell data={rowData} push={() => {this._push(rowData, rowID)}}/>
        );
    }

    _push = (rowData, rowID) =>{

        this.props.navigator.push({
            title: rowData.name,
            component: Detail,
            navigationBarHidden: true,
            passProps: {item: rowData},
        })
    }

    componentWillReceiveProps(nextProps) {
        this.setState({dataSource: nextProps.dataSource})
        this._dataSource = nextProps.dataSource;
    }

    componentDidMount() {
        this.setState({dataSource:this.props.dataSource})
        this._dataSource = this.props.dataSource;
    }

    _onChange = (event) => {
        var newDataArray = [];
        this._dataSource.map((item) => {
            if (item.name.indexOf(event.nativeEvent.text) >= 0 || item.ingredients.indexOf(event.nativeEvent.text) >= 0) {
                newDataArray.push(item)
            }
        })

        this.setState({dataSource: newDataArray});
    }

    _renderHeader = () => {
        return (
            <View style={styles.headerView}>
                <TextInput style={styles.header_textIput}
                           placeholder='输入菜名/材料名'
                           placeholderTextColor='rgb(194, 188, 195)'
                           returnKeyType='search'
                           clearButtonMode='while-editing'
                           clearTextOnFocus={true}
                           enablesReturnKeyAutomatically={true}
                           textAlign={'center'}
                           onChange={this._onChange}
                           onFocus={this._onChange}
                />
            </View>
        )
    }

    render() {
        return(
            <MyListView dataSource={this.state.dataSource}
                        renderRow={this._renderRow}
                        renderHeader={this._renderHeader}/>
        );
    }
}

const styles = StyleSheet.create({
    cell: {
        height: 90,
        flexDirection: 'row',
        alignItems: 'center',
        flex: 1,
    },
    image: {
        marginLeft: 20,
        marginRight: 10,
        height: 70,
        width: 70,
        borderRadius: 35,
    },
    TextView: {
        marginRight: 20,
        backgroundColor: 'blue',
    },
    indicator_view: {
        width: 40,
        justifyContent:'center',
        alignItems: 'center',
    },
    indicator: {
        width: 18,
        height: 30,
    },
    headerView: {
        height: 50,
        backgroundColor: 'rgb(194, 188, 195)',
        justifyContent: 'center',
        alignItems: 'center',
    },

    header_textIput: {
        backgroundColor: 'white',
        height: 30,
        marginLeft: 10,
        marginRight: 10,
        fontSize: 14,
        borderRadius: 5,
    }

})
