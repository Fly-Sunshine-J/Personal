import React, { Component, PropTypes } from 'react'
import {
    View,
    Text,
    TouchableHighlight,
    Modal,
    StyleSheet,
    Switch,
} from 'react-native'

class ModalTest extends Component {
    constructor(props) {
        super(props);
        this.state = {
            modalVisiable: false,
        }
    }

    render() {
        return (
            <View style={{marginTop: 82}}>
                <Modal animationType={'fade'}
                       transparent={false}
                       visible={this.state.modalVisiable}
                       onRequestClose={() => {alert('Modal has been closed!')}}>
                    <View style={{marginTop: 22}}>
                        <View>
                            <Text>Hello World!</Text>
                            <TouchableHighlight onPress={() =>{this.setState({modalVisiable:!this.state.modalVisiable})}}>
                                <Text>Hide Modal</Text>
                            </TouchableHighlight>
                        </View>
                    </View>

                </Modal>
                <TouchableHighlight onPress={() => {this.setState({modalVisiable: true})}}>
                    <Text>Show Modal</Text>
                </TouchableHighlight>
            </View>
        );
    }
}

class Button extends Component {
    static propTypes = {
        onPress: React.PropTypes.func
    }
    constructor(props) {
        super(props);
        this.state = {
            active: false,
        }
    }

    render() {
        var colorStyle = {color: this.state.active ? '#fff' : '#000'}
        return (
            <TouchableHighlight onHideUnderlay={() => {this.setState({active: false})}}
                                onShowUnderlay={() => {this.setState({active: true})}}
                                onPress={this.props.onPress}
                                style={[this.props.style, styles.button]}
                                underlayColor='#a9d9d4'>
                <Text style={[colorStyle, styles.buttonText]}>{this.props.children}</Text>
            </TouchableHighlight>
        );
    }
}


export default class ModalExample extends Component {
    constructor(props) {
        super(props);
        this.state = {
            animationType: 'none',
            modalVisiable: false,
            transparent: false,
        }
    }

    _setModalVisiable(visiable) {
        this.setState({
            modalVisiable: visiable,
        })
    }

    _setAnimationType(type) {
        this.setState({
            animationType: type,
        })
    }

    _toggleTransparent() {
        this.setState({
            transparent: !this.state.transparent,
        })
    }

    render() {
        var modalBackgroundStyle = {
            backgroundColor: this.state.transparent ? 'rgba(0, 0, 0, 0.5)' : '#f5fcff',
        }
        var innerContainerTransparentStyle = this.state.transparent ? {backgroundColor: '#fff', padding: 20} : null
        var activeButtonStyle = {backgroundColor: '#ddd'};

        return (
            <View style={{marginTop: 64}}>
                <Modal animationType={this.state.animationType}
                       transparent={this.state.transparent}
                       visible={this.state.modalVisiable}
                       onRequestClose={() => {this._setModalVisiable(false)}}>
                    <View style={[styles.container, modalBackgroundStyle]}>
                        <View style={[styles.innerContainer, innerContainerTransparentStyle]}>
                            <Text>This modal was presented {this.state.animationType === 'none' ? 'widthout' : ' with'} animation</Text>
                            <Button onPress={() => {this._setModalVisiable(false)}} style={{marginTop: 10}}>Close</Button>
                        </View>
                    </View>
                </Modal>
                <View style={styles.row}>
                    <Text style={styles.rowTitle}>Animation Type</Text>
                    <Button onPress={() => this._setAnimationType('none')}
                            style={this.state.animationType === 'none' ? activeButtonStyle : {}}>
                        None
                    </Button>
                    <Button onPress={() => this._setAnimationType('slide')}
                            style={this.state.animationType === 'slide' ? activeButtonStyle : {}}>
                        Slide
                    </Button>
                    <Button onPress={() => this._setAnimationType('fade')}
                            style={this.state.animationType === 'fade' ? activeButtonStyle : {}}>
                        Fade
                    </Button>
                </View>
                <View style={styles.row}>
                    <Text style={styles.rowTitle}>Transparent</Text>
                    <Switch value={this.state.transparent} onValueChange={() => this._toggleTransparent()}/>
                </View>
                <Button onPress={() => {this._setModalVisiable(true)}}>Present</Button>
            </View>
        );
    }

}

const styles = StyleSheet.create({
    button: {
        borderRadius: 5,
        height: 44,
        flex: 1,
        alignSelf: 'stretch',
        justifyContent: 'center',
        overflow: 'hidden',
    },
    buttonText: {
        fontSize: 18,
        margin: 5,
        textAlign: 'center'
    },
    container: {
        flex: 1,
        justifyContent: 'center',
        padding: 20,
    },
    innerContainer: {
        borderRadius: 10,
        alignItems: 'center'
    },
    row: {
        alignItems: 'center',
        flex: 1,
        flexDirection: 'row',
        marginBottom: 20,
    },
    rowTitle: {
        flex: 1,
        fontWeight: 'bold',
    },
})