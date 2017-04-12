import React, {Component} from 'react'
import {
    PanResponder,
    StyleSheet,
    View,
} from 'react-native'

var CIRCLE_SIZE = 50

export default class PanResponderExample extends Component {
    _panResponder = {};
    _previousLeft = 0;
    _previousTop = 0;
    _circleStyle = {};
    circle = {};

    //如果某个父View想要在触摸操作开始时阻止子组件成为响应者，那就应该处理onStartShouldSetResponderCapture事件并返回true值。
    _onStartShouldSetPanResponderCapture = (e, gestureState) => {
        return false
    }

    //在用户开始触摸的时候（手指刚刚接触屏幕的瞬间），是否愿意成为响应者？
    _onStartShouldSetPanResponder = (e, gestureState) => {
        return true
    }

    //如果某个父View想要在移动操作开始时阻止子组件成为响应者，那就应该处理onMoveShouldSetPanResponderCapture事件并返回true值。
    _onMoveShouldSetPanResponderCapture = (e, gestureState) => {
        return false
    }

    // 如果View不是响应者，那么在每一个触摸点开始移动（没有停下也没有离开屏幕）时再询问一次：是否愿意响应触摸交互呢？
    _onMoveShouldSetPanResponder= (e, gestureState) => {
        return true
    }

    //View现在要开始响应触摸事件了。这也是需要做高亮的时候，使用户知道他到底点到了哪里。
    _onPanResponderGrant = (e, gestureState) => {
        this._circleStyle.style.backgroundColor = 'blue'
        this._updataNativeStyles();
    }

    // 响应者现在“另有其人”而且暂时不会“放权”，请另作安排。
    _onPanResponderReject = (e, gestureState) => {

    }

    // 用户正在屏幕上移动手指时（没有停下也没有离开屏幕）
    _onPanResponderMove = (e, gestureState) => {

        this._circleStyle.style.left = this._previousLeft + gestureState.dx;
        this._circleStyle.style.top = this._previousTop + gestureState.dy;
        this._updataNativeStyles()
    }

    // 触摸操作结束时触发，比如"touchUp"（手指抬起离开屏幕）响应者权力已经交出。这可能是由于其他View通过
    _onPanResponderEnd = (e, gestureState) => {
        this._circleStyle.style.backgroundColor = 'green'
        this._previousLeft += gestureState.dx
        this._previousTop += gestureState.dy
        this._updataNativeStyles()
    }

    componentWillMount() {
        this._panResponder = PanResponder.create({
            onStartShouldSetPanResponderCapture: this._onStartShouldSetPanResponderCapture,
            onStartShouldSetPanResponder: this._onStartShouldSetPanResponder,
            onMoveShouldSetPanResponderCapture: this._onMoveShouldSetPanResponderCapture,
            onMoveShouldSetPanResponder: this._onMoveShouldSetPanResponder,
            onPanResponderGrant: this._onPanResponderGrant,
            onPanResponderReject: this._onPanResponderReject,
            onPanResponderMove: this._onPanResponderMove,
            onPanResponderRelease: this._onPanResponderEnd,
            onPanResponderTerminate: this._onPanResponderEnd,
        })

        this._previousLeft = 20;
        this._previousTop = 100;
        this._circleStyle = {
            style: {
                left: this._previousLeft,
                top: this._previousTop,
                backgroundColor: 'green'
            }
        }
    }

    componentDidMount() {
        this._updataNativeStyles();
    }

    _updataNativeStyles() {
        this.circle && this.circle.setNativeProps(this._circleStyle)
    }

    render() {
        return (
            <View style={styles.container}>
                <View style={{width: 200, height: 200, backgroundColor: 'yellow'}}>
                    <View style={styles.circle} ref={(cicle) => {this.circle = cicle}} {...this._panResponder.panHandlers}/>
                </View>
            </View>
        );
    }

}


const styles = StyleSheet.create({
    circle: {
        width: CIRCLE_SIZE,
        height: CIRCLE_SIZE,
        borderRadius: CIRCLE_SIZE / 2,
        position: 'absolute',
        left: 0,
        top: 0,
    },
    container: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
    }
})