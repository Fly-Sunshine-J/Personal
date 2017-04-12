import React, {Component} from 'react'
import {
    View,
    Text,
    TouchableOpacity,
    Animated,
    ScrollView,
    StyleSheet,
    Easing,
} from 'react-native'


class Button extends Component {

    static propTypes = {
        label: React.PropTypes.string,
        onPress: React.PropTypes.func,
    }

    render() {
        return (
            <TouchableOpacity onPress={this.props.onPress}>
                <View style={{height: 40, justifyContent: 'center', margin: 10, backgroundColor: 'gray'}}>
                    <Text style={{textAlign: 'left'}}>{this.props.label}</Text>
                </View>
            </TouchableOpacity>
        );
    }
}


class Section extends Component {

    static propTypes = {
        title: React.PropTypes.string
    }

    render() {
        return (
            <View style={{margin: 10}}>
                <View style={{backgroundColor: 'rgb(244, 245, 248)'}}>
                    <Text>{this.props.title}</Text>
                </View>
                <View style={{backgroundColor: 'white'}}>
                    {this.props.children}
                </View>
            </View>
        );
    }
}

class FadeInView extends Component {

    constructor(props) {
        super(props)
        this.state = {
            fadeAnim: new Animated.Value(0),
        }
    }

    componentDidMount() {
        Animated.timing(
            this.state.fadeAnim,
            {
                toValue: 1,
                duration: 2000,
            }
        ).start();
    }

    render() {
        return(
            <Animated.View style={{opacity: this.state.fadeAnim, backgroundColor: 'red'}}>
                {this.props.children}
            </Animated.View>
        );
    }
}

class fadeInExample extends Component {
    constructor(props) {
        super(props)
        this.state = {
            show: true,
        }
    }

    render() {
        return (
            <View style={{paddingTop: 64}}>
                <Button label={this.state.show ? 'Hide' : 'Show'} onPress={() => {this.setState({show: !this.state.show})}}/>
                {this.state.show && <FadeInView>
                    <View style={styles.content}>
                        <Text>FadeInView</Text>
                    </View>
                </FadeInView>}
            </View>
        );
    }
}


class TransformBounce extends Component {
    render() {
        this.anim = this.anim || new Animated.Value(0);
        return(
            <View style={{paddingTop: 64}}>
                <Button label='Press to Fling it!' onPress={() => {
                    Animated.spring(
                        this.anim,
                        {
                            toValue: 0,
                            velocity: 3,
                            tension: -10,
                            friction: 1,
                        }
                    ).start()
                }}/>
                <Animated.View style={[styles.content, {transform: [
                    {scale: this.anim.interpolate({
                        inputRange: [0, 1],
                        outputRange: [1, 4],
                    })},
                    {translateX: this.anim.interpolate({
                        inputRange: [0, 1],
                        outputRange: [0, 500],
                    })},
                    {rotate: this.anim.interpolate({
                        inputRange: [0, 1],
                        outputRange: ['0deg', '360deg'],
                    })}
                ]}]}>
                    <Text>Tranforms</Text>
                </Animated.View>
            </View>
        );
    }
}

class ComppsiteAnimations extends Component {

    render() {
        this.anims = this.anims || [1, 2, 3].map(() => {return new Animated.Value(0)})
        return (
            <View style={{paddingTop: 64}}>
                <Button label='Press to Animate' onPress={() => {
                    var timing = Animated.timing;
                    Animated.sequence([
                        timing(this.anims[0], {toValue: 200, easing: Easing.linear}),
                        Animated.delay(400),
                        timing(this.anims[0], {toValue: 0, easing: Easing.elastic(2)}),
                        Animated.delay(400),
                        Animated.stagger(200, this.anims.map((anim) => {
                            return timing(anim, {toValue: 200})
                        }).concat(this.anims.map((anim) => {
                            return timing(anim, {toValue: 0})
                            }))
                        ),
                        Animated.delay(400),
                        Animated.parallel([
                            Easing.inOut(Easing.quad),
                            Easing.back(1.5),
                            Easing.ease
                        ].map((easing, ii) => {
                            return timing(this.anims[ii], {toValue: 320, easing, duration: 3000})
                        })),
                        Animated.delay(400),
                        Animated.stagger(200, this.anims.map((anim) => {
                            return timing(anim, {toValue: 0, easing: Easing.bounce, duration: 2000})
                        }))
                    ]).start()
                }}/>
                {['Composite', 'Easing', 'Animations!'].map((text, ii) => {
                    return (
                        <Animated.View key={text} style={[styles.content, {left: this.anims[ii]}]}>
                            <Text>{text}</Text>
                        </Animated.View>
                    )
                })}
            </View>
        );
    }
}

export default class AnimatedExample extends Component {

    render() {
        return (
            <ScrollView>
                <Button label='FadeInView' onPress={() => {
                    this.props.navigator.push({
                        title: 'FadeInExample',
                        component: fadeInExample
                    })
                }}/>
                <Button label='TransformBounce' onPress={() => {
                    this.props.navigator.push({
                        title: 'TransformBounce',
                        component: TransformBounce,
                    })
                }}/>
                <Button label='Composite Animations with Easing' onPress={() => {
                    this.props.navigator.push({
                        title: 'Composite Animations',
                        component: ComppsiteAnimations,
                    })
                }}/>
            </ScrollView>
        );
    }
}


var styles = StyleSheet.create({
    content: {
        backgroundColor: 'deepskyblue',
        borderWidth: 1,
        borderColor: 'dodgerblue',
        padding: 20,
        margin: 20,
        borderRadius: 10,
        alignItems: 'center',
    },
});

